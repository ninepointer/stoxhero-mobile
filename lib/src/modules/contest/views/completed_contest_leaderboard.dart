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
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withOpacity(.25),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${contest.rank.toString().contains('-') ? index + 1 : contest.rank}',
                                  style: AppStyles.tsSecondarySemiBold14,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  '${contest.firstName?.capitalizeFirst} ${contest.lastName?.capitalizeFirst}',
                                  style: Theme.of(context).textTheme.tsMedium14,
                                ),
                              ),
                              SizedBox(width: 4),
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
