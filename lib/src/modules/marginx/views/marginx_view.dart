import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class MarginXView extends GetView<MarginXController> {
  const MarginXView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    if (controller.upComingMarginXList.isEmpty)
                      NoDataFound(
                        label: 'No Upcoming MarginX!',
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.upComingMarginXList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UpcomingMarginxCard(
                            upComingMarginx: controller.upComingMarginXList[index],
                          );
                        },
                      ),
                    SizedBox(height: 32),
                  ] else if (controller.segmentedControlValue.value == 1) ...[
                    controller.liveMarginXList.isEmpty
                        ? NoDataFound(
                            label: 'No Live MarginX!',
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.liveMarginXList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return LiveMarginxCard(
                                liveMarginx: controller.liveMarginXList[index],
                              );
                            },
                          ),
                    SizedBox(height: 32),
                  ] else if (controller.segmentedControlValue.value == 2) ...[
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.completedMarginXList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CompletedMarginxCard(
                          completedMarginx: controller.completedMarginXList[index],
                        );
                      },
                    ),
                    SizedBox(height: 32),
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
