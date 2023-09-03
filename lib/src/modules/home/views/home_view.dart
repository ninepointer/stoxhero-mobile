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

  int _selectedIndex = 2;

  List<Widget> _tabs = [
    // TradingTabView(),
    DashboardView(),
    AnalyticsView(),
    TenxTradingView(),
    WalletView(),
    ContestView(),
  ];

  @override
  void initState() {
    controller = Get.find<HomeController>();
    super.initState();
  }

  void _updateTab(int index) {
    _selectedIndex = index;

    switch (index) {
      case 0:
        break;
      case 1:
        Get.find<AnalyticsController>().loadData();
        break;
      case 2:
        break;
      case 3:
        Get.find<TenxTradingController>().getTenxTradingActiveSubs();
        break;
      case 4:
        Get.find<ContestController>().loadData();
        break;
      default:
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CommonDrawer(),
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
                Obx(
                  () => Text(
                    controller.userDetailsData.firstName?.capitalizeFirst ?? '-',
                    style: Theme.of(context).textTheme.tsMedium16,
                  ),
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
              Get.find<WalletController>().loadData();
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
      body: _tabs[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _updateTab(2),
        child: Icon(
          Icons.currency_rupee_rounded,
          color: AppColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MaterialButton(
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bar_chart_rounded),
                      SizedBox(height: 4),
                      Text(
                        'Home',
                        style: Theme.of(context).textTheme.tsRegular12,
                      )
                    ],
                  ),
                  onPressed: () => _updateTab(0),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.analytics_rounded),
                      SizedBox(height: 4),
                      Text(
                        'Virtual',
                        style: Theme.of(context).textTheme.tsRegular12,
                      )
                    ],
                  ),
                  onPressed: () => _updateTab(1),
                ),
              ),
              SizedBox(width: 42),
              Expanded(
                child: MaterialButton(
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up_rounded),
                      SizedBox(height: 4),
                      Text(
                        'TenX',
                        style: Theme.of(context).textTheme.tsRegular12,
                      )
                    ],
                  ),
                  onPressed: () => _updateTab(3),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.groups),
                      SizedBox(height: 4),
                      Text(
                        'Contest',
                        style: Theme.of(context).textTheme.tsRegular12,
                      ),
                    ],
                  ),
                  onPressed: () => _updateTab(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
