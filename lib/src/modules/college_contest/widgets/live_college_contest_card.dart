import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoxhero/src/app/app.dart';

class LiveCollegeContestCard extends GetView<CollegeContestController> {
  final LiveCollegeContest? contest;
  final TradingPosition? contestPositionList;
  final ContestCreditData? contestPortfolio;
  const LiveCollegeContestCard({
    Key? key,
    this.contest,
    this.contestPositionList,
    this.contestPortfolio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
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
                    contest?.contestName ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ),
              ),
              Container(
                height: 15, // Adjust the height as needed
                child: InkWell(
                  onTap: () {
                    BottomSheetHelper.openBottomSheet(
                      context: context,
                      child: CollegeRewardTableBottomSheet(
                        liveContest: contest,
                      ),
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
              ),
              Visibility(
                visible: contest?.featured == true,
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Visibility(
                visible: contest?.isNifty == true,
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
                visible: contest?.isBankNifty == true,
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
                visible: contest?.isFinNifty == true,
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
                  contest?.contestExpiry ?? '',
                  style: AppStyles.tsGreyMedium12,
                ),
              ),
              SizedBox(width: 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  contest?.contestStatus ?? '',
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
            Padding(padding: EdgeInsets.only(left: 5)),
            Image.asset(
              AppImages.contestTrophy,
              width: 30,
              height: 20,
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (contest?.payoutType == 'Reward') ...[
                    Text(
                      'Rewards worth ${controller.calculateTotalReward(contest?.rewards)}',
                      style: Theme.of(context).textTheme.tsGreyRegular12,
                      textAlign: TextAlign.center,
                    )
                  ],
                  if (contest?.payoutType != 'Reward') ...[
                    if (contest?.payoutCapPercentage != null &&
                        contest?.payoutCapPercentage != 0)
                      Column(
                        children: [
                          Text(
                            ' ${contest?.payoutPercentage != null ? contest?.payoutPercentage : '0'}% of the Net P&L (Upto ${controller.getPaidCapAmount(
                              contest?.entryFee == 0
                                  ? contest?.portfolio?.portfolioValue ?? 0
                                  : contest?.entryFee ?? 0,
                              contest?.payoutCapPercentage ?? 0,
                            )})',
                            style: Theme.of(context).textTheme.tsGreyRegular12,
                          ),
                        ],
                      )
                  ]
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              // Stack(
              //   children: [
              //     Positioned(
              //       left: 0,
              //       top: 0,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'No. of Seats left',
              //             style: AppStyles.tsGreyMedium12,
              //           ),
              //           SizedBox(height: 2),
              //           Text(
              //             controller
              //                 .calculateSeatsLeft(
              //                   contest?.maxParticipants ?? 0,
              //                   contest?.participants?.length ?? 0,
              //                 )
              //                 .toString(),
              //             style: Theme.of(context).textTheme.tsMedium12,
              //           ),
              //         ],
              //       ),
              //     ),
              //     Column(
              //       children: [
              //         Image.asset(
              //           AppImages.contestTrophy,
              //           width: 36,
              //         ),
              //         Text(
              //           'Reward',
              //           style: AppStyles.tsGreyMedium12,
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             BottomSheetHelper.openBottomSheet(
              //               context: context,
              //               child: CollegeRewardTableBottomSheet(
              //                 liveContest: contest,
              //               ),
              //             );
              //           },
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               if (contest?.payoutType == 'Reward') ...[
              //                 Text(
              //                   'Rewards worth ${controller.calculateTotalReward(contest?.rewards)},Click to know more.',
              //                   style: Theme.of(context).textTheme.tsMedium12,
              //                   textAlign: TextAlign.center,
              //                 )
              //               ],
              //               if (contest?.payoutType != 'Reward') ...[
              //                 Column(
              //                   children: [
              //                     // Text(
              //                     //   '${contest?.payoutPercentage != null ? contest?.payoutPercentage : '0'}% of the Net P&L',
              //                     //   style:
              //                     //       Theme.of(context).textTheme.tsMedium12,
              //                     // ),
              //                     if (contest?.payoutCapPercentage != null &&
              //                         contest?.payoutCapPercentage != 0)
              //                       Text(
              //                         '${contest?.payoutPercentage != null ? contest?.payoutPercentage : '0'}% of the Net P&L (Upto ${controller.getPaidCapAmount(
              //                           contest?.entryFee == 0
              //                               ? contest?.portfolio
              //                                       ?.portfolioValue ??
              //                                   0
              //                               : contest?.entryFee ?? 0,
              //                           contest?.payoutCapPercentage ?? 0,
              //                         )})',
              //                         style: Theme.of(context)
              //                             .textTheme
              //                             .tsMedium12,
              //                       ),
              //                     Text(' Click to know more.'),
              //                   ],
              //                 )
              //               ]
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //     Positioned(
              //       right: 0,
              //       top: 0,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           Text(
              //             'Remaining Time',
              //             style: AppStyles.tsGreyMedium12,
              //             textAlign: TextAlign.end,
              //             softWrap: false,
              //           ),
              //           SizedBox(height: 2),
              //           Text(
              //             'Started',
              //             style: Theme.of(context).textTheme.tsMedium12,
              //             textAlign: TextAlign.end,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Virtual Margin',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(
                          contest?.portfolio?.portfolioValue,
                          decimal: 0,
                        ),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Started',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Entry Fee',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        contest?.entryFee == 0
                            ? 'Free'
                            : FormatHelper.formatNumbers(contest?.entryFee,
                                decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              //sgesg
              //dsg
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Starts:',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                          FormatHelper.formatDateTimeWithoutYearToIST(
                              contest?.contestStartTime),
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Spots left:',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                          controller
                              .calculateSeatsLeft(
                                contest?.maxParticipants ?? 0,
                                contest?.participants?.length ?? 0,
                              )
                              .toString(),
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Ends:',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                          FormatHelper.formatDateTimeWithoutYearToIST(
                              contest?.contestEndTime),
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                    ],
                  )
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
                    controller.liveCollegeContest(contest);
                    if (contest?.entryFee == 0) {
                      if (contest?.maxParticipants ==
                          contest?.participants?.length) {
                        if (controller.canUserTrade(contest)) {
                          controller.gotoTradingView();
                        } else {
                          if (controller
                              .collegeCodeTextController.text.isNotEmpty) {
                            Get.back();
                            controller.verifyAndParticipate(contest);
                            controller.collegeCodeTextController.clear();
                          }
                        }
                      } else if (controller.canUserTrade(contest)) {
                        controller.gotoTradingView();
                      } else {
                        BottomSheetHelper.openBottomSheet(
                          context: context,
                          child: CollegeContestCodeBottomsheet(
                            onSubmit: () {
                              if (controller
                                  .collegeCodeTextController.text.isNotEmpty) {
                                Get.back();
                                controller.verifyAndParticipate(contest);
                                controller.collegeCodeTextController.clear();
                              }
                            },
                          ),
                        );
                      }
                    } else {
                      if (controller.checkIfLivePurchased(contest)) {
                        controller.gotoTradingView();
                      } else {
                        BottomSheetHelper.openBottomSheet(
                          context: context,
                          child: PaymentBottomSheet(
                            productType: ProductType.collegeContest,
                            productId: contest?.id ?? '',
                            buyItemPrice: contest?.entryFee ?? 0,
                            onPaymentSuccess:
                                controller.loadDataAfterPaymentSuccess,
                            onSubmit: () {
                              Get.back();
                              var walletController =
                                  Get.find<WalletController>();
                              var data = {
                                "bonusRedemption":
                                    walletController.isHeroCashAdded.value
                                        ? walletController.heroCashAmount.value
                                        : 0,
                                "coupon": walletController
                                    .couponCodeTextController.text,
                                "contestFee":
                                    walletController.subscriptionAmount.value,
                                "contestId": contest?.id,
                                "contestName": contest?.contestName,
                              };
                              controller.purchaseContest(data);
                            },
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                      color: AppColors.success.withOpacity(.25),
                    ),
                    child: Text(
                      controller.checkIfLivePurchased(contest)
                          ? 'Start Trading'
                          // : contest?.entryFee != 0
                          //     ? 'Pay Now'
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
                    controller.liveCollegeContest(contest);
                    controller.getShareContest(false);
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
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
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
    );
  }
}
