import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class MarginXView extends StatefulWidget {
  const MarginXView({Key? key}) : super(key: key);

  @override
  State<MarginXView> createState() => _MarginXViewState();
}

class _MarginXViewState extends State<MarginXView>
    with TickerProviderStateMixin {
  late MarginXController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<MarginXController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => CommonTabBar(
          index: controller.selectedTabBarIndex.value,
          onTap: controller.changeTabBarIndex,
          tabsTitle: [
            AppStrings.live,
            AppStrings.upcoming,
            AppStrings.completed,
          ],
          tabs: [
            RefreshIndicator(
              onRefresh: controller.getLiveMarginXList,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: controller.isLiveLoadingStatus,
                  child: ListViewShimmer(
                    shimmerCard: LargeCardShimmer(),
                  ),
                  replacement: Visibility(
                    visible: controller.liveMarginXList.isEmpty,
                    child: NoDataFound(
                      imagePath: AppImages.contestTrophy,
                      label: AppStrings.noDataFoundForPremiumLiveMarginX,
                    ),
                    replacement: ListView.builder(
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
                  ),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: controller.getUpComingMarginXList,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: controller.isUpcomingLoadingStatus,
                  child: ListViewShimmer(
                    shimmerCard: LargeCardShimmer(),
                  ),
                  replacement: Visibility(
                    visible: controller.upComingMarginXList.isEmpty,
                    child: NoDataFound(
                      imagePath: AppImages.contestTrophy,
                      label: AppStrings.noDataFoundForPremiumUpcomingMarginX,
                    ),
                    replacement: ListView.builder(
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
                  ),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: controller.getCompletedMarginXList,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: controller.isCompletedLoadingStatus,
                  child: ListViewShimmer(
                    shimmerCard: LargeCardShimmer(),
                  ),
                  replacement: Visibility(
                    visible: controller.completedMarginXList.isEmpty,
                    child: NoDataFound(
                      imagePath: AppImages.contestTrophy,
                      label: AppStrings.noDataFoundForPremiumCompletedMarginX,
                    ),
                    replacement: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.completedMarginXList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CompletedMarginxCard(
                          marginx: controller.completedMarginXList[index],
                        );
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
