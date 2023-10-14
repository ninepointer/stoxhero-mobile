import 'package:flutter/material.dart';
import '../../../app/app.dart';

class ContestListView extends GetView<ContestController> {
  const ContestListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contest List'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: RefreshIndicator(
            onRefresh: controller.loadData,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  CommonSegmentedControl(
                    segments: {
                      0: 'Live',
                      1: 'Upcoming',
                      2: 'Completed',
                    },
                    selectedSegment: controller.segmentedControlValue.value,
                    onValueChanged: controller.handleSegmentChange,
                  ),
                  if (controller.segmentedControlValue.value == 0) ...[
                    // Live Contests
                    CommonSegmentedControl(
                      segments: {
                        0: 'Premium',
                        1: 'Free',
                      },
                      selectedSegment: controller.liveSegmentedControlValue.value,
                      onValueChanged: controller.handleLiveSegmentChange,
                    ),

                    if (controller.liveSegmentedControlValue.value == 0) ...[
                      if (controller.livePremiumContestList.isEmpty)
                        NoDataFound(
                          image: Image.asset(
                            AppImages.contestTrophy,
                            height: 48,
                            width: 48,
                          ),
                          label:
                              'Oops! \nThere are no Premium Live Contest at the moment.\nPlease check Upcoming Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.livePremiumContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LiveContestCard(
                            contest: controller.livePremiumContestList[index],
                          );
                        },
                      ),
                    ] else if (controller.liveSegmentedControlValue.value == 1) ...[
                      if (controller.liveFreeContestList.isEmpty)
                        NoDataFound(
                          image: Image.asset(
                            AppImages.contestTrophy,
                            height: 48,
                            width: 48,
                          ),
                          label:
                              'Oops! \nThere are no Free Live Contest at the moment.\nPlease check Upcoming Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.liveFreeContestList.length,
                        itemBuilder: (BuildContext context, index) {
                          return LiveContestCard(
                            contest: controller.liveFreeContestList[index],
                          );
                        },
                      ),
                    ],
                    SizedBox(height: 12),
                  ] else if (controller.segmentedControlValue.value == 1) ...[
                    CommonSegmentedControl(
                      segments: {
                        0: 'Premium',
                        1: 'Free',
                      },
                      selectedSegment: controller.upcomingSegmentedControlValue.value,
                      onValueChanged: controller.handleUpcomingSegmentChange,
                    ),
                    if (controller.upcomingSegmentedControlValue.value == 0) ...[
                      if (controller.premiumContestList.isEmpty)
                        NoDataFound(
                          image: Image.asset(
                            AppImages.contestTrophy,
                            height: 48,
                            width: 48,
                          ),
                          label:
                              'Oops! \nThere are no Premium Upcoming Contest at the moment.\nPlease check Live Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.premiumContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UpComingContestCard(
                            contest: controller.premiumContestList[index],
                          );
                        },
                      ),
                    ] else if (controller.upcomingSegmentedControlValue.value == 1) ...[
                      if (controller.freeContestList.isEmpty)
                        NoDataFound(
                          image: Image.asset(
                            AppImages.contestTrophy,
                            height: 48,
                            width: 48,
                          ),
                          label:
                              'Oops! \nThere are no Free Upcoming Contest at the moment.\nPlease check Live Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.freeContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UpComingContestCard(
                            contest: controller.freeContestList[index],
                          );
                        },
                      ),
                    ],
                  ] else if (controller.segmentedControlValue.value == 2) ...[
                    CommonSegmentedControl(
                      segments: {
                        0: 'Premium',
                        1: 'Free',
                      },
                      selectedSegment: controller.completedSegmentedControlValue.value,
                      onValueChanged: controller.handleCompletedSegmentChange,
                    ),
                    if (controller.completedSegmentedControlValue.value == 0) ...[
                      if (controller.premiumCompletedContestList.isEmpty)
                        NoDataFound(
                          image: Image.asset(
                            AppImages.contestTrophy,
                            height: 48,
                            width: 48,
                          ),
                          label:
                              'Oops! \nThere are no Premium Completed Contest at the moment.\nPlease check Live Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.premiumCompletedContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final contest = controller.premiumCompletedContestList[index];
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
                                  completedContest: contest,
                                  completedContestPnl: matchingContestPnl,
                                );
                        },
                      ),
                    ] else if (controller.completedSegmentedControlValue.value == 1) ...[
                      if (controller.freeCompletedContestList.isEmpty)
                        NoDataFound(
                          image: Image.asset(
                            AppImages.contestTrophy,
                            height: 48,
                            width: 48,
                          ),
                          label:
                              'Oops! \nThere are no Free Completed Contest at the moment.\nPlease check Live Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.freeCompletedContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final contest = controller.freeCompletedContestList[index];
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
                                  completedContest: contest,
                                  completedContestPnl: matchingContestPnl,
                                );
                        },
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
