import 'package:flutter/material.dart';

import '../../../app/app.dart';

class TenxTradingView extends StatefulWidget {
  const TenxTradingView({super.key});

  @override
  State<TenxTradingView> createState() => _TenxTradingViewState();
}

class _TenxTradingViewState extends State<TenxTradingView> {
  late TenxTradingController controller;

  bool isExpanded = false;

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
            onRefresh: controller.getTenxTradingActiveSubs,
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
                  visible: controller.tenxActiveSub.isEmpty,
                  child: NoDataFound(
                    imagePath: AppImages.contestTrophy,
                    label: AppStrings.noDataFoundTenxActive,
                  ),
                  replacement: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.tenxActiveSub.length,
                    itemBuilder: (context, index) {
                      var sub = controller.tenxActiveSub[index];
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
          RefreshIndicator(
            onRefresh: controller.getTenxMyActiveSubscribed,
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
                  visible: controller.tenxActiveSub.isEmpty,
                  child: NoDataFound(
                    imagePath: AppImages.contestTrophy,
                    label: AppStrings.noDataFoundTenxSubscribed,
                  ),
                  replacement: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.tenxMyActiveSubcribedList.length,
                    itemBuilder: (context, index) {
                      var sub = controller.tenxMyActiveSubcribedList[index];
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
          RefreshIndicator(
            onRefresh: controller.getTenxMyExpiredSubscription,
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
                  visible: controller.tenxActiveSub.isEmpty,
                  child: NoDataFound(
                    imagePath: AppImages.contestTrophy,
                    label: AppStrings.noDataFoundTenxExpired,
                  ),
                  replacement: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.tenxMyExpiredSubcriptionList.length,
                    itemBuilder: (context, index) {
                      var sub = controller.tenxMyExpiredSubcriptionList[index];
                      return TenxExpiredCard(
                        subscription: sub,
                      );
                    },
                  ),
                ),
              ),
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
                  visible: controller.tenxActiveSub.isEmpty,
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
    //   () => Visibility(
    //     visible: !controller.isLoadingStatus,
    //     replacement: CommonLoader(),
    //     child: RefreshIndicator(
    //       onRefresh: controller.loadData,
    //       child: SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             CommonCard(
    //               onTap: () => setState(() => isExpanded = !isExpanded),
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       'What is TenX Trading / TenX ट्रेडिंग क्या है?',
    //                       style: AppStyles.tsSecondaryRegular16,
    //                     ),
    //                     Icon(
    //                       isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
    //                       color: AppColors.grey,
    //                     ),
    //                   ],
    //                 ),
    //                 if (isExpanded)
    //                   Column(
    //                     children: [
    //                       SizedBox(height: 16),
    //                       Text(
    //                         AppData.tenxInfoEnglish,
    //                         style: Theme.of(context).textTheme.tsRegular14,
    //                       ),
    //                       SizedBox(height: 16),
    //                       Text(
    //                         AppData.tenxInfoHindi,
    //                         style: Theme.of(context).textTheme.tsRegular14,
    //                       ),
    //                     ],
    //                   ),
    //               ],
    //             ),
    //             ListView.builder(
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: controller.tenxActiveSub.length,
    //               itemBuilder: (context, index) {
    //                 var sub = controller.tenxActiveSub[index];
    //                 return Obx(
    //                   () => TenxNewCard(
    //                     subscription: sub,
    //                     isActive: controller.userSubscriptionsIds.contains(sub.sId),
    //                   ),
    //                   // TenxTradingSubscriptionCard(
    //                   //   subscription: sub,
    //                   //   isActive: controller.userSubscriptionsIds.contains(sub.sId),
    //                   // ),
    //                 );
    //               },
    //             ),
    //             SizedBox(height: 36),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
