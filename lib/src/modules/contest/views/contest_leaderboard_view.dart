import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class ContestLeaderboardView extends GetView<ContestController> {
  const ContestLeaderboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contests Leaderboard'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: RefreshIndicator(
            onRefresh: controller.loadData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CommonSegmentedControl(
                    segments: {
                      0: 'StoxHero Contest',
                      1: 'College Contest',
                    },
                    selectedSegment: controller.segmentedControlValue.value,
                    onValueChanged: controller.handleSegmentChange,
                  ),
                  if (controller.segmentedControlValue.value == 0)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.contestLeaderboardList.length,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var user = controller.contestLeaderboardList[index];
                        return ContestLeaderboardCard(
                          name:
                              '${user.traderFirstName!.capitalizeFirst} ${user.traderLastName!.capitalizeFirst}',
                          strikeRate: user.strikeRate,
                          contestParticipated: user.contestParticipated,
                          contestWon: user.contestWon,
                          totalPayout: user.totalPayout,
                        );
                      },
                    )
                  else if (controller.segmentedControlValue.value == 1)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.collegeContestLeaderboardList.length,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var user = controller.collegeContestLeaderboardList[index];
                        return ContestLeaderboardCard(
                          name:
                              '${user.traderFirstName!.capitalizeFirst} ${user.traderLastName!.capitalizeFirst}',
                          strikeRate: user.strikeRate,
                          contestParticipated: user.contestParticipated,
                          contestWon: user.contestWon,
                          totalPayout: user.totalPayout,
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
