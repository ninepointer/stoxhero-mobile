import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class TutorialView extends StatefulWidget {
  const TutorialView({Key? key}) : super(key: key);

  @override
  State<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  late TutorialController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<TutorialController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorials'),
      ),
      body: Obx(
        () => CommonTabBar(
          index: controller.selectedTabBarIndex.value,
          onTap: controller.changeTabBarIndex,
          tabsTitle: [
            AppStrings.appTutorial,
            AppStrings.optionTrading,
          ],
          tabs: [
            RefreshIndicator(
              onRefresh: controller.getTutorialList,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: controller.isLoadingStatus,
                  child: ListViewShimmer(
                    shimmerCard: LargeCardShimmer(),
                  ),
                  replacement: Visibility(
                    visible: controller.tutorialList.isEmpty,
                    child: NoDataFound(
                      imagePath: AppImages.contestTrophy,
                      label: AppStrings.noDataFoundForPremiumLiveMarginX,
                    ),
                    replacement: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: controller.tutorialList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final tutorial = controller.tutorialList[index];
                        if (tutorial.sId == controller.tutorialList[1].sId) {
                          return AppTutorialCard(tutorial: tutorial);
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: controller.getTutorialList,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: controller.isLoadingStatus,
                  child: ListViewShimmer(
                    shimmerCard: LargeCardShimmer(),
                  ),
                  replacement: Visibility(
                    visible: controller.tutorialList.isEmpty,
                    child: NoDataFound(
                      imagePath: AppImages.contestTrophy,
                      label: AppStrings.noDataFoundForPremiumUpcomingMarginX,
                    ),
                    replacement: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.tutorialList.length,
                      itemBuilder: (context, index) {
                        final tutorial = controller.tutorialList[index];
                        if (tutorial.sId == controller.tutorialList[0].sId) {
                          return OptionTradingCard(tutorial: tutorial);
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
