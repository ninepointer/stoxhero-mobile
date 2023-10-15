import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class ReferralsView extends StatefulWidget {
  @override
  State<ReferralsView> createState() => _ReferralsViewState();
}

class _ReferralsViewState extends State<ReferralsView> {
  late ReferralsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ReferralsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.referrals),
      ),
      body: Obx(
        () => CommonTabBar(
          index: controller.selectedTabBarIndex.value,
          onTap: controller.changeTabBarIndex,
          tabsTitle: [
            AppStrings.invite,
            AppStrings.referrals,
          ],
          tabs: [
            InviteView(),
            ReferralsLeaderboardView(),
          ],
        ),
      ),
    );
  }
}
