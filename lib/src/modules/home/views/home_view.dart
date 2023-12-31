import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController controller;

  List<Widget> _tabs = [
    DashboardView(),
    VirtualTradingView(),
    TenxTradingView(),
    MarginXView(),
    ContestView(),
  ];

  @override
  void initState() {
    controller = Get.find<HomeController>();
    super.initState();
  }

  void _updateTab(int index) {
    controller.selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.find<HomeController>().loadData();
        Get.find<ContestController>().getLiveContestList();
        Get.find<ContestController>().getUpComingContestList();
        break;
      case 1:
        Get.find<VirtualTradingController>().loadData();
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
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.account_balance_wallet_rounded),
            onPressed: () {
              final controller = Get.find<WalletController>();
              controller.loadData();
              controller.selectedTabBarIndex(0);
              Get.toNamed(AppRoutes.wallet);
            },
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
        backgroundColor: AppColors.primary,
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
                  label: 'Virtual',
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
                  label: 'Contest',
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
              color: controller.selectedIndex.value == index ? Theme.of(context).primaryColor : AppColors.grey,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.tsRegular12.copyWith(
                    color: controller.selectedIndex.value == index ? Theme.of(context).primaryColor : AppColors.grey,
                  ),
            )
          ],
        ),
        onPressed: () => _updateTab(index),
      ),
    );
  }
}
