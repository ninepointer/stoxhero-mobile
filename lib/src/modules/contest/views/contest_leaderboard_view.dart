import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/college_contest/widgets/college_contest_leaderboard_card.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class ContestLeaderboardView extends StatelessWidget {
  final ContestController contestController;
  final CollegeContestController collegeContestController;
  const ContestLeaderboardView({
    Key? key,
    required this.contestController,
    required this.collegeContestController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contests Leaderboard'),
      ),
      body: Obx(
        () => Visibility(
          visible: !contestController.isLoadingStatus,
          replacement: CommonLoader(),
          child: RefreshIndicator(
            onRefresh: contestController.loadData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CommonSegmentedControl(
                    segments: {
                      0: 'StoxHero Contest',
                      1: 'College Contest',
                    },
                    selectedSegment: contestController.segmentedControlValue.value,
                    onValueChanged: contestController.handleSegmentChange,
                  ),
                  if (contestController.segmentedControlValue.value == 0)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: contestController.contestLeaderboardList.length,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ContestLeaderboardCard(
                          contestLeaderboard: contestController.contestLeaderboardList[index],
                        );
                      },
                    )
                  else if (contestController.segmentedControlValue.value == 1)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: collegeContestController.collegeContestLeaderboardList.length,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CollegeContestLeaderboardCard(
                          contestLeaderboard: collegeContestController.collegeContestLeaderboardList[index],
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
