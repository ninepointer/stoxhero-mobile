import 'package:flutter/material.dart';

import '../../../app/app.dart';
import '../../../data/models/response/upcoming_college_contest_list_response.dart';

class CollegeRewardTableBottomSheet extends GetView<CollegeContestController> {
  final LiveCollegeContest? liveContest;
  final UpComingCollegeContest? upcomingContest;
  final CompletedCollegeContest? completedContest;
  final CompletedContestPnl? completedContestPnl;

  CollegeRewardTableBottomSheet({
    this.liveContest,
    this.upcomingContest,
    this.completedContest,
    this.completedContestPnl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (upcomingContest?.payoutType != "Reward" &&
              liveContest?.payoutType != "Reward" &&
              completedContest?.payoutType != "Reward")
          ? MediaQuery.of(context).size.height / 2
          : MediaQuery.of(context).size.height / 1.6,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'TestZone Rules',
                style: AppStyles.tsSecondaryMedium18,
              ),
              Divider(
                thickness: 1,
              ),
              if (liveContest != null) ...[
                ContestRules(
                  startTime: liveContest?.contestStartTime,
                  endTime: liveContest?.contestEndTime,
                  entryFee: liveContest?.entryFee,
                  payoutPercentage: liveContest?.payoutPercentage,
                  payoutCapPercentage: liveContest?.payoutCapPercentage,
                  portfolio: liveContest?.portfolio?.portfolioValue,
                  payoutType: liveContest?.payoutType,
                ),
              ],
              if (upcomingContest != null) ...[
                ContestRules(
                  startTime: upcomingContest?.contestStartTime,
                  endTime: upcomingContest?.contestEndTime,
                  entryFee: upcomingContest?.entryFee,
                  payoutPercentage: upcomingContest?.payoutPercentage,
                  payoutCapPercentage: upcomingContest?.payoutCapPercentage,
                  portfolio: upcomingContest?.portfolio?.portfolioValue,
                  payoutType: upcomingContest?.payoutType,
                ),
              ],
              if (completedContest != null) ...[
                ContestRules(
                  startTime: completedContest?.contestStartTime,
                  endTime: completedContest?.contestEndTime,
                  entryFee: completedContest?.entryFee,
                  payoutPercentage: completedContest?.payoutPercentage,
                  payoutCapPercentage: completedContest?.payoutCapPercentage,
                  portfolio: completedContestPnl?.portfolioValue,
                  payoutType: completedContest?.payoutType,
                ),
              ],
              if (liveContest?.payoutType == 'Reward' ||
                  upcomingContest?.payoutType == 'Reward' ||
                  completedContest?.payoutType == 'Reward') ...[
                Text(
                  'Reward Table',
                  style: AppStyles.tsSecondaryMedium18,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(height: 16),
                if (liveContest != null ||
                    upcomingContest != null ||
                    completedContest != null)
                  Table(
                    border: TableBorder.all(
                      color: AppColors.grey.shade50,
                    ),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              color: AppColors.grey.withOpacity(.1),
                              alignment: Alignment.center,
                              child: Text(
                                'Rank',
                                style: Theme.of(context)
                                    .textTheme
                                    .tsPrimaryMedium14,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              color: AppColors.grey.withOpacity(.1),
                              alignment: Alignment.center,
                              child: Text(
                                'Prize',
                                style: Theme.of(context)
                                    .textTheme
                                    .tsPrimaryMedium14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (liveContest != null)
                        for (LiveCollegeRewards reward
                            in liveContest?.rewards ?? [])
                          _buildRewardTableRow(context, reward),
                      if (upcomingContest != null)
                        for (UpcomingCollegeRewards reward
                            in upcomingContest?.rewards ?? [])
                          _buildRewardTableRow(context, reward),
                      if (completedContest != null)
                        for (CompletedCollegeRewards reward
                            in completedContest?.rewards ?? [])
                          _buildRewardTableRow(context, reward),
                    ],
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildRewardTableRow(BuildContext context, reward) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Text(
              reward.rankStart == reward.rankEnd
                  ? '${reward.rankStart}'
                  : '${reward.rankStart}-${reward.rankEnd}',
              style: Theme.of(context).textTheme.tsMedium10,
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Text(
              reward.prize is num
                  ? FormatHelper.formatNumbers(reward.prize, decimal: 0)
                  : "${reward.prize}",
              style: Theme.of(context).textTheme.tsMedium10,
            ),
          ),
        ),
      ],
    );
  }
}
