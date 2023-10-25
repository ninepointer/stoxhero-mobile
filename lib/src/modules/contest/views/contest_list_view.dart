import 'package:flutter/material.dart';
import '../../../app/app.dart';

class ContestListView extends StatefulWidget {
  const ContestListView({Key? key}) : super(key: key);

  @override
  State<ContestListView> createState() => _ContestListViewState();
}

class _ContestListViewState extends State<ContestListView> {
  late ContestController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ContestController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contests'),
      ),
      body: Obx(
        () => CommonTabBar(
          index: controller.selectedTabBarIndex.value,
          onTap: controller.changeTabBarIndex,
          tabsTitle: [
            AppStrings.live,
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
                  onRefresh: controller.getLiveContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isLiveLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.liveFreeContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings.noDataFoundForFreeLiveContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.liveFreeContestList.length,
                          itemBuilder: (BuildContext context, index) {
                            String userId = controller.userDetailsData.sId ?? '';
                            return LiveContestCard(
                              userId: userId,
                              contest: controller.liveFreeContestList[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: controller.getLiveContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isLiveLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.livePremiumContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings.noDataFoundForPremiumLiveContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.livePremiumContestList.length,
                          itemBuilder: (BuildContext context, index) {
                            String userId = controller.userDetailsData.sId ?? '';
                            return LiveContestCard(
                              userId: userId,
                              contest: controller.livePremiumContestList[index],
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
                  onRefresh: controller.getUpComingContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isUpcomingLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.upcomingFreeContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings.noDataFoundForFreeUpcomingContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.upcomingFreeContestList.length,
                          itemBuilder: (BuildContext context, index) {
                            String userId = controller.userDetailsData.sId ?? '';
                            return UpComingContestCard(
                              userId: userId,
                              contest: controller.upcomingFreeContestList[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: controller.getUpComingContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isUpcomingLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.upcomingPremiumContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings.noDataFoundForPremiumUpcomingContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.upcomingPremiumContestList.length,
                          itemBuilder: (BuildContext context, index) {
                            String userId = controller.userDetailsData.sId ?? '';
                            return UpComingContestCard(
                              userId: userId,
                              contest: controller.upcomingPremiumContestList[index],
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
                  onRefresh: controller.getCompletedContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isCompletedLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.completedFreeContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings.noDataFoundForFreeCompletedContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.completedFreeContestList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final contest = controller.completedFreeContestList[index];
                            CompletedContestPnl? matchingContestPnl;
                            for (var pnl in controller.completedContestPnlList) {
                              if (pnl.contestId == contest.id) {
                                matchingContestPnl = pnl;
                                break;
                              }
                            }
                            return matchingContestPnl == null
                                ? SizedBox()
                                : CompletedContestCard(
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
                  onRefresh: controller.getCompletedContestList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isCompletedLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.completedPremiumContestList.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings.noDataFoundForPremiumCompletedContest,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.completedPremiumContestList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final contest = controller.completedPremiumContestList[index];
                            CompletedContestPnl? matchingContestPnl;
                            for (var pnl in controller.completedContestPnlList) {
                              if (pnl.contestId == contest.id) {
                                matchingContestPnl = pnl;
                                break;
                              }
                            }
                            return matchingContestPnl == null
                                ? SizedBox()
                                : CompletedContestCard(
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
