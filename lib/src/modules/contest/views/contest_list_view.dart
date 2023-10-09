import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../contest_index.dart';

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
                    if (controller.livePremiumContestList.isEmpty && controller.liveFreeContestList.isEmpty)
                      NoDataFound(
                        label: 'No Live Contest!',
                      ),
                    if (controller.livePremiumContestList.isNotEmpty) CommonTile(label: 'Premium Contests'),
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
                    SizedBox(height: 8),
                    if (controller.liveFreeContestList.isNotEmpty) CommonTile(label: 'Free Contests'),
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
                    SizedBox(height: 12),
                  ] else if (controller.segmentedControlValue.value == 1) ...[
                    if (controller.premiumContestList.isEmpty && controller.freeContestList.isEmpty)
                      NoDataFound(
                        label: 'No Upcoming Contest!',
                      ),
                    if (controller.premiumContestList.isNotEmpty)
                      CommonTile(
                        label: 'Premium Contests',
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
                    SizedBox(height: 8),
                    if (controller.freeContestList.isNotEmpty)
                      CommonTile(
                        label: 'Free Contests',
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
                    )
                  ] else if (controller.segmentedControlValue.value == 2) ...[
                    if (controller.premiumCompletedContestList.isEmpty && controller.freeCompletedContestList.isEmpty)
                      NoDataFound(
                        label: 'No Completed Contest!',
                      ),
                    if (controller.premiumCompletedContestList.isNotEmpty) ...[
                      CommonTile(
                        label: 'Premium Contests',
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
                    ],
                    SizedBox(height: 8),
                    if (controller.freeCompletedContestList.isNotEmpty) ...[
                      CommonTile(
                        label: 'Free Contests',
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
                    ]
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
