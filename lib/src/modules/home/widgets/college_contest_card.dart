import 'package:flutter/material.dart';

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
      padding: EdgeInsets.only(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
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
                        '${featuredCollegeContest?.contestName}',
                        style: Theme.of(context).textTheme.tsRegular14,
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        child: Row(
                          children: [
                            if (featuredCollegeContest?.payoutType !=
                                'Reward') ...[
                              Text(
                                '${featuredCollegeContest?.payoutPercentage != null ? featuredCollegeContest?.payoutPercentage : '0'}% of the Net P&L',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                              if (featuredCollegeContest?.payoutCapPercentage !=
                                      null &&
                                  featuredCollegeContest?.payoutCapPercentage !=
                                      0)
                                Text(
                                  ' (Upto ${controller.getPaidCapAmount(
                                    featuredCollegeContest?.entryFee == 0
                                        ? featuredCollegeContest
                                                ?.portfolio?.portfolioValue ??
                                            0
                                        : featuredCollegeContest?.entryFee ?? 0,
                                    featuredCollegeContest
                                            ?.payoutCapPercentage ??
                                        0,
                                  )})',
                                  style: Theme.of(context).textTheme.tsMedium12,
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
                              featuredCollegeContest?.contestStartTime),
                        ),
                        SizedBox(height: 4),
                        CommonCardTile(
                          label: 'Ends',
                          value: FormatHelper.formatDateTimeOnlyToIST(
                              featuredCollegeContest?.contestEndTime),
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
                      featuredCollegeContest?.entryFee == 0
                          ? 'Free'
                          : FormatHelper.formatNumbers(
                              featuredCollegeContest?.entryFee,
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
            padding: EdgeInsets.all(12),
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
