import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/widgets/common_chip.dart';

import '../../../app/app.dart';

class TenxTradingView extends StatefulWidget {
  const TenxTradingView({super.key});

  @override
  State<TenxTradingView> createState() => _TenxTradingViewState();
}

class _TenxTradingViewState extends State<TenxTradingView> {
  late TenxTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<TenxTradingController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CommonTabBar(
        isScrollable: true,
        index: controller.selectedTabBarIndex.value,
        onTap: controller.changeTabBarIndex,
        tabsTitle: [
          AppStrings.availableTenxPlans,
          AppStrings.subscribedTenxPlans,
          AppStrings.expiredTenxPlans,
          AppStrings.tenxLeaderboard,
        ],
        tabs: [
          RefreshIndicator(
            onRefresh: controller.getTenxActivePlans,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.tenxAvailableValidityList.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        for (PlanValidity item in controller.tenxAvailableValidityList)
                          CommonChip(
                            margin: EdgeInsets.only(right: 8),
                            label: item.label,
                            isSelected: item.label == controller.tenxAvailableValiditySelected.value.label,
                            onTap: () {
                              controller.tenxAvailableValiditySelected(item);
                              controller.updateTenxAvailablePlanValidity();
                            },
                          ),
                      ],
                    ),
                  ),
                SizedBox(height: 8),
                TenxInfoCard(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isActiveLoadingStatus,
                      child: ListViewShimmer(
                        itemCount: 10,
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.tenxAvailablePlans.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings.noDataFoundTenxActive,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.tenxAvailablePlans.length,
                          itemBuilder: (context, index) {
                            var sub = controller.tenxAvailablePlans[index];
                            return TenxActiveCard(
                              subscription: sub,
                              isActive: controller.userSubscriptionsIds.contains(sub.sId),
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
          RefreshIndicator(
            onRefresh: controller.getTenxSubscribedPlans,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.tenxSubscribedValidityList.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        for (PlanValidity item in controller.tenxSubscribedValidityList)
                          CommonChip(
                            margin: EdgeInsets.only(right: 8),
                            label: item.label,
                            isSelected: item.label == controller.tenxSubscribedValiditySelected.value.label,
                            onTap: () {
                              controller.tenxSubscribedValiditySelected(item);
                              controller.updateTenxSubscribedPlanValidity();
                            },
                          ),
                      ],
                    ),
                  ),
                SizedBox(height: 8),
                TenxInfoCard(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isSubscribeLoadingStatus,
                      child: ListViewShimmer(
                        itemCount: 10,
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.tenxSubscribedPlans.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings.noDataFoundTenxSubscribed,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.tenxSubscribedPlans.length,
                          itemBuilder: (context, index) {
                            var sub = controller.tenxSubscribedPlans[index];
                            return TenxSubscribedCard(
                              subscription: sub,
                              isActive: controller.userSubscriptionsIds.contains(sub.sId),
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
          RefreshIndicator(
            onRefresh: controller.getTenxExpiredPlans,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.tenxExpiredValidityList.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        for (PlanValidity item in controller.tenxExpiredValidityList)
                          CommonChip(
                            margin: EdgeInsets.only(right: 8),
                            label: item.label,
                            isSelected: item.label == controller.tenxExpiredValiditySelected.value.label,
                            onTap: () {
                              controller.tenxExpiredValiditySelected(item);
                              controller.updateTenxExpiredPlanValidity();
                            },
                          ),
                      ],
                    ),
                  ),
                SizedBox(height: 8),
                TenxInfoCard(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isExpiredLoadingStatus,
                      child: ListViewShimmer(
                        itemCount: 10,
                        shimmerCard: LargeCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.tenxExpiredPlans.isEmpty,
                        child: NoDataFound(
                          imagePath: AppImages.contestTrophy,
                          label: AppStrings.noDataFoundTenxExpired,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.tenxExpiredPlans.length,
                          itemBuilder: (context, index) {
                            var sub = controller.tenxExpiredPlans[index];
                            return TenxExpiredCard(
                              subscription: sub,
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
          RefreshIndicator(
            onRefresh: controller.getTenxLeaderboard,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 100),
              child: Visibility(
                visible: controller.isLeaderboardLoadingStatus,
                child: ListViewShimmer(
                  itemCount: 10,
                  shimmerCard: MediumCardShimmer(),
                ),
                replacement: Visibility(
                  visible: controller.tenxAvailablePlans.isEmpty,
                  child: NoDataFound(
                    imagePath: AppImages.contestTrophy,
                    label: AppStrings.noDataFoundTenxLeaderboard,
                  ),
                  replacement: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.tenxLeaderboard.length,
                    itemBuilder: (context, index) {
                      var sub = controller.tenxLeaderboard[index];
                      return TenxLeaderboardCard(
                        index: index + 1,
                        leaderboard: sub,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
