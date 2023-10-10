import 'package:flutter/material.dart';

import '../../../app/app.dart';

class CollegeContestView extends GetView<CollegeContestController> {
  const CollegeContestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Contest List'),
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
                    CommonSegmentedControl(
                      segments: {
                        0: 'Premium',
                        1: 'Free',
                      },
                      selectedSegment: controller.liveSegmentedControlValue.value,
                      onValueChanged: controller.handleLiveSegmentChange,
                    ),
                    if (controller.liveSegmentedControlValue.value == 0) ...[
                      if (controller.livePremiumCollegeContestList.isEmpty)
                        NoDataFound(
                          label: 'No Premium Live Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.livePremiumCollegeContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LiveCollegeContestCard(
                            contest: controller.livePremiumCollegeContestList[index],
                          );
                        },
                      ),
                    ] else if (controller.liveSegmentedControlValue.value == 1) ...[
                      if (controller.liveFreeCollegeContestList.isEmpty)
                        NoDataFound(
                          label: 'No Free Live Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.liveFreeCollegeContestList.length,
                        itemBuilder: (BuildContext context, index) {
                          return LiveCollegeContestCard(
                            contest: controller.liveFreeCollegeContestList[index],
                          );
                        },
                      ),
                    ],
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
                          label: 'No Premium Upcoming Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.premiumContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UpComingCollegeContestCard(
                            contest: controller.premiumContestList[index],
                          );
                        },
                      ),
                    ] else if (controller.upcomingSegmentedControlValue.value == 1) ...[
                      if (controller.freeCompletedContestList.isEmpty)
                        NoDataFound(
                          label: 'No Free Upcoming Contest!',
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.freeContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UpComingCollegeContestCard(
                            contest: controller.freeContestList[index],
                          );
                        },
                      )
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
                          label: 'No Premium Completed Contest!',
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
                              : CompletedCollegeContestCard(
                                  id: contest.id,
                                  completedContest: contest,
                                  completedContestPnl: matchingContestPnl,
                                );
                        },
                      ),
                    ] else if (controller.completedSegmentedControlValue.value == 1) ...[
                      if (controller.freeCompletedContestList.isEmpty)
                        NoDataFound(
                          label: 'No Free Completed Contest!',
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
                              : CompletedCollegeContestCard(
                                  id: contest.id,
                                  completedContest: contest,
                                  completedContestPnl: matchingContestPnl,
                                );
                        },
                      ),
                    ],
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
