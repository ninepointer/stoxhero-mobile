import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../data/data.dart';

class ReferralsView extends GetView<ReferralsController> {
  num getTotalUserReferralEarning(List<Referrals> referrals) {
    num amount = 0;
    for (var item in referrals) {
      amount += item.referralEarning ?? 0;
    }
    return amount;
  }

  void handleSegmentChange(int val) {
    controller.changeSegment(val);
    // Get.find<ReferralsController>().loadData();
  }

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
                    onValueChanged: handleSegmentChange,
                  ),
                  if (controller.segmentedControlValue.value == 0)
                    InviteView()
                  else if (controller.segmentedControlValue.value == 2)
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
