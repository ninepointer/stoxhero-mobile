import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';
import 'package:stoxhero/src/modules/contest/contest_index.dart';

import '../../../core/core.dart';

class UpComingContestCard extends StatefulWidget {
  final UpComingContest? contest;
  final EdgeInsets? margin;

  const UpComingContestCard({
    Key? key,
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

  @override
  Widget build(BuildContext context) {
    bool isUserInterestedId = controller.isUserInterested(
      widget.contest,
      controller.userDetails.value.sId,
    );
    return Visibility(
      visible: !isVisible,
      replacement: SizedBox(),
      child: CommonCard(
        margin: widget.margin,
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.contest?.contestName ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                          width: 40,
                        ),
                        Text(
                          'Reward',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        Text(
                          '${widget.contest?.payoutPercentage}% of the Net P&L',
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Remaining Time',
                            style: AppStyles.tsGreyMedium12,
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
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isUserInterestedId) {
                        SnackbarHelper.showSnackbar('Already interested in ${widget.contest?.contestName}');
                      } else {
                        controller.upComingContest(widget.contest);
                        controller.getNotified();
                        SnackbarHelper.showSnackbar('You are now interested in ${widget.contest?.contestName}');
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.25),
                      ),
                      child: Text(
                        isUserInterestedId ? 'Notified' : 'Get Notified',
                        style: AppStyles.tsPrimaryMedium12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (controller.checkIfPurchased(widget.contest) || widget.contest?.entryFee == 0) &&
                            controller.calculateSeatsLeft(
                                    widget.contest?.maxParticipants ?? 0, widget.contest?.participants?.length ?? 0) >
                                0
                        ? () {}
                        : () async {
                            if (controller.calculateSeatsLeft(
                                    widget.contest?.maxParticipants ?? 0, widget.contest?.participants?.length ?? 0) ==
                                0) {
                              SnackbarHelper.showSnackbar('Contest is Full');
                            } else {
                              BottomSheetHelper.openBottomSheet(
                                context: context,
                                child: PurchaseItemBottomSheet(
                                  buyItemPrice: widget.contest?.entryFee ?? 0,
                                  onSubmit: () {
                                    Get.back();
                                    var data = {
                                      "bonusRedemption": 0,
                                      "coupon": "",
                                      "contestFee": widget.contest?.entryFee,
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
                            : (controller.checkIfPurchased(widget.contest) || widget.contest?.entryFee == 0) &&
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
                      SnackbarHelper.showSnackbar('Share Link with your Friends');
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
