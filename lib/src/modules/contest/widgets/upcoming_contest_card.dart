import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class UpComingContestCard extends StatefulWidget {
  final String userId;
  final UpComingContest? contest;
  final EdgeInsets? margin;

  const UpComingContestCard({
    Key? key,
    required this.userId,
    this.contest,
    this.margin,
  }) : super(key: key);

  @override
  State<UpComingContestCard> createState() => _UpComingContestCardState();
}

class _UpComingContestCardState extends State<UpComingContestCard> {
  late DateTime startTimeDateTime;
  late Duration remainingTime;
  late ContestController controller;
  late Timer timer;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ContestController>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateRemainingTime();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateRemainingTime() {
    DateTime currentTime = DateTime.now();
    startTimeDateTime = DateTime.parse(widget.contest?.contestStartTime ?? '');

    setState(() {
      remainingTime =
          startTimeDateTime.isAfter(currentTime) ? startTimeDateTime.difference(currentTime) : Duration.zero;
      isVisible = remainingTime == Duration.zero;
      log(isVisible.toString());
    });

    timer = Timer.periodic(
      Duration(seconds: 1),
      (_) {
        if (mounted) {
          setState(
            () {
              remainingTime = startTimeDateTime.isAfter(DateTime.now())
                  ? startTimeDateTime.difference(DateTime.now())
                  : Duration.zero;
            },
          );
        }
      },
    );
  }

  Widget getContestImage() {
    if (widget.contest?.contestName == "Muhurat Trading - 12th Nov(6:15 PM)") {
      return Image.asset(
        AppImages.diya,
        width: 48,
      );
    } else {
      return Image.asset(
        AppImages.contestTrophy,
        width: 36,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isUserInterestedId = controller.isUserInterested(
      widget.contest,
      widget.userId,
    );
    return Visibility(
      visible: !isVisible,
      replacement: SizedBox(),
      child: CommonCard(
        margin: widget.margin,
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      widget.contest?.contestName ?? '-',
                      style: AppStyles.tsSecondaryMedium14,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.contest?.featured == true,
                  child: Container(
                    padding: EdgeInsets.all(18),
                    foregroundDecoration: CommonTriangleCard(
                      badgeColor: AppColors.success,
                      badgeSize: 62,
                      textSpan: TextSpan(
                        text: 'Featured',
                        style: AppStyles.tsWhiteMedium12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Visibility(
                  visible: widget.contest?.isNifty == true,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      'Nifty',
                      style: AppStyles.tsWhiteMedium12,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Visibility(
                  visible: widget.contest?.isBankNifty == true,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      'Bank Nifty',
                      style: AppStyles.tsWhiteMedium12,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Visibility(
                  visible: widget.contest?.isFinNifty == true,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.info,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      'FinNifty',
                      style: AppStyles.tsWhiteMedium12,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.danger,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    widget.contest?.contestExpiry ?? '',
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Divider(thickness: 1, height: 0),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No. of Seats left',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          SizedBox(height: 2),
                          Text(
                            controller
                                .calculateSeatsLeft(
                                  widget.contest?.maxParticipants ?? 0,
                                  widget.contest?.participants?.length ?? 0,
                                )
                                .toString(),
                            style: Theme.of(context).textTheme.tsMedium12,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Image.asset(
                          AppImages.contestTrophy,
                          width: 36,
                        ),
                        Text(
                          'Reward',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        GestureDetector(
                          onTap: () {
                            BottomSheetHelper.openBottomSheet(
                              context: context,
                              child: RewardTableBottomSheet(
                                upcomingContest: widget.contest,
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.contest?.payoutType == 'Reward') ...[
                                Text(
                                  'Rewards worth ${controller.calculateTotalReward(widget.contest?.rewards)},Click to know more.',
                                  style: Theme.of(context).textTheme.tsMedium12,
                                  textAlign: TextAlign.center,
                                )
                              ],
                              if (widget.contest?.payoutType != 'Reward') ...[
                                Text(
                                  '${widget.contest?.payoutPercentage != null ? widget.contest?.payoutPercentage : '0'}% of the Net P&L',
                                  style: Theme.of(context).textTheme.tsMedium12,
                                ),
                                if (widget.contest?.payoutCapPercentage != null &&
                                    widget.contest?.payoutCapPercentage != 0)
                                  Text(
                                    ' (Upto ${controller.getPaidCapAmount(
                                      widget.contest?.entryFee == 0
                                          ? widget.contest?.portfolio?.portfolioValue ?? 0
                                          : widget.contest?.entryFee ?? 0,
                                      widget.contest?.payoutCapPercentage ?? 0,
                                    )}) Click to know more.',
                                    style: Theme.of(context).textTheme.tsMedium12,
                                  ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Remaining Time',
                            style: AppStyles.tsGreyMedium12,
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 2),
                          Text(
                            '${remainingTime.inDays}D ${remainingTime.inHours.remainder(24)}H ${remainingTime.inMinutes.remainder(60)}M ${remainingTime.inSeconds.remainder(60)}S',
                            style: Theme.of(context).textTheme.tsMedium12,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Starts',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          FormatHelper.formatDateTimeToIST(widget.contest?.contestStartTime),
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Ends',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          FormatHelper.formatDateTimeToIST(widget.contest?.contestEndTime),
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Entry Fee',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          widget.contest?.entryFee == 0
                              ? 'Free'
                              : FormatHelper.formatNumbers(widget.contest?.entryFee, decimal: 0),
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Virtual Margin Money',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          FormatHelper.formatNumbers(widget.contest?.portfolio?.portfolioValue, decimal: 0),
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Row(
              children: [
                Visibility(
                  visible: !isUserInterestedId,
                  child: Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.upComingContest(widget.contest);
                        controller.getNotified();
                        SnackbarHelper.showSnackbar(
                            'Thanks for showing interest in ${widget.contest?.contestName} You will be notified once the contest starts');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(.25),
                        ),
                        child: Text(
                          isUserInterestedId ? '' : 'Get Notified',
                          style: AppStyles.tsPrimaryMedium12,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (controller.checkIfPurchased(widget.contest, widget.userId) ||
                                widget.contest?.entryFee == 0) &&
                            controller.calculateSeatsLeft(
                                    widget.contest?.maxParticipants ?? 0, widget.contest?.participants?.length ?? 0) >
                                0
                        ? () => SnackbarHelper.showSnackbar('The Contest has not started yet!')
                        : () async {
                            if (controller.calculateSeatsLeft(
                                    widget.contest?.maxParticipants ?? 0, widget.contest?.participants?.length ?? 0) ==
                                0) {
                              SnackbarHelper.showSnackbar('Contest is Full');
                            } else {
                              BottomSheetHelper.openBottomSheet(
                                context: context,
                                child: PaymentBottomSheet(
                                  productType: ProductType.contest,
                                  productId: widget.contest?.id ?? '',
                                  buyItemPrice: widget.contest?.entryFee ?? 0,
                                  onPaymentSuccess: controller.loadDataAfterPaymentSuccess,
                                  onSubmit: () {
                                    Get.back();
                                    var walletController = Get.find<WalletController>();
                                    var data = {
                                      "bonusRedemption": 0,
                                      "coupon": walletController.couponCodeTextController.text,
                                      "contestFee": walletController.subscriptionAmount.value,
                                      "contestId": widget.contest?.id,
                                      "contestName": widget.contest?.contestName,
                                    };
                                    controller.purchaseContest(data);
                                  },
                                ),
                              );
                            }
                          },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(.25),
                      ),
                      child: Text(
                        widget.contest?.entryFee == 0
                            ? 'Start Trading'
                            : (controller.checkIfPurchased(widget.contest, widget.userId) ||
                                        widget.contest?.entryFee == 0) &&
                                    controller.calculateSeatsLeft(widget.contest?.maxParticipants ?? 0,
                                            widget.contest?.participants?.length ?? 0) >
                                        0
                                ? 'Purchased'
                                : controller.calculateSeatsLeft(widget.contest?.maxParticipants ?? 0,
                                            widget.contest?.participants?.length ?? 0) ==
                                        0
                                    ? 'Contest Full'
                                    : 'Pay Now',
                        style: AppStyles.tsWhiteMedium12.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.upComingContest(widget.contest);
                      controller.getShareContest(true);
                      String url = 'https://stoxhero.com/contest';
                      Clipboard.setData(ClipboardData(text: url));
                      SnackbarHelper.showSnackbar('Link Copied, Share with your friends.');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(.25),
                      ),
                      child: Text(
                        'Share',
                        style: AppStyles.tsSecondaryMedium12.copyWith(
                          color: AppColors.secondary.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
