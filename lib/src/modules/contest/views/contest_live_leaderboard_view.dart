import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class ContestLiveLeaderboardView extends GetView<ContestController> {
  const ContestLiveLeaderboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${controller.liveContest.value.contestName ?? 'Contest Trading'}',
          style: Theme.of(context).textTheme.tsRegular16,
          textAlign: TextAlign.center,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(height: 8),
            CommonRankCard(
              rank: controller.myRank.toString(),
              name: '${controller.userDetails.value.firstName} ${controller.userDetails.value.lastName} ',
              netPnL: controller.calculateTotalNetPNL().toString(),
              reward: controller.calculatePayout().toString(),
            ),
            CommonTile(label: 'Leaderboard'),
            Expanded(
              child: ListView.separated(
                itemCount: controller.liveLeaderboardList.length,
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  int rank = index + 1;
                  LiveContestLeaderboard user = controller.liveLeaderboardList[index];
                  return CommonRankCard(
                    rank: rank.toString(),
                    name: user.userName ?? '',
                    reward: controller.calculateUserPayout(user.npnl ?? 0).toString(),
                    netPnL: user.npnl?.toStringAsFixed(2) ?? '0',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
