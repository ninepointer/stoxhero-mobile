import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../data/models/response/upcoming_marginx_list_response.dart';

class UpcomingMarginxCard extends StatefulWidget {
  final UpcomingMarginX? marginx;
  UpcomingMarginxCard({
    Key? key,
    this.marginx,
  }) : super(key: key);

  @override
  State<UpcomingMarginxCard> createState() => _UpcomingMarginxCardState();
}

class _UpcomingMarginxCardState extends State<UpcomingMarginxCard> {
  late DateTime startTimeDateTime;
  late Duration remainingTime;
  late MarginXController controller;
  late Timer timer;
  @override
  void initState() {
    controller = Get.find<MarginXController>();
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
    startTimeDateTime = DateTime.parse(widget.marginx?.startTime ?? '');

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
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.marginx?.marginXName ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => MarginxInfoBottomSheet(),
                  );
                },
                icon: Icon(
                  Icons.info_outline_rounded,
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
                visible: widget.marginx?.isNifty == true,
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
                visible: widget.marginx?.isBankNifty == true,
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
                visible: widget.marginx?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.info,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'Finnifty',
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
                  widget.marginx?.marginXExpiry ?? '',
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
                                widget.marginx?.maxParticipants ?? 0,
                                widget.marginx?.participants?.length ?? 0,
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
                        '% of your Investment',
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
                        FormatHelper.formatDateTimeToIST(widget.marginx?.startTime),
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
                        FormatHelper.formatDateTimeToIST(widget.marginx?.endTime),
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
                        'Investment',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(widget.marginx?.marginXTemplate?.entryFee, decimal: 0),
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
                        FormatHelper.formatNumbers(widget.marginx?.marginXTemplate?.portfolioValue, decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Get.to(() => ViewCard(upcomingMarginX: widget.marginx)),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'View',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: controller.checkIfPurchased(widget.marginx) &&
                        controller.calculateSeatsLeft(
                                widget.marginx?.maxParticipants ?? 0, widget.marginx?.participants?.length ?? 0) >
                            0
                    ? () {}
                    : () {
                        if (controller.calculateSeatsLeft(
                                widget.marginx?.maxParticipants ?? 0, widget.marginx?.participants?.length ?? 0) ==
                            0) {
                          SnackbarHelper.showSnackbar('MarginX is Full');
                        } else {
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: PurchaseItemBottomSheet(
                              buyItemPrice: widget.marginx?.marginXTemplate?.entryFee ?? 0,
                              onSubmit: () {
                                Get.back();
                                var data = {
                                  "entryFee": widget.marginx?.marginXTemplate?.entryFee,
                                  "marginXId": widget.marginx?.id,
                                  "marginXName": widget.marginx?.marginXName,
                                };
                                controller.purchaseMarginX(data);
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
                    controller.checkIfPurchased(widget.marginx) &&
                            controller.calculateSeatsLeft(
                                    widget.marginx?.maxParticipants ?? 0, widget.marginx?.participants?.length ?? 0) >
                                0
                        ? 'Purchased'
                        : controller.calculateSeatsLeft(
                                    widget.marginx?.maxParticipants ?? 0, widget.marginx?.participants?.length ?? 0) ==
                                0
                            ? 'MarginX Full'
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
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Share',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.secondary.shade600,
                    ),
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
