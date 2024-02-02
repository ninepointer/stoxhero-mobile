import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';
import '../widgets/live_share_modal.dart';

class LiveContestCard extends GetView<ContestController> {
  final String userId;
  final LiveContest? contest;
  final TradingPosition? contestPositionList;
  final ContestCreditData? contestPortfolio;
  final EdgeInsets? margin;
  const LiveContestCard({
    Key? key,
    required this.userId,
    this.contest,
    this.contestPositionList,
    this.contestPortfolio,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: margin,
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.0306,
                      right: MediaQuery.of(context).size.width * 0.0306,
                      top: MediaQuery.of(context).size.width * 0.0204),
                  child: Text(
                    contest?.contestName ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width *
                    0.0382, // Adjust the height as needed
                child: InkWell(
                  onTap: () {
                    BottomSheetHelper.openBottomSheet(
                      context: context,
                      child: RewardTableBottomSheet(
                        liveContest: contest,
                      ),
                    );
                  },
                  child: Container(
                    padding: contest?.featured == true
                        ? const EdgeInsets.only(right: 1)
                        : const EdgeInsets.only(right: 5),
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
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.0412,
                      right: MediaQuery.of(context).size.width * 0.0620,
                      bottom: MediaQuery.of(context).size.width * 0.0620,
                      top: MediaQuery.of(context).size.width * 0.0153),
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
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Visibility(
                visible: contest?.isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.0102,
                      vertical: 0.0051),
                  child: Text(
                    'Nifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              // SizedBox(width: 4),
              Visibility(
                visible: contest?.isBankNifty == true,
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

              Visibility(
                visible: contest?.isFinNifty == true,
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

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.0102,
                    vertical: MediaQuery.of(context).size.width * 0.0051),
                child: Text(
                  contest?.contestExpiry ?? '',
                  style: AppStyles.tsGreyMedium12,
                ),
              ),
              // SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.0102,
                    vertical: MediaQuery.of(context).size.width * 0.0051),
                // decoration: BoxDecoration(
                //   color: AppColors.primary,
                //   borderRadius: BorderRadius.circular(100),
                // ),
                child: Text(
                  contest?.contestStatus ?? '',
                  style: AppStyles.tsGreyMedium12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
        // Divider(thickness: 1, height: 0),
        Container(
          height: MediaQuery.of(context).size.width * 0.08928,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(right: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (contest?.payoutType == 'Reward') ...[
                        if (contest?.rewardType == "Goodies")
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
                                    "1st rank wins ${controller.calculateTotalReward(contest?.rewards)}",
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
                                'Rewards worth ${controller.calculateTotalReward(contest?.rewards)}',
                                style:
                                    Theme.of(context).textTheme.tsGreyRegular12,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                      ],
                      if (contest?.payoutType != 'Reward') ...[
                        if (contest?.payoutCapPercentage != null &&
                            contest?.payoutCapPercentage != 0)
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
                                ' ${contest?.payoutPercentage != null ? contest?.payoutPercentage : '0'}% of the Net P&L (Upto ${controller.getPaidCapAmount(
                                  contest?.entryFee == 0
                                      ? contest?.portfolio?.portfolioValue ?? 0
                                      : contest?.entryFee ?? 0,
                                  contest?.payoutCapPercentage ?? 0,
                                )})',
                                style:
                                    Theme.of(context).textTheme.tsGreyRegular12,
                              ),
                            ],
                          ),
                      ]
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.0306),
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
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.0051),
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
              SizedBox(height: MediaQuery.of(context).size.width * 0.0204),
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
                        width: MediaQuery.of(context).size.width * 0.0051,
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
                        width: MediaQuery.of(context).size.width * 0.0051,
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
                        width: MediaQuery.of(context).size.width * 0.0051,
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
              SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
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
                    // controller.userDetails.value = AppStorage.getUserDetails();
                    controller.liveContest(contest);
                    if (contest?.entryFee == 0) {
                      if (contest?.maxParticipants ==
                          contest?.participants?.length) {
                        if (controller.canUserTrade(contest, userId)) {
                          controller.gotoTradingView();
                        } else {
                          controller.participate(contest);
                        }
                      } else {
                        if (controller.canUserTrade(contest, userId)) {
                          controller.gotoTradingView();
                        } else {
                          controller.participate(contest);
                        }
                      }
                    } else {
                      if (controller.checkIfLivePurchased(contest, userId)) {
                        controller.gotoTradingView();
                      } else {
                        BottomSheetHelper.openBottomSheet(
                          context: context,
                          child: PaymentBottomSheet(
                            productType: ProductType.contest,
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
                      controller.checkIfLivePurchased(contest, userId)
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
                child: InkWell(
                  onTap: () {
                    controller.disconnectLeaderboardSocket();
                    controller.liveContest(LiveContest());
                    controller.liveContest(contest);

                    controller.myRank(0);
                    controller.liveLeaderboardList([]);

                    controller.getContestPositions();

                    controller.getContestWatchList();
                    controller.socketConnection();

                    controller.socketLeaderboardConnection();
                    controller.userDetails.value = AppStorage.getUserDetails();
                    controller.liveLeaderboardList();

                    Get.toNamed(AppRoutes.contestLiveLeaderboard);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.25),
                      // borderRadius: BorderRadius.only(
                      //   bottomRight: Radius.circular(8),
                      // ),
                    ),
                    child: Text(
                      'Leaderboard',
                      style: AppStyles.tsSecondaryMedium12.copyWith(
                        color: AppColors.primary.shade600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.liveContest(contest);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: LiveShareModalContent(
                            contest: contest,
                          ),
                        );
                      },
                    );
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
