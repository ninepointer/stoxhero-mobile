import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CompletedContestLeaderboard extends GetView<ContestController> {
  const CompletedContestLeaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contest'),
      ),
      body: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.completedContestLeaderboardList.length,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var contest = controller.completedContestLeaderboardList[index];
            return CommonCard(
              margin: EdgeInsets.only(top: 4, left: 12, right: 12),
              padding: EdgeInsets.only(top: 8, right: 12, left: 8),
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withOpacity(.25),
                                  shape: BoxShape.circle,
                                ),
                                child: Align(
                                  child: Text(
                                    '${contest.rank.contains('-') ? index + 1 : contest.rank}',
                                    style: AppStyles.tsSecondarySemiBold14,
                                  ),
                                ),
                              ),
                              Text(
                                '${contest.firstName?.capitalizeFirst} ${contest.lastName?.capitalizeFirst}',
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
                    SizedBox(height: 8),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
