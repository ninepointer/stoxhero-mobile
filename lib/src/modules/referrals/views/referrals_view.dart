import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class ReferralsView extends GetView<ReferralsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referrals'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  CommonSegmentedControl(
                    segments: {
                      0: 'Invite',
                      1: 'Referrals',
                    },
                    selectedSegment: controller.segmentedControlValue.value,
                    onValueChanged: controller.handleSegmentChange,
                  ),
                  if (controller.segmentedControlValue.value == 0)
                    InviteView()
                  else if (controller.segmentedControlValue.value == 1)
                    ReferralsLeaderboardView()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
