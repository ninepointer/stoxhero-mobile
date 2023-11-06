import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/college_contest/widgets/college_contest_leaderboard_card.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class ContestLeaderboardView extends StatefulWidget {
  const ContestLeaderboardView({Key? key}) : super(key: key);

  @override
  State<ContestLeaderboardView> createState() => _ContestLeaderboardViewState();
}

class _ContestLeaderboardViewState extends State<ContestLeaderboardView> {
  late ContestController contestController;
  late CollegeContestController collegeContestController;
  @override
  void initState() {
    super.initState();
    contestController = Get.find<ContestController>();
    collegeContestController = Get.find<CollegeContestController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contests Leaderboard'),
      ),
      body: Obx(
        () => CommonTabBar(
          index: contestController.selectedTabBarIndex.value,
          onTap: contestController.changeTabBarIndex,
          tabsTitle: [
            AppStrings.stoxHeroContests,
            AppStrings.collegeContests,
          ],
          tabs: [
            RefreshIndicator(
              onRefresh: contestController.getContestLeaderboardList,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: contestController.isLeaderboardLoadingStatus,
                  child: ListViewShimmer(
                    itemCount: 10,
                    shimmerCard: MediumCardShimmer(),
                  ),
                  replacement: Visibility(
                      visible: contestController.contestLeaderboardList.isEmpty,
                      child: NoDataFound(
                        imagePath: AppImages.contestTrophy,
                        label: AppStrings.noDataFoundContestLeaderboard,
                      ),
                      replacement: ListView.builder(
                        shrinkWrap: true,
                        itemCount: contestController.contestLeaderboardList.length,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ContestLeaderboardCard(
                            index: index + 1,
                            contestLeaderboard: contestController.contestLeaderboardList[index],
                          );
                        },
                      )),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: collegeContestController.getCollegeContestLeaderboardList,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: collegeContestController.isLeaderboardLoadingStatus,
                  child: ListViewShimmer(
                    itemCount: 10,
                    shimmerCard: MediumCardShimmer(),
                  ),
                  replacement: Visibility(
                    visible: collegeContestController.collegeContestLeaderboardList.isEmpty,
                    child: NoDataFound(
                      imagePath: AppImages.contestTrophy,
                      label: AppStrings.noDataFoundCollegeContestLeaderboard,
                    ),
                    replacement: ListView.builder(
                      shrinkWrap: true,
                      itemCount: collegeContestController.collegeContestLeaderboardList.length,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CollegeContestLeaderboardCard(
                          index: index + 1,
                          contestLeaderboard: collegeContestController.collegeContestLeaderboardList[index],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
