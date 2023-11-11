import 'package:flutter/material.dart';

import '../../../app/app.dart';

class RewardTableBottomSheet extends StatelessWidget {
  final LiveContest? liveContest;
  final UpComingContest? upcomingContest;
  RewardTableBottomSheet({
    this.liveContest,
    this.upcomingContest,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Reward Table',
              style: AppStyles.tsSecondaryMedium18,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: 16),
            if (liveContest != null || upcomingContest != null)
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
                            style: Theme.of(context).textTheme.tsPrimaryMedium14,
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
                            style: Theme.of(context).textTheme.tsPrimaryMedium14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (liveContest != null)
                    for (Rewards reward in liveContest!.rewards ?? [])
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                reward.rankStart == reward.rankEnd
                                    ? '${reward.rankStart}'
                                    : '${reward.rankStart}-${reward.rankEnd}',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                '${reward.prize}',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                            ),
                          ),
                        ],
                      ),
                  if (upcomingContest != null)
                    for (var reward in upcomingContest!.rewards ?? [])
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                '${reward.rankEnd}',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                '${reward.prize}',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                            ),
                          ),
                        ],
                      ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
