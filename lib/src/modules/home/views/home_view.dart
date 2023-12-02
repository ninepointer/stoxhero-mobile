import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';
import '../../virtual_trading/views/virtual_dashboard_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController controller;

  List<Widget> _tabs = [
    DashboardView(),
    FutureAndOptionDashBoard(),
    TenxTradingView(),
    MarginXView(),
    ContestView(),
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeController>();
  }

  void _updateTab(int index) {
    controller.selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.find<HomeController>().loadData();
        Get.find<ContestController>().getLiveContestList();
        Get.find<ContestController>().getUpComingContestList();
        Get.find<CollegeContestController>().getLiveCollegeContestList();
        Get.find<WalletController>().getWalletTransactionsList();
        Get.find<ContestController>().getFeaturedContest();
        Get.find<ContestProfileController>().getWeeklyTopPerformerFullList();
        break;
      case 1:
        // Get.find<VirtualTradingController>().loadData();
        break;
      case 2:
        Get.find<TenxTradingController>().loadData();
        break;
      case 3:
        Get.find<MarginXController>().loadData();
        break;
      case 4:
        // Blank
        break;
      default:
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CommonDrawer(),
      onDrawerChanged: (isOpened) {
        if (isOpened) controller.userDetails(AppStorage.getUserDetails());
      },
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: AppStyles.tsGreyRegular12,
                ),
                Text(
                  controller.userDetailsData.firstName?.capitalizeFirst ?? '-',
                  style: Theme.of(context).textTheme.tsMedium16,
                ),
              ],
            ),
          ],
        ),
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () {
                final controller = Get.find<WalletController>();
                controller.loadData();
                controller.selectedTabBarIndex(0);
                Get.toNamed(AppRoutes.wallet);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.grey.withOpacity(.1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_rounded,
                      color: AppColors.secondary,
                    ),
                    SizedBox(width: 12),
                    Text(
                      FormatHelper.formatNumbers(
                        Get.find<WalletController>().totalCashAmount.value,
                      ),
                      style: AppStyles.tsBlackMedium14.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.person),
            onPressed: () => Get.toNamed(AppRoutes.profile),
          ),
        ],
      ),
      body: Obx(() => _tabs[controller.selectedIndex.value]),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor:
            Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
        onPressed: () => _updateTab(2),
        child: Icon(
          Icons.currency_rupee_rounded,
          color: AppColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: Container(
            height: 60,
            margin: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabButton(
                  context,
                  index: 0,
                  label: 'Home',
                  icon: Icons.bar_chart_rounded,
                ),
                _buildTabButton(
                  context,
                  index: 1,
                  label: 'Market',
                  icon: Icons.analytics_rounded,
                ),
                SizedBox(width: 40),
                _buildTabButton(
                  context,
                  index: 3,
                  label: 'MarginX',
                  icon: Icons.trending_up_rounded,
                ),
                _buildTabButton(
                  context,
                  index: 4,
                  label: 'TestZone',
                  icon: Icons.groups_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildTabButton(
    BuildContext context, {
    required int index,
    required String label,
    required IconData icon,
  }) {
    return Expanded(
      child: MaterialButton(
        minWidth: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: controller.selectedIndex.value == index
                  ? Get.isDarkMode
                      ? AppColors.darkGreen
                      : AppColors.lightGreen
                  : AppColors.grey,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.tsRegular11.copyWith(
                    color: controller.selectedIndex.value == index
                        ? Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen
                        : AppColors.grey,
                  ),
            )
          ],
        ),
        onPressed: () => _updateTab(index),
      ),
    );
  }
}
