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
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            'Rank Start',
                            style: Theme.of(context).textTheme.tsMedium12,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Rank End',
                            style: Theme.of(context).textTheme.tsMedium12,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Prize',
                            style: Theme.of(context).textTheme.tsMedium12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (liveContest != null)
                    for (var reward in liveContest!.rewards ?? [])
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: Text(
                                '${reward.rankStart}',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                '${reward.rankEnd}',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
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
                            child: Center(
                              child: Text(
                                '${reward.rankStart}',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                '${reward.rankEnd}',
                                style: Theme.of(context).textTheme.tsMedium12,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
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
