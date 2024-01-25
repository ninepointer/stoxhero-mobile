import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoxhero/src/data/models/response/upcoming_college_contest_list_response.dart';

import '../../../app/app.dart';

class UpComingCollegeContestCard extends StatefulWidget {
  final UpComingCollegeContest? contest;

  const UpComingCollegeContestCard({
    Key? key,
    this.contest,
  }) : super(key: key);

  @override
  State<UpComingCollegeContestCard> createState() =>
      _UpComingCollegeContestCardState();
}

class _UpComingCollegeContestCardState
    extends State<UpComingCollegeContestCard> {
  late DateTime startTimeDateTime;
  late Duration remainingTime;
  late CollegeContestController controller;
  late Timer timer;
  bool isVisible = true;
  bool isUserInterestedId = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CollegeContestController>();
    isUserInterestedId = controller.isUserInterested(
      widget.contest,
      controller.userDetails.value.sId,
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
                controller.getUpComingCollegeContestList();
                controller.getLiveCollegeContestList();
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isVisible,
      replacement: SizedBox(),
      child: CommonCard(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: EdgeInsets.only(left: 12, right: 12, top: 8),
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
                ),
                //                 Container(
                //   height: 15, // Adjust the height as needed
                //   child: InkWell(
                //     onTap: () {
                //       BottomSheetHelper.openBottomSheet(
                //         context: context,
                //         child: RewardTableBottomSheet(
                //           upcomingContest: widget.contest,
                //         ),
                //       );
                //     },
                //     child: Container(
                //       padding: EdgeInsets.only(right: 10),
                //       child: Icon(
                //         Icons.info,
                //         size: 20.0,
                //         color: Colors.grey, // Icon color
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Row(
              children: [
                Visibility(
                  visible: widget.contest?.isNifty == true,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: Text(
                      'Nifty',
                      style: AppStyles.tsGreyMedium12,
                    ),
                  ),
                ),
                SizedBox(width: 2),
                Visibility(
                  visible: widget.contest?.isBankNifty == true,
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
                  visible: widget.contest?.isFinNifty == true,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'FinNifty',
                      style: AppStyles.tsGreyMedium12,
                    ),
                  ),
                ),
                SizedBox(width: 2),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    widget.contest?.contestExpiry ?? '',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.contestTrophy,
                width: 30,
                height: 20,
              ),
              GestureDetector(
                child: Row(children: [
                  Row(children: [
                    Text(
                      '${widget.contest?.payoutPercentage}% of the Net P&L',
                      style: Theme.of(context).textTheme.tsGreyRegular12,
                    ),
                    if (widget.contest?.payoutCapPercentage != null)
                      Text(
                        ' (Upto ${controller.getPaidCapAmount(
                          widget.contest?.entryFee == 0
                              ? widget.contest?.portfolio?.portfolioValue ?? 0
                              : widget.contest?.entryFee ?? 0,
                          widget.contest?.payoutCapPercentage ?? 0,
                        )})',
                        style: Theme.of(context).textTheme.tsGreyRegular12,
                      ),
                  ])
                ]),
              )
            ],
          ),
          SizedBox(height: 8),
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
                              widget.contest?.portfolio?.portfolioValue,
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
                          widget.contest?.entryFee == 0
                              ? 'Free'
                              : FormatHelper.formatNumbers(
                                  widget.contest?.entryFee,
                                  decimal: 0),
                          style: Theme.of(context).textTheme.tsMedium12,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Starts:${FormatHelper.formatDateTimeWithoutYearToIST(widget.contest?.contestStartTime)}',
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
                    Text(
                      'Ends:${FormatHelper.formatDateTimeWithoutYearToIST(widget.contest?.contestEndTime)}',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Rubik'),
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
                        controller.upComingCollegeContest(widget.contest);
                        controller.getNotified();
                        isUserInterestedId = true;
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
                    onTap: (controller.checkIfPurchased(widget.contest) ||
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
                                  productType: ProductType.collegeContest,
                                  productId: widget.contest?.id ?? '',
                                  buyItemPrice: widget.contest?.entryFee ?? 0,
                                  onPaymentSuccess:
                                      controller.loadDataAfterPaymentSuccess,
                                  onSubmit: () {
                                    Get.back();
                                    var walletController =
                                        Get.find<WalletController>();
                                    var data = {
                                      "bonusRedemption": 0,
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
                            : (controller.checkIfPurchased(widget.contest) ||
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
                      controller.upComingCollegeContest(widget.contest);
                      controller.getShareContest(true);
                      String url = 'https://stoxhero.com/testzone';
                      Clipboard.setData(ClipboardData(text: url));
                      SnackbarHelper.showSnackbar(
                          'Link Copied, Share with your friends.');
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
