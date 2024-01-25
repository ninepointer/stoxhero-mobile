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
    startTimeDateTime =
        DateTime.parse(widget.upcomingFeatured?.contestStartTime ?? '');

    setState(() {
      remainingTime = startTimeDateTime.isAfter(currentTime)
          ? startTimeDateTime.difference(currentTime)
          : Duration.zero;
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
              if (remainingTime == Duration.zero) {
                controller.getFeaturedContest();
              }
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
      padding: EdgeInsets.only(
        top: 0,
        right: 0,
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 13, bottom: 16, top: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
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
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.upcomingFeatured?.payoutPercentage != null ? widget.upcomingFeatured?.payoutPercentage : '0'}% of the Net P&L',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                              if (widget.upcomingFeatured
                                          ?.payoutCapPercentage !=
                                      null &&
                                  widget.upcomingFeatured
                                          ?.payoutCapPercentage !=
                                      0)
                                Text(
                                  ' (Upto ${controller.getPaidCapAmount(
                                    widget.upcomingFeatured?.entryFee == 0
                                        ? widget.upcomingFeatured?.portfolio
                                                ?.portfolioValue ??
                                            0
                                        : widget.upcomingFeatured?.entryFee ??
                                            0,
                                    widget.upcomingFeatured
                                            ?.payoutCapPercentage ??
                                        0,
                                  )})',
                                  style: Theme.of(context).textTheme.tsMedium10,
                                ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.upcomingFeatured?.featured == true,
                  child: Container(
                    padding: EdgeInsets.only(left: 18, bottom: 18, top: 45),
                    foregroundDecoration: CommonTriangleCard(
                      badgeColor: AppColors.success,
                      badgeSize: 62,
                      textSpan: TextSpan(
                        text: 'Featured',
                        style: AppStyles.tsWhiteMedium12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
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
                        FormatHelper.formatDateTimeOnlyToIST(
                            widget.upcomingFeatured?.contestStartTime),
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
                        FormatHelper.formatDateTimeOnlyToIST(
                            widget.upcomingFeatured?.contestEndTime),
                        style: Theme.of(context).textTheme.tsMedium12,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
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
                            widget.upcomingFeatured?.portfolio?.portfolioValue,
                            decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Spots Left',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        //  "${(widget.upcomingFeatured?.maxParticipants ?? 0) - (widget.upcomingFeatured?.participants ?? 0)}",
                        '${controller.calculateSeatsLeft(
                              widget.upcomingFeatured?.maxParticipants ?? 0,
                              widget.upcomingFeatured?.participants?.length ??
                                  0,
                            ).toString()}',

                        style: Theme.of(context).textTheme.tsMedium12,
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
                        widget.upcomingFeatured?.entryFee == 0
                            ? 'Free'
                            : FormatHelper.formatNumbers(
                                widget.upcomingFeatured?.entryFee,
                                decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 130,
              child: GestureDetector(
                onTap: (controller.checkIfUpcomingFeaturedPurchased(
                                widget.upcomingFeatured, widget.userId) ||
                            widget.upcomingFeatured?.entryFee == 0) &&
                        controller.calculateSeatsLeft(
                                widget.upcomingFeatured?.maxParticipants ?? 0,
                                widget.upcomingFeatured?.participants?.length ??
                                    0) >
                            0
                    ? () => SnackbarHelper.showSnackbar(
                        'The TestZone has not started yet!')
                    : () async {
                        if (controller.calculateSeatsLeft(
                                widget.upcomingFeatured?.maxParticipants ?? 0,
                                widget.upcomingFeatured?.participants?.length ??
                                    0) ==
                            0) {
                          SnackbarHelper.showSnackbar('TestZone is Full');
                        } else {
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: PaymentBottomSheet(
                              productType: ProductType.contest,
                              productId: widget.upcomingFeatured?.id ?? '',
                              buyItemPrice:
                                  widget.upcomingFeatured?.entryFee ?? 0,
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
                                  "contestFee":
                                      walletController.subscriptionAmount.value,
                                  "contestId": widget.upcomingFeatured?.id,
                                  "contestName":
                                      widget.upcomingFeatured?.contestName,
                                };
                                controller.purchaseContest(data);
                              },
                            ),
                          );
                        }
                      },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      // bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.upcomingFeatured?.entryFee == 0
                        ? 'Start Trading'
                        : (controller.checkIfUpcomingFeaturedPurchased(
                                        widget.upcomingFeatured,
                                        widget.userId) ||
                                    widget.upcomingFeatured?.entryFee == 0) &&
                                controller
                                        .calculateSeatsLeft(
                                            widget.upcomingFeatured
                                                    ?.maxParticipants ??
                                                0,
                                            widget.upcomingFeatured
                                                    ?.participants?.length ??
                                                0) >
                                    0
                            ? 'Purchased'
                            : controller.calculateSeatsLeft(
                                        widget.upcomingFeatured
                                                ?.maxParticipants ??
                                            0,
                                        widget.upcomingFeatured?.participants
                                                ?.length ??
                                            0) ==
                                    0
                                ? 'TestZone Full'
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
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      // bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    '${remainingTime.inDays}D ${remainingTime.inHours.remainder(24)}H ${remainingTime.inMinutes.remainder(60)}M ${remainingTime.inSeconds.remainder(60)}S',
                    style: AppStyles.tsSecondaryMedium12.copyWith(
                      color: AppColors.primary.shade600,
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
