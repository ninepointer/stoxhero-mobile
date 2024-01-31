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
      padding: EdgeInsets.only(top: 0, right: 0),
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
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(.1),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          AppImages.contestTrophy,
                          width: 25,
                          height: 25,
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${liveFeatured?.contestName}',
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 2),
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
                                  if (liveFeatured?.rewardType == "Goodies")
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: controller.liveFeaturedContest
                                                      .length ==
                                                  1
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7
                                              : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7 -
                                                  55,
                                          child: Text.rich(
                                            TextSpan(
                                              text:
                                                  "1st rank wins ${controller.calculateTotalReward(liveFeatured?.rewards)} ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .tsGreyRegular12,
                                              children: [
                                                TextSpan(
                                                  text: "Know More",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColors
                                                          .grey // Set the color to blue
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //   "",
                                        //   style: Theme.of(context)
                                        //       .textTheme
                                        //       .tsGreyRegular12
                                        //       .copyWith(
                                        //         color: AppColors.primary,
                                        //         decoration:
                                        //             TextDecoration.underline,
                                        //       ),
                                        // ),
                                      ],
                                    )
                                  else
                                    Text(
                                      'Rewards worth ${FormatHelper.formatNumbers(controller.calculateTotalReward(liveFeatured?.rewards), decimal: 0)},Click to know more',
                                      style: Theme.of(context)
                                          .textTheme
                                          .tsGreyRegular12,
                                      textAlign: TextAlign.left,
                                    )
                                ],
                                if (liveFeatured?.payoutType != 'Reward') ...[
                                  Text(
                                    '${liveFeatured?.payoutPercentage != null ? liveFeatured?.payoutPercentage : '0'}% of the Net P&L',
                                    style:
                                        Theme.of(context).textTheme.tsMedium10,
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
                                          .tsMedium10,
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
                            liveFeatured?.contestStartTime),
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
                            liveFeatured?.contestEndTime),
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
                            liveFeatured?.portfolio?.portfolioValue,
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
                        '${controller.calculateSeatsLeft(
                              liveFeatured?.maxParticipants ?? 0,
                              liveFeatured?.participants?.length ?? 0,
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
                        liveFeatured?.entryFee == 0
                            ? 'Free'
                            : FormatHelper.formatNumbers(liveFeatured?.entryFee,
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
        GestureDetector(
          onTap: () {
            controller.userDetails.value = AppStorage.getUserDetails();
            controller.liveFeatured(liveFeatured);
            if (liveFeatured?.entryFee == 0) {
              if (liveFeatured?.maxParticipants ==
                  liveFeatured?.participants?.length) {
                if (controller.canUserFeaturedTrade(liveFeatured, userId)) {
                  controller.gotoTradingView(isLiveContest: false);
                } else {
                  controller.featuredParticipate(liveFeatured);
                }
              } else {
                if (controller.canUserFeaturedTrade(liveFeatured, userId)) {
                  controller.gotoTradingView(isLiveContest: false);
                } else {
                  controller.featuredParticipate(liveFeatured);
                }
              }
            } else {
              if (controller.checkIfLiveFeaturedPurchased(
                  liveFeatured, userId)) {
                controller.gotoTradingView(isLiveContest: false);
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
                        "bonusRedemption":
                            walletController.isHeroCashAdded.value
                                ? walletController.heroCashAmount.value
                                : 0,
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
            padding: EdgeInsets.all(8),
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
