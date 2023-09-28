import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/core.dart';
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
              child: Column(
                children: [
                  CommonSegmentedControl(
                    segments: {
                      0: 'Upcoming',
                      1: 'Live',
                      2: 'Completed',
                    },
                    selectedSegment: controller.segmentedControlValue.value,
                    onValueChanged: controller.handleSegmentChange,
                  ),
                  if (controller.segmentedControlValue.value == 0) ...[
                    if (controller.premiumContestList.isEmpty && controller.freeContestList.isEmpty)
                      NoDataFound(
                        label: 'No Upcoming Contest!',
                      ),
                    if (controller.premiumContestList.isNotEmpty)
                      CommonTile(label: 'Premium Contest\'s'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.premiumContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return UpComingContestCard(
                          upComingContest: controller.premiumContestList[index],
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    if (controller.freeContestList.isNotEmpty) CommonTile(label: 'Free Contest\'s'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.freeContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return UpComingContestCard(
                          upComingContest: controller.freeContestList[index],
                        );
                      },
                    )
                  ] else if (controller.segmentedControlValue.value == 1) ...[
                    if (controller.livePremiumContestList.isEmpty &&
                        controller.liveFreeContestList.isEmpty)
                      NoDataFound(
                        label: 'No Live Contest!',
                      ),
                    if (controller.livePremiumContestList.isNotEmpty)
                      CommonTile(label: 'Premium Contest\'s'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.livePremiumContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LiveContestCard(
                          liveContest: controller.livePremiumContestList[index],
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    if (controller.liveFreeContestList.isNotEmpty)
                      CommonTile(label: 'Free Contest\'s'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.liveFreeContestList.length,
                      itemBuilder: (BuildContext context, index) {
                        return LiveContestCard(
                          liveContest: controller.liveFreeContestList[index],
                        );
                      },
                    ),
                    SizedBox(height: 12),
                  ] else if (controller.segmentedControlValue.value == 2) ...[
                    if (controller.premiumCompletedContestList.isNotEmpty)
                      CommonTile(label: 'Premium Contests'),
                    SizedBox(height: 8),
                    if (controller.freeCompletedContestList.isNotEmpty)
                      CommonTile(label: 'Free Contests'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.completedContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final completedContest = controller.completedContestList[index];
                        final matchingContestPnl = controller.completedContestPnlList.firstWhere(
                          (pnl) => pnl.contestId == completedContest.id,
                        );
                        return CompletedContestCard(
                          id: completedContest.id,
                          completedContest: completedContest,
                          completedContestPnl: matchingContestPnl,
                        );
                      },
                    ),
                    SizedBox(height: 48)
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
