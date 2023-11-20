import 'package:flutter/material.dart';

import '../../../app/app.dart';

class CollegeContestView extends StatefulWidget {
  const CollegeContestView({Key? key}) : super(key: key);

  @override
  State<CollegeContestView> createState() => _CollegeContestViewState();
}

class _CollegeContestViewState extends State<CollegeContestView> {
  late CollegeContestController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CollegeContestController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College TestZone'),
      ),
      body: Obx(
        () => CommonTabBar(
          index: controller.selectedTabBarIndex.value,
          onTap: controller.changeTabBarIndex,
          tabsTitle: [
            AppStrings.testZoneLive,
            AppStrings.upcoming,
            AppStrings.completed,
          ],
          tabs: [
            CommonTabBar(
              tabsTitle: [
                AppStrings.free,
                AppStrings.premium,
              ],
              tabs: [
                RefreshIndicator(
                  onRefresh: controller.getLiveCollegeContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isLiveLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.liveFreeCollegeContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label:
                              AppStrings.noDataFoundForFreeLiveCollegeContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.liveFreeCollegeContestList.length,
                          itemBuilder: (BuildContext context, index) {
                            return LiveCollegeContestCard(
                              contest:
                                  controller.liveFreeCollegeContestList[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: controller.getLiveCollegeContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isLiveLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible:
                            controller.livePremiumCollegeContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings
                              .noDataFoundForPremiumLiveCollegeContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.livePremiumCollegeContestList.length,
                          itemBuilder: (BuildContext context, index) {
                            return LiveCollegeContestCard(
                              contest: controller
                                  .livePremiumCollegeContestList[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CommonTabBar(
              tabsTitle: [
                AppStrings.free,
                AppStrings.premium,
              ],
              tabs: [
                RefreshIndicator(
                  onRefresh: controller.getUpComingCollegeContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isUpcomingLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible:
                            controller.upcomingFreeCollegeContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings
                              .noDataFoundForFreeUpcomingCollegeContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.upcomingFreeCollegeContestList.length,
                          itemBuilder: (BuildContext context, index) {
                            return UpComingCollegeContestCard(
                              contest: controller
                                  .upcomingFreeCollegeContestList[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: controller.getUpComingCollegeContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isUpcomingLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller
                            .upcomingPremiumCollegeContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings
                              .noDataFoundForPremiumUpcomingCollegeContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller
                              .upcomingPremiumCollegeContestList.length,
                          itemBuilder: (BuildContext context, index) {
                            return UpComingCollegeContestCard(
                              contest: controller
                                  .upcomingPremiumCollegeContestList[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CommonTabBar(
              tabsTitle: [
                AppStrings.free,
                AppStrings.premium,
              ],
              tabs: [
                RefreshIndicator(
                  onRefresh: controller.getCompletedCollegeContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isCompletedLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible:
                            controller.completedFreeCollegeContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings
                              .noDataFoundForFreeCompletedCollegeContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.completedFreeCollegeContestList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final contest = controller
                                .completedFreeCollegeContestList[index];
                            CompletedContestPnl? matchingContestPnl;
                            for (var pnl
                                in controller.completedContestPnlList) {
                              if (pnl.contestId == contest.id) {
                                matchingContestPnl = pnl;
                                break;
                              }
                            }
                            return matchingContestPnl == null
                                ? SizedBox()
                                : CompletedCollegeContestCard(
                                    id: contest.id,
                                    contest: contest,
                                    completedContestPnl: matchingContestPnl,
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: controller.getCompletedCollegeContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isCompletedLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller
                            .completedPremiumCollegeContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings
                              .noDataFoundForPremiumCompletedCollegeContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller
                              .completedPremiumCollegeContestList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final contest = controller
                                .completedPremiumCollegeContestList[index];
                            CompletedContestPnl? matchingContestPnl;
                            for (var pnl
                                in controller.completedContestPnlList) {
                              if (pnl.contestId == contest.id) {
                                matchingContestPnl = pnl;
                                break;
                              }
                            }
                            return matchingContestPnl == null
                                ? SizedBox()
                                : CompletedCollegeContestCard(
                                    id: contest.id,
                                    contest: contest,
                                    completedContestPnl: matchingContestPnl,
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
