import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class MarginxView extends GetView<MarginxController> {
  const MarginxView({Key? key}) : super(key: key);

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
                          var marginx = controller.upComingMarginXList[index];
                          return UpcomingMarginxCard(
                            marginXName: marginx.marginXName,
                            isNifty: marginx.isNifty,
                            isBankNifty: marginx.isBankNifty,
                            isFinNifty: marginx.isFinNifty,
                            marginXExpiry: marginx.marginXExpiry,
                            marginXStatus: marginx.status,
                            maxParticipants: marginx.maxParticipants,
                            startTime: marginx.startTime,
                            endTime: marginx.endTime,
                            entryFee: marginx.marginXTemplate?.entryFee,
                            portfolio: marginx.marginXTemplate?.portfolioValue,
                          );
                        },
                      ),
                  ] else if (controller.segmentedControlValue.value == 1) ...[
                    NoDataFound(
                      label: 'No Live MarginX!',
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.liveMarginXList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var marginx = controller.liveMarginXList[index];
                        return LiveMarginxCard(
                          marginXName: marginx.marginXName,
                          startTime: marginx.startTime,
                          endTime: marginx.endTime,
                          entryFee: marginx.marginXTemplate?.entryFee,
                          maxParticipants: marginx.maxParticipants,
                          portfolio: marginx.marginXTemplate?.portfolioValue,
                        );
                      },
                    ),
                  ] else if (controller.segmentedControlValue.value == 2) ...[
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.completedMarginXList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var marginx = controller.completedMarginXList[index];
                        return CompletedMarginxCard(
                          marginxName: marginx.marginxName,
                          isNifty: marginx.isNifty,
                          isBankNifty: marginx.isBankNifty,
                          isFinNifty: marginx.isFinNifty,
                          marginxExpiry: marginx.marginxExpiry,
                          startTime: marginx.startTime,
                          endTime: marginx.endTime,
                          entryFee: marginx.entryFee,
                          portfolioValue: marginx.portfolioValue,
                          npnl: marginx.npnl,
                          earning: marginx.earning,
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
