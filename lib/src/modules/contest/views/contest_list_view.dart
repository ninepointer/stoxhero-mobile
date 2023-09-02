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
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.upComingContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return UpComingContestCard(
                          contestDetails: controller.upComingContestList[index],
                        );
                      },
                    ),
                  ],
                  if (controller.segmentedControlValue.value == 1) ...[
                    if (controller.premiumContestList.isEmpty && controller.freeContestList.isEmpty)
                      NoDataFound(
                        label: 'No Live Contest!',
                      ),
                  ],
                  if (controller.segmentedControlValue.value == 2 &&
                      controller.completedContestList.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.completedContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CompletedContestCard(
                          contestDetails: controller.completedContestList[index],
                        );
                      },
                    ),
                  if (controller.premiumContestList.isNotEmpty) ...[
                    Column(
                      children: [
                        CommonTile(label: 'Premium Contests'),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.premiumContestList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return OnGoingContestCard(
                              contestDetails: controller.premiumContestList[index],
                            );
                          },
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ],
                  if (controller.freeContestList.isNotEmpty) ...[
                    Column(
                      children: [
                        CommonTile(label: 'Free Contests'),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.freeContestList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return OnGoingContestCard(
                              contestDetails: controller.freeContestList[index],
                            );
                          },
                        ),
                      ],
                    ),
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
