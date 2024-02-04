import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/home/widgets/featured_reward_table_bottom_sheet.dart';

import '../../../app/app.dart';

class CollegeContestCard extends GetView<CollegeContestController> {
  final String userId;
  final FeaturedCollegeContest? featuredCollegeContest;
  final LiveCollegeContest? liveCollegeContest;
  const CollegeContestCard({
    Key? key,
    this.featuredCollegeContest,
    this.liveCollegeContest,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(left: 0, right: 16, top: 0),
      padding: EdgeInsets.zero,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 0, bottom: 8, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0204,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${featuredCollegeContest?.contestName}',
                            style: AppStyles.tsSecondaryMedium14,
                          ),
                          SizedBox(height: 2),
                          GestureDetector(
                            // onTap: () {
                            //   if (featuredCollegeContest?.payoutType == 'Reward')
                            //     BottomSheetHelper.openBottomSheet(
                            //       context: context,
                            //       child: FeaturedRewardTableBottomSheet(
                            //         liveContest: featuredCollegeContest,
                            //       ),
                            //     );
                            // },
                            child: Row(
                              children: [
                                if (featuredCollegeContest?.payoutType ==
                                    'Reward') ...[
                                  if (featuredCollegeContest?.rewardType ==
                                      "Goodies")
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1224,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7 -
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1403,
                                          child: Text.rich(
                                            TextSpan(
                                              text:
                                                  "1st rank wins ${controller.calculateTotalReward(featuredCollegeContest?.rewards)} ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .tsGreyRegular12,
                                              children: [
                                                // TextSpan(
                                                //   text: "Know More",
                                                //   style: TextStyle(
                                                //       decoration: TextDecoration
                                                //           .underline,
                                                //       color: AppColors
                                                //           .grey // Set the color to blue
                                                //       ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1224,
                                      child: Text(
                                        'Rewards worth ${FormatHelper.formatNumbers(controller.calculateTotalReward(featuredCollegeContest?.rewards), decimal: 0)},Click to know more',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsGreyRegular12,
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                ],
                                if (featuredCollegeContest?.payoutType !=
                                    'Reward') ...[
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.1224,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${featuredCollegeContest?.payoutPercentage != null ? featuredCollegeContest?.payoutPercentage : '0'}% of the Net P&L',
                                          style: Theme.of(context)
                                              .textTheme
                                              .tsGreyRegular12,
                                        ),
                                        if (featuredCollegeContest
                                                    ?.payoutCapPercentage !=
                                                null &&
                                            featuredCollegeContest
                                                    ?.payoutCapPercentage !=
                                                0)
                                          Text(
                                            ' (Upto ${controller.getPaidCapAmount(
                                              featuredCollegeContest
                                                          ?.entryFee ==
                                                      0
                                                  ? featuredCollegeContest
                                                          ?.portfolio
                                                          ?.portfolioValue ??
                                                      0
                                                  : featuredCollegeContest
                                                          ?.entryFee ??
                                                      0,
                                              featuredCollegeContest
                                                      ?.payoutCapPercentage ??
                                                  0,
                                            )})',
                                            style: Theme.of(context)
                                                .textTheme
                                                .tsGreyRegular12,
                                          ),
                                      ],
                                    ),
                                  )
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
                  visible: featuredCollegeContest?.featured == true,
                  child: Container(
                    padding: EdgeInsets.only(left: 0, bottom: 18, top: 63),
                    foregroundDecoration: CommonTriangleCard(
                      badgeColor: AppColors.success,
                      badgeSize: 68,
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
                            featuredCollegeContest?.contestStartTime),
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
                            featuredCollegeContest?.contestEndTime),
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
                            featuredCollegeContest?.portfolio?.portfolioValue,
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
                              featuredCollegeContest?.maxParticipants ?? 0,
                              featuredCollegeContest?.participants?.length ?? 0,
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
                        featuredCollegeContest?.entryFee == 0
                            ? 'Free'
                            : FormatHelper.formatNumbers(
                                featuredCollegeContest?.entryFee,
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
            controller.featuredCollegeContest(featuredCollegeContest);
            if (featuredCollegeContest?.entryFee == 0) {
              if (featuredCollegeContest?.maxParticipants ==
                  featuredCollegeContest?.participants?.length) {
                if (controller.canUserFeaturedTrade(
                    featuredCollegeContest, userId)) {
                  controller.gotoTradingView();
                } else {
                  if (controller.collegeCodeTextController.text.isNotEmpty) {
                    Get.back();
                    controller
                        .verifyAndFeatureParticipate(featuredCollegeContest);
                    controller.collegeCodeTextController.clear();
                  }
                }
              } else if (controller.canUserFeaturedTrade(
                  featuredCollegeContest, userId)) {
                controller.gotoTradingView();
              } else {
                BottomSheetHelper.openBottomSheet(
                  context: context,
                  child: CollegeContestCodeBottomsheet(
                    onSubmit: () {
                      if (controller
                          .collegeCodeTextController.text.isNotEmpty) {
                        Get.back();
                        controller.verifyAndFeatureParticipate(
                            featuredCollegeContest);
                        controller.collegeCodeTextController.clear();
                      }
                    },
                  ),
                );
              }
            } else {
              if (controller.checkIfLiveFeaturedPurchased(
                  featuredCollegeContest, userId)) {
                controller.gotoTradingView();
              } else {}
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
              (controller.checkIfLiveFeaturedPurchased(
                          featuredCollegeContest, userId) ||
                      featuredCollegeContest?.entryFee == 0)
                  ? 'Start Trading'
                  : 'Click to Participate',
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
