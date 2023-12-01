import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/home/widgets/featured_reward_table_bottom_sheet.dart';

import '../../../app/app.dart';

class LiveFeaturedCard extends GetView<ContestController> {
  final LiveFeatured? liveFeatured;
  final String userId;
  const LiveFeaturedCard({
    Key? key,
    this.liveFeatured,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(left: 12, right: 12, top: 8),
      padding: EdgeInsets.only(top: 8),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                            '${liveFeatured?.contestName}',
                            style: Theme.of(context).textTheme.tsRegular16,
                          ),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              if (liveFeatured?.payoutType == 'Reward')
                                BottomSheetHelper.openBottomSheet(
                                  context: context,
                                  child: FeaturedRewardTableBottomSheet(
                                    liveContest: liveFeatured,
                                  ),
                                );
                            },
                            child: Row(
                              children: [
                                if (liveFeatured?.payoutType == 'Reward') ...[
                                  Text(
                                    'Rewards worth ${controller.calculateTotalReward(liveFeatured?.rewards)},Click to know more.',
                                    style:
                                        Theme.of(context).textTheme.tsMedium12,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                                if (liveFeatured?.payoutType != 'Reward') ...[
                                  Text(
                                    '${liveFeatured?.payoutPercentage != null ? liveFeatured?.payoutPercentage : '0'}% of the Net P&L',
                                    style:
                                        Theme.of(context).textTheme.tsMedium12,
                                  ),
                                  if (liveFeatured?.payoutCapPercentage !=
                                          null &&
                                      liveFeatured?.payoutCapPercentage != 0)
                                    Text(
                                      ' (Upto ${controller.getPaidCapAmount(
                                        liveFeatured?.entryFee == 0
                                            ? liveFeatured?.portfolio
                                                    ?.portfolioValue ??
                                                0
                                            : liveFeatured?.entryFee ?? 0,
                                        liveFeatured?.payoutCapPercentage ?? 0,
                                      )})',
                                      style: Theme.of(context)
                                          .textTheme
                                          .tsMedium12,
                                    ),
                                ]
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: liveFeatured?.featured == true,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 18, right: 18, bottom: 18, top: 54),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonCardTile(
                          label: 'Starts',
                          value: FormatHelper.formatDateTimeOnlyToIST(
                              liveFeatured?.contestStartTime),
                        ),
                        SizedBox(height: 4),
                        CommonCardTile(
                          label: 'Ends',
                          value: FormatHelper.formatDateTimeOnlyToIST(
                              liveFeatured?.contestEndTime),
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
                      liveFeatured?.entryFee == 0
                          ? 'Free'
                          : FormatHelper.formatNumbers(liveFeatured?.entryFee,
                              decimal: 0),
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
          onTap: () {
            controller.userDetails.value = AppStorage.getUserDetails();
            controller.liveFeatured(liveFeatured);
            if (liveFeatured?.entryFee == 0) {
              if (liveFeatured?.maxParticipants ==
                  liveFeatured?.participants?.length) {
                if (controller.canUserFeaturedTrade(liveFeatured, userId)) {
                  controller.gotoTradingView();
                } else {
                  controller.featuredParticipate(liveFeatured);
                }
              } else {
                if (controller.canUserFeaturedTrade(liveFeatured, userId)) {
                  controller.gotoTradingView();
                } else {
                  controller.featuredParticipate(liveFeatured);
                }
              }
            } else {
              if (controller.checkIfLiveFeaturedPurchased(
                  liveFeatured, userId)) {
                controller.gotoTradingView();
              } else {
                BottomSheetHelper.openBottomSheet(
                  context: context,
                  child: PaymentBottomSheet(
                    productType: ProductType.contest,
                    productId: liveFeatured?.id ?? '',
                    buyItemPrice: liveFeatured?.entryFee ?? 0,
                    onPaymentSuccess: controller.loadDataAfterPaymentSuccess,
                    onSubmit: () {
                      Get.back();
                      var walletController = Get.find<WalletController>();
                      var data = {
                        "bonusRedemption": 0,
                        "coupon":
                            walletController.couponCodeTextController.text,
                        "contestFee": walletController.subscriptionAmount.value,
                        "contestId": liveFeatured?.id,
                        "contestName": liveFeatured?.contestName,
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
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(.25),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              // controller.checkIfLiveFeaturedPurchased(liveFeatured, userId) || liveFeatured?.entryFee == 0
              //     ? 'Start Trading'
              //     : 'Pay Now',
              controller.checkIfLiveFeaturedPurchased(liveFeatured, userId)
                  ? 'Start Trading'
                  // : liveFeatured?.entryFee != 0
                  //     ? 'Pay Now'
                  : 'Join Now',
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
