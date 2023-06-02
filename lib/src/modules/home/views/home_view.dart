import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';
import 'tenx_trading_tab_view.dart';
import 'trading_tab_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController controller;

  int _selectedIndex = 2;

  List<Widget> _tabs = [
    TradingTabView(),
    AnalyticsView(),
    TenxTradingTabView(),
    WalletView(),
    ReferralsView(),
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
        controller.getTenxTradingActiveSubs();
        break;
      case 3:
        Get.find<WalletController>().loadData();
        break;
      case 4:
        Get.find<ReferralsController>().loadData();
        break;
      default:
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            AppLogoWidget(
              logoSize: 32,
              hasLabel: false,
            ),
            SizedBox(width: 8),
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
                    style: AppStyles.tsWhiteMedium16,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
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
        color: AppColors.netural,
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
                        'Trading',
                        style: AppStyles.tsWhiteRegular12,
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
                        'Analytics',
                        style: AppStyles.tsWhiteRegular12,
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
                      Icon(Icons.account_balance_wallet_rounded),
                      SizedBox(height: 4),
                      Text(
                        'Wallet',
                        style: AppStyles.tsWhiteRegular12,
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
                        'Referrals',
                        style: AppStyles.tsWhiteRegular12,
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
