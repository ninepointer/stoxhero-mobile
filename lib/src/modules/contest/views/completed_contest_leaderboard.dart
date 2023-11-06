import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CompletedContestLeaderboard extends GetView<ContestController> {
  const CompletedContestLeaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${controller.completedContest.value.contestName}\n Leaderboard',
          style: Theme.of(context).textTheme.tsRegular16,
          textAlign: TextAlign.center,
        ),
      ),
      body: Obx(
        () => Visibility(
          visible: controller.isCompletedLeaderboardLoadingStatus,
          child: ListViewShimmer(
            itemCount: 10,
            padding: EdgeInsets.all(12),
            shimmerCard: SmallCardShimmer(),
          ),
          replacement: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.completedContestLeaderboardList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var contest = controller.completedContestLeaderboardList[index];
              return CommonCard(
                margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                padding: EdgeInsets.only(top: 8, right: 16, left: 8, bottom: 8),
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(.25),
                                    width: 1,
                                  ),
                                ),
                                child: ClipOval(
                                  child: contest.image == null || contest.image!.isEmpty
                                      ? Image.asset(
                                          AppImages.appLogo,
                                          width: 48,
                                          height: 48,
                                        )
                                      : Image.network(
                                          contest.image ?? '',
                                          width: 48,
                                          height: 48,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              AppImages.appLogo,
                                              width: 48,
                                              height: 48,
                                            );
                                          },
                                        ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Align(
                                    child: Text(
                                      '${contest.rank.toString().contains('-') ? index + 1 : contest.rank}',
                                      style: AppStyles.tsWhiteMedium10,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${contest.firstName!.capitalizeFirst} ${contest.lastName!.capitalizeFirst}',
                                  style: Theme.of(context).textTheme.tsMedium14,
                                ),
                                Text(
                                  '${FormatHelper.formatNumbers(
                                    contest.payout,
                                    decimal: 0,
                                  )}',
                                  style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                        color: AppColors.success,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
