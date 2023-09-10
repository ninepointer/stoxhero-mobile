import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class CollegeContestView extends GetView<ContestController> {
  const CollegeContestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Contests'),
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
                        return UpComingContestCard();
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
                      controller.completedCollegeContestList.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.completedCollegeContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var contest = controller.completedCollegeContestList[index];
                        return CompletedContestCard(
                            // contestName: contest.contestName,
                            // isNifty: contest.isNifty,
                            // isBankNifty: contest.isBankNifty,
                            // isFinNifty: contest.isFinNifty,
                            // isAllIndex: contest.isAllIndex,
                            // contestStartTime: contest.contestStartTime,
                            // contestEndTime: contest.contestEndTime,
                            // contestStatus: contest.contestStatus,
                            // entryFee: contest.entryFee,
                            // payoutPercentage: contest.payoutPercentage,
                            // portfolio: contest.portfolio,
                            );
                      },
                    ),
                  // if (controller.premiumContestList.isNotEmpty) ...[
                  //   Column(
                  //     children: [
                  //       CommonTile(label: 'Premium Contests'),
                  //       ListView.builder(
                  //         shrinkWrap: true,
                  //         padding: EdgeInsets.zero,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemCount: controller.premiumContestList.length,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           return OnGoingContestCard(
                  //             contestDetails: controller.premiumContestList[index],
                  //           );
                  //         },
                  //       ),
                  //       SizedBox(height: 8),
                  //     ],
                  //   ),
                  // ],
                  // if (controller.freeContestList.isNotEmpty) ...[
                  //   Column(
                  //     children: [
                  //       CommonTile(label: 'Free Contests'),
                  //       ListView.builder(
                  //         shrinkWrap: true,
                  //         padding: EdgeInsets.zero,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemCount: controller.freeContestList.length,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           return OnGoingContestCard(
                  //             contestDetails: controller.freeContestList[index],
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
