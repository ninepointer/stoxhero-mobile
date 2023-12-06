import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      remainingTime = startTimeDateTime.isAfter(currentTime)
          ? startTimeDateTime.difference(currentTime)
          : Duration.zero;
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
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.only(left: 12, right: 12, top: 8),
                  child: Text(
                    widget.marginx?.marginXName ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     BottomSheetHelper.openBottomSheet(
              //       context: context,
              //       child: MarginxInfoBottomSheet(),
              //     );
              //   },
              //   icon: Icon(
              //     Icons.info_outline_rounded,
              //   ),
              // ),
              Container(
                height: 15, // Adjust the height as needed
                child: InkWell(
                  onTap: () {
                    BottomSheetHelper.openBottomSheet(
                      context: context,
                      child: MarginxInfoBottomSheet(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.info,
                      size: 20.0,
                      color: Colors.grey, // Icon color
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Visibility(
                visible: widget.marginx?.isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    'Nifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 2),
              Visibility(
                visible: widget.marginx?.isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    'Bank Nifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 2),
              Visibility(
                visible: widget.marginx?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    'Finnifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  widget.marginx?.marginXExpiry ?? '',
                  style: AppStyles.tsGreyMedium12,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.contestTrophy,
              width: 30,
              height: 20,
            ),
            Text(
              '% of your Investment',
              style: Theme.of(context).textTheme.tsMedium12,
            ),
          ],
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Virtual Margin',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(
                            widget.marginx?.marginXTemplate?.portfolioValue,
                            decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${remainingTime.inDays}D ${remainingTime.inHours.remainder(24)}H ${remainingTime.inMinutes.remainder(60)}M ${remainingTime.inSeconds.remainder(60)}S',
                        // style: Theme.of(context).textTheme.tsMedium12,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Entry Fee',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(
                            widget.marginx?.marginXTemplate?.entryFee,
                            decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Starts: ${FormatHelper.formatDateTimeWithoutYearToIST(widget.marginx?.startTime)}',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Rubik'),
                  ),
                  Row(
                    children: [
                      Text(
                        'Spots left:',
                        style: Theme.of(context).textTheme.tsRegular12,
                      ),
                      Text(
                        controller
                            .calculateSeatsLeft(
                              widget.marginx?.maxParticipants ?? 0,
                              widget.marginx?.participants?.length ?? 0,
                            )
                            .toString(),
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Rubik'),
                      )
                    ],
                  ),
                  Text(
                    'Ends: ${FormatHelper.formatDateTimeWithoutYearToIST(widget.marginx?.endTime)}',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Rubik'),
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
                onTap: () =>
                    Get.to(() => ViewCard(upcomingMarginX: widget.marginx)),
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
                    'View Details',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: controller.checkIfPurchased(widget.marginx) &&
                        controller.calculateSeatsLeft(
                                widget.marginx?.maxParticipants ?? 0,
                                widget.marginx?.participants?.length ?? 0) >
                            0
                    ? () {}
                    : () {
                        if (controller.calculateSeatsLeft(
                                widget.marginx?.maxParticipants ?? 0,
                                widget.marginx?.participants?.length ?? 0) ==
                            0) {
                          SnackbarHelper.showSnackbar('MarginX is Full');
                        } else {
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: PaymentBottomSheet(
                              productType: ProductType.marginx,
                              productId: widget.marginx?.id ?? '',
                              buyItemPrice:
                                  widget.marginx?.marginXTemplate?.entryFee ??
                                      0,
                              onPaymentSuccess:
                                  controller.loadDataAfterPaymentSuccess,
                              onSubmit: () {
                                Get.back();
                                var walletController =
                                    Get.find<WalletController>();
                                var data = {
                                  "bonusRedemption": walletController
                                          .isHeroCashAdded.value
                                      ? walletController.heroCashAmount.value
                                      : 0,
                                  "coupon": walletController
                                      .couponCodeTextController.text,
                                  "entryFee":
                                      walletController.subscriptionAmount.value,
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
                                    widget.marginx?.maxParticipants ?? 0,
                                    widget.marginx?.participants?.length ?? 0) >
                                0
                        ? 'Purchased'
                        : controller.calculateSeatsLeft(
                                    widget.marginx?.maxParticipants ?? 0,
                                    widget.marginx?.participants?.length ??
                                        0) ==
                                0
                            ? 'MarginX Full'
                            : 'Join Now',
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
                  controller.upComingMarginX(widget.marginx);
                  controller.getShareMarginX(true);
                  String url = 'https://stoxhero.com/marginxs';
                  Clipboard.setData(ClipboardData(text: url));
                  SnackbarHelper.showSnackbar(
                      'Link Copied, Share with your friends.');
                },
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
