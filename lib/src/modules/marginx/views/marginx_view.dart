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
                      0: 'Live',
                      1: 'Upcoming',
                      2: 'Completed',
                    },
                    selectedSegment: controller.segmentedControlValue.value,
                    onValueChanged: controller.handleSegmentChange,
                  ),
                  if (controller.segmentedControlValue.value == 0) ...[
                    controller.liveMarginXList.isEmpty
                        ? NoDataFound(
                            image: Image.asset(
                              AppImages.contestTrophy,
                              height: 48,
                              width: 48,
                            ),
                            label: 'Oops! \nThere are no live marginX at the moment.\nPlease check upcoming marginX!',
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.liveMarginXList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return LiveMarginxCard(
                                marginx: controller.liveMarginXList[index],
                              );
                            },
                          ),
                    SizedBox(height: 32),
                  ] else if (controller.segmentedControlValue.value == 1) ...[
                    controller.upComingMarginXList.isEmpty
                        ? NoDataFound(
                            image: Image.asset(
                              AppImages.contestTrophy,
                              height: 48,
                              width: 48,
                            ),
                            label: 'Oops! \nThere are no Upcoming MarginX at the moment.\nPlease check Live MarginX!',
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.upComingMarginXList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return UpcomingMarginxCard(
                                marginx: controller.upComingMarginXList[index],
                              );
                            },
                          ),
                    SizedBox(height: 32),
                  ] else if (controller.segmentedControlValue.value == 2) ...[
                    controller.completedMarginXList.isEmpty
                        ? NoDataFound(
                            image: Image.asset(
                              AppImages.contestTrophy,
                              height: 48,
                              width: 48,
                            ),
                            label: 'Oops! \nThere are no Completed MarginX at the moment.\nPlease check Live MarginX!',
                          )
                        : ListView.builder(
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
