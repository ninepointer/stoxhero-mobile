import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/app.dart';

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
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    contest?.contestName ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
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
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Visibility(
                visible: contest?.isNifty == true,
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
                visible: contest?.isBankNifty == true,
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
                visible: contest?.isFinNifty == true,
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
                  contest?.contestExpiry ?? '',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  contest?.contestStatus ?? '',
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
              Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
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
                                contest?.maxParticipants ?? 0,
                                contest?.participants?.length ?? 0,
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
                        width: 36,
                      ),
                      Text(
                        'Reward',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (contest?.payoutType == 'Reward')
                            BottomSheetHelper.openBottomSheet(
                              context: context,
                              child: RewardTableBottomSheet(
                                liveContest: contest,
                              ),
                            );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (contest?.payoutType == 'Reward') ...[
                              Text(
                                'Rewards worth ${controller.calculateTotalReward(contest?.rewards)},Click to know more.',
                                style: Theme.of(context).textTheme.tsMedium12,
                                textAlign: TextAlign.center,
                              )
                            ],
                            if (contest?.payoutType != 'Reward') ...[
                              Text(
                                '${contest?.payoutPercentage != null ? contest?.payoutPercentage : '0'}% of the Net P&L',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                              if (contest?.payoutCapPercentage != null && contest?.payoutCapPercentage != 0)
                                Text(
                                  ' (Upto ${controller.getPaidCapAmount(
                                    contest?.entryFee == 0
                                        ? contest?.portfolio?.portfolioValue ?? 0
                                        : contest?.entryFee ?? 0,
                                    contest?.payoutCapPercentage ?? 0,
                                  )})',
                                  style: Theme.of(context).textTheme.tsMedium12,
                                ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Remaining Time',
                          style: AppStyles.tsGreyMedium12,
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Started',
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
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatDateTimeToIST(contest?.contestStartTime),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Ends',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatDateTimeToIST(contest?.contestEndTime),
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
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        contest?.entryFee == 0 ? 'Free' : FormatHelper.formatNumbers(contest?.entryFee, decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Virtual Margin Money',
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
                    controller.userDetails.value = AppStorage.getUserDetails();
                    controller.liveContest(contest);
                    if (contest?.entryFee == 0) {
                      if (contest?.maxParticipants == contest?.participants?.length) {
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
                            onPaymentSuccess: controller.loadDataAfterPaymentSuccess,
                            onSubmit: () {
                              Get.back();
                              var walletController = Get.find<WalletController>();
                              var data = {
                                "bonusRedemption": 0,
                                "coupon": walletController.couponCodeTextController.text,
                                "contestFee": walletController.subscriptionAmount.value,
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
                      (controller.checkIfLivePurchased(contest, userId) || contest?.entryFee == 0)
                          ? 'Start Trading'
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
                    controller.liveContest(contest);
                    controller.getShareContest(false);
                    String url = 'https://stoxhero.com/contest';
                    Clipboard.setData(ClipboardData(text: url));
                    SnackbarHelper.showSnackbar('Link Copied, Share with your friends.');
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
