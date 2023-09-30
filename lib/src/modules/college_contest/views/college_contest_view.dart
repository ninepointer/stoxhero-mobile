import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/college_contest/controllers/college_contest_controller.dart';
import 'package:stoxhero/src/modules/college_contest/widgets/completed_college_contest_card.dart';
import 'package:stoxhero/src/modules/college_contest/widgets/upcoming_college_contest_card.dart';

import '../../../core/core.dart';
import '../widgets/live_college_contest_card.dart';

class CollegeContestView extends GetView<CollegeContestController> {
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
                        label: 'No Upcoming College Contest!',
                      ),
                    if (controller.premiumContestList.isNotEmpty) CommonTile(label: 'Premium Contests'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.premiumContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return UpComingCollegeContestCard(
                          upComingContest: controller.premiumContestList[index],
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    if (controller.freeContestList.isNotEmpty) CommonTile(label: 'Free Contests'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.freeContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return UpComingCollegeContestCard(
                          upComingContest: controller.freeContestList[index],
                        );
                      },
                    )
                  ] else if (controller.segmentedControlValue.value == 1) ...[
                    if (controller.liveCollegeContestList.isEmpty)
                      NoDataFound(
                        label: 'No Live Contest!',
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.liveCollegeContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LiveCollegeContestCard(
                            liveCollegeContest: controller.liveCollegeContestList[index],
                          );
                        },
                      )
                  ] else if (controller.segmentedControlValue.value == 2) ...[
                    if (controller.premiumCompletedContestList.isEmpty && controller.freeCompletedContestList.isEmpty)
                      NoDataFound(
                        label: 'No Completed College Contest!',
                      ),
                    if (controller.premiumCompletedContestList.isNotEmpty) CommonTile(label: 'Premium Contests'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.premiumCompletedContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CompletedCollegeContestCard(
                          completedCollegeContest: controller.premiumCompletedContestList[index],
                          completedContestPnl: controller.completedContestPnlList[index],
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    if (controller.freeCompletedContestList.isNotEmpty) CommonTile(label: 'Free Contests'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.freeCompletedContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CompletedCollegeContestCard(
                          completedCollegeContest: controller.freeCompletedContestList[index],
                          completedContestPnl: controller.completedContestPnlList[index],
                        );
                      },
                    ),
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
