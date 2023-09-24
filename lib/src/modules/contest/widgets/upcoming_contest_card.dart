import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';
import 'package:stoxhero/src/modules/contest/contest_index.dart';

import '../../../core/core.dart';

class UpComingContestCard extends StatefulWidget {
  final UpComingContest? upComingContest;

  const UpComingContestCard({
    Key? key,
    this.upComingContest,
  }) : super(key: key);

  @override
  State<UpComingContestCard> createState() => _UpComingContestCardState();
}

class _UpComingContestCardState extends State<UpComingContestCard> {
  late DateTime startTimeDateTime;
  late Duration remainingTime;
  late ContestController controller;
  late Timer timer;

  @override
  void initState() {
    controller = Get.find<ContestController>();
    updateRemainingTime();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateRemainingTime() {
    DateTime currentTime = DateTime.now();
    startTimeDateTime = DateTime.parse(widget.upComingContest?.contestStartTime ?? '');

    setState(() {
      remainingTime =
          startTimeDateTime.isAfter(currentTime) ? startTimeDateTime.difference(currentTime) : Duration.zero;
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
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.upComingContest?.contestName ?? '-',
                  style: AppStyles.tsSecondaryMedium16,
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
                visible: widget.upComingContest?.isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                visible: widget.upComingContest?.isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                visible: widget.upComingContest?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  widget.upComingContest?.contestExpiry ?? '',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
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
                          style: AppStyles.tsGreyRegular12,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${widget.upComingContest?.maxParticipants}',
                          style: Theme.of(context).textTheme.tsMedium14,
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
                        style: AppStyles.tsGreyRegular12,
                      ),
                      Text(
                        '${widget.upComingContest?.payoutPercentage} % of the net P&L',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Remaining',
                          style: AppStyles.tsGreyRegular12,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${remainingTime.inDays} days \n${remainingTime.inHours.remainder(24)} hrs \n${remainingTime.inMinutes.remainder(60)} mins \n${remainingTime.inSeconds.remainder(60)} secs',
                          style: Theme.of(context).textTheme.tsMedium14,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date & Time',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatDateTimeToIST(widget.upComingContest?.contestStartTime),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'End Date & Time',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatDateTimeToIST(widget.upComingContest?.contestEndTime),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entry Fees',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.upComingContest?.entryFee == 0
                            ? 'Free'
                            : FormatHelper.formatNumbers(widget.upComingContest?.entryFee, decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Portfolio',
                        style: AppStyles.tsGreyRegular12,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatNumbers(widget.upComingContest?.portfolio?.portfolioValue, decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Get Notified',
                    style: AppStyles.tsPrimaryMedium14,
                  ),
                ),
              ),
            ),
            if (widget.upComingContest?.entryFee != 0)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.calculateUserWalletAmount();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ContestBuySubscriptionBottomSheet(),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(.25),
                    ),
                    child: Text(
                      'Pay Now',
                      style: AppStyles.tsWhiteMedium14.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // controller.calculateUserWalletAmount();
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (context) => ContestBuySubscriptionBottomSheet(),
                    // );
                    // Get.to(() => ContestDashboardView());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(.25),
                    ),
                    child: Text(
                      'Start Trading',
                      style: AppStyles.tsWhiteMedium14.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Share',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
