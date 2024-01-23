import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class MarketOrdersView extends GetView<OrdersController> {
  const MarketOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Obx(
          () => Visibility(
            visible: !controller.isLoadingStatus,
            replacement: CommonLoader(),
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'F&O'),
                    Tab(text: 'Stock'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      VirtualTradeOrdersTabView(),
                      EquityTraderOrdersView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
