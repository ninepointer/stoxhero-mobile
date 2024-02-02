import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';
import '../widgets/upcoming_share_model_content.dart';

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
  bool isUserInterestedId = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ContestController>();
    isUserInterestedId = controller.isUserInterested(
      widget.contest,
      widget.userId,
    );
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
      remainingTime = startTimeDateTime.isAfter(currentTime)
          ? startTimeDateTime.difference(currentTime)
          : Duration.zero;
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
              if (remainingTime == Duration.zero) {
                controller.getUpComingContestList();
                controller.getLiveContestList();
              }
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
    return Visibility(
      visible: !isVisible,
      replacement: SizedBox(),
      child: CommonCard(
        margin: widget.margin,
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.031,
                        right: MediaQuery.of(context).size.width * 0.031,
                        top: MediaQuery.of(context).size.width * 0.0204),
                    child: Text(
                      widget.contest?.contestName ?? '-',
                      style: AppStyles.tsSecondaryMedium14,
                    ),
                  ),
                ),
                Container(
                  height: 15,
                  child: InkWell(
                    onTap: () {
                      BottomSheetHelper.openBottomSheet(
                        context: context,
                        child: RewardTableBottomSheet(
                          upcomingContest: widget.contest,
                        ),
                      );
                    },
                    child: Container(
                      padding: widget.contest?.featured == true
                          ? EdgeInsets.only(
                              right:
                                  MediaQuery.of(context).size.width * 0.06337)
                          : EdgeInsets.only(
                              right:
                                  MediaQuery.of(context).size.width * 0.0127),
                      child: Icon(
                        Icons.info,
                        size: 20.0,
                        color: Colors.grey, // Icon color
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.contest?.featured == true,
                  child: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.0306),
                    foregroundDecoration: CommonTriangleCard(
                      badgeColor: AppColors.success,
                      badgeSize: 55,
                      textSpan: TextSpan(
                        text: 'Featured',
                        style: AppStyles.tsWhiteMedium12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0204),
            child: Row(
              children: [
                Visibility(
                  visible: widget.contest?.isNifty == true,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.0102,
                        vertical: MediaQuery.of(context).size.width * 0.0051),
                    child: Text(
                      'Nifty',
                      style: AppStyles.tsGreyMedium12,
                    ),
                  ),
                ),
                // SizedBox(width: 2),
                Visibility(
                  visible: widget.contest?.isBankNifty == true,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.0102,
                        vertical: MediaQuery.of(context).size.width * 0.0051),
                    child: Text(
                      'Bank Nifty',
                      style: AppStyles.tsGreyMedium12,
                    ),
                  ),
                ),
                // SizedBox(width: 4),
                Visibility(
                  visible: widget.contest?.isFinNifty == true,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.0102,
                        vertical: MediaQuery.of(context).size.width * 0.0051),
                    child: Text(
                      'FinNifty',
                      style: AppStyles.tsGreyMedium12,
                    ),
                  ),
                ),
                // SizedBox(width: 4),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.0102,
                      vertical: 0),
                  child: Text(
                    widget.contest?.contestExpiry ?? '',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
          Container(
            height: MediaQuery.of(context).size.width * 0.08928,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Padding(padding: EdgeInsets.only(left: 2)),

                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Row(children: [
                      if (widget.contest?.payoutType == 'Reward') ...[
                        if (widget.contest?.rewardType == "Goodies")
                          Container(
                            width: controller.liveContestList.length == 1
                                ? MediaQuery.of(context).size.width * 0.9
                                : MediaQuery.of(context).size.width * 0.9 - 55,
                            child: Row(
                              children: [
                                Image.asset(
                                  AppImages.contestTrophy,
                                  width: MediaQuery.of(context).size.width *
                                      0.0765,
                                  height: MediaQuery.of(context).size.width *
                                      0.0510,
                                ),
                                Flexible(
                                  child: Text(
                                    "1st rank wins ${controller.calculateTotalReward(widget.contest?.rewards)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .tsGreyRegular12,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Row(
                            children: [
                              Image.asset(
                                AppImages.contestTrophy,
                                width:
                                    MediaQuery.of(context).size.width * 0.0765,
                                height:
                                    MediaQuery.of(context).size.width * 0.0510,
                              ),
                              Text(
                                'Rewards worth ${controller.calculateTotalReward(widget.contest?.rewards)}',
                                style:
                                    Theme.of(context).textTheme.tsGreyRegular12,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                      ],
                      if (widget.contest?.payoutType != 'Reward') ...[
                        if (widget.contest?.payoutCapPercentage != null &&
                            widget.contest?.payoutCapPercentage != 0)
                          Row(
                            children: [
                              Image.asset(
                                AppImages.contestTrophy,
                                width:
                                    MediaQuery.of(context).size.width * 0.0765,
                                height:
                                    MediaQuery.of(context).size.width * 0.0510,
                              ),
                              Text(
                                  '${widget.contest?.payoutPercentage != null ? widget.contest?.payoutPercentage : '0'}% of the Net P&L(upto ${controller.getPaidCapAmount(
                                    widget.contest?.entryFee == 0
                                        ? widget.contest?.portfolio
                                                ?.portfolioValue ??
                                            0
                                        : widget.contest?.entryFee ?? 0,
                                    widget.contest?.payoutCapPercentage ?? 0,
                                  )})',
                                  style: Theme.of(context)
                                      .textTheme
                                      .tsGreyRegular12),
                            ],
                          ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                      ]
                    ]),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
          // Divider(thickness: 1, height: 0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.0306,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Virtual Margin',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          SizedBox(height: 2),
                          Text(
                            FormatHelper.formatNumbers(
                              widget.contest?.portfolio?.portfolioValue,
                              decimal: 0,
                            ),
                            style: Theme.of(context).textTheme.tsMedium12,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${remainingTime.inDays}D ${remainingTime.inHours.remainder(24)}H ${remainingTime.inMinutes.remainder(60)}M ${remainingTime.inSeconds.remainder(60)}S',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Entry Fee',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          SizedBox(height: 2),
                          Text(
                            widget.contest?.entryFee == 0
                                ? 'Free'
                                : FormatHelper.formatNumbers(
                                    widget.contest?.entryFee,
                                    decimal: 0,
                                  ),
                            style: Theme.of(context).textTheme.tsMedium12,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0204),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Starts:${FormatHelper.formatDateTimeWithoutYearToIST(widget.contest?.contestStartTime)}',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Rubik'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Spots left:',
                            style: Theme.of(context).textTheme.tsRegular12,
                          ),
                          Text(
                            '${controller.calculateSeatsLeft(
                                  widget.contest?.maxParticipants ?? 0,
                                  widget.contest?.participants?.length ?? 0,
                                ).toString()}',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Rubik'),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Ends:${FormatHelper.formatDateTimeWithoutYearToIST(widget.contest?.contestEndTime)}',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Rubik'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
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
                        isUserInterestedId = true;
                        SnackbarHelper.showSnackbar(
                            'Thanks for showing interest in ${widget.contest?.contestName} You will be notified once the TestZone starts');
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
                    onTap: (controller.checkIfPurchased(
                                    widget.contest, widget.userId) ||
                                widget.contest?.entryFee == 0) &&
                            controller.calculateSeatsLeft(
                                    widget.contest?.maxParticipants ?? 0,
                                    widget.contest?.participants?.length ?? 0) >
                                0
                        ? () => SnackbarHelper.showSnackbar(
                            'The TestZone has not started yet!')
                        : () async {
                            if (controller.calculateSeatsLeft(
                                    widget.contest?.maxParticipants ?? 0,
                                    widget.contest?.participants?.length ??
                                        0) ==
                                0) {
                              SnackbarHelper.showSnackbar('TestZone is Full');
                            } else {
                              BottomSheetHelper.openBottomSheet(
                                context: context,
                                child: PaymentBottomSheet(
                                  productType: ProductType.contest,
                                  productId: widget.contest?.id ?? '',
                                  buyItemPrice: widget.contest?.entryFee ?? 0,
                                  onPaymentSuccess:
                                      controller.loadDataAfterPaymentSuccess,
                                  onSubmit: () {
                                    Get.back();
                                    var walletController =
                                        Get.find<WalletController>();
                                    var data = {
                                      "bonusRedemption":
                                          walletController.isHeroCashAdded.value
                                              ? walletController
                                                  .heroCashAmount.value
                                              : 0,
                                      "coupon": walletController
                                          .couponCodeTextController.text,
                                      "contestFee": walletController
                                          .subscriptionAmount.value,
                                      "contestId": widget.contest?.id,
                                      "contestName":
                                          widget.contest?.contestName,
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
                            : (controller.checkIfPurchased(
                                            widget.contest, widget.userId) ||
                                        widget.contest?.entryFee == 0) &&
                                    controller.calculateSeatsLeft(
                                            widget.contest?.maxParticipants ??
                                                0,
                                            widget.contest?.participants
                                                    ?.length ??
                                                0) >
                                        0
                                ? 'Purchased'
                                : controller.calculateSeatsLeft(
                                            widget.contest?.maxParticipants ??
                                                0,
                                            widget.contest?.participants
                                                    ?.length ??
                                                0) ==
                                        0
                                    ? 'TestZone Full'
                                    : 'Book Now',
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: UpComingShareModalContent(
                              contest: widget.contest,
                            ),
                          );
                        },
                      );
                      // controller.getShareContest(true);
                      // String url = 'https://stoxhero.com/testzone';
                      // Clipboard.setData(ClipboardData(text: url));
                      // SnackbarHelper.showSnackbar(
                      //     'Link Copied, Share with your friends.');
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
