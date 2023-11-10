import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/app.dart';

class UpcomingFeaturedCard extends StatefulWidget {
  final UpcomingFeatured? upcomingFeatured;
  final String userId;
  const UpcomingFeaturedCard({
    Key? key,
    this.upcomingFeatured,
    required this.userId,
  }) : super(key: key);

  @override
  State<UpcomingFeaturedCard> createState() => _UpcomingFeaturedCardState();
}

class _UpcomingFeaturedCardState extends State<UpcomingFeaturedCard> {
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
    startTimeDateTime = DateTime.parse(widget.upcomingFeatured?.contestStartTime ?? '');

    setState(() {
      remainingTime =
          startTimeDateTime.isAfter(currentTime) ? startTimeDateTime.difference(currentTime) : Duration.zero;
      isVisible = remainingTime == Duration.zero;
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
      margin: EdgeInsets.only(left: 12, right: 12, top: 8),
      padding: EdgeInsets.only(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(.1),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      AppImages.contestTrophy,
                      width: 28,
                      height: 28,
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.upcomingFeatured?.contestName}',
                        style: Theme.of(context).textTheme.tsRegular16,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.upcomingFeatured?.payoutPercentage != null ? widget.upcomingFeatured?.payoutPercentage : '0'}% of the Net P&L',
                            style: Theme.of(context).textTheme.tsSecondaryMedium14,
                          ),
                          if (widget.upcomingFeatured?.payoutCapPercentage != null &&
                              widget.upcomingFeatured?.payoutCapPercentage != 0)
                            Text(
                              ' (Upto ${controller.getPaidCapAmount(
                                widget.upcomingFeatured?.entryFee == 0
                                    ? widget.upcomingFeatured?.portfolio?.portfolioValue ?? 0
                                    : widget.upcomingFeatured?.entryFee ?? 0,
                                widget.upcomingFeatured?.payoutCapPercentage ?? 0,
                              )})',
                              style: Theme.of(context).textTheme.tsSecondaryMedium14,
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonCardTile(
                          label: 'Starts',
                          value: FormatHelper.formatDateTimeOnlyToIST(widget.upcomingFeatured?.contestStartTime),
                        ),
                        SizedBox(height: 4),
                        CommonCardTile(
                          label: 'Ends',
                          value: FormatHelper.formatDateTimeOnlyToIST(widget.upcomingFeatured?.contestEndTime),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.grey.withOpacity(.1),
                    ),
                    child: Text(
                      widget.upcomingFeatured?.entryFee == 0
                          ? 'Free'
                          : FormatHelper.formatNumbers(widget.upcomingFeatured?.entryFee, decimal: 0),
                      style: Theme.of(context).textTheme.tsMedium18.copyWith(
                            color: AppColors.success,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(.25),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              '${remainingTime.inDays}Days ${remainingTime.inHours.remainder(24)}Hours ${remainingTime.inMinutes.remainder(60)}Minutes ${remainingTime.inSeconds.remainder(60)}Seconds',
              style: AppStyles.tsSecondaryMedium14.copyWith(
                color: AppColors.success.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
