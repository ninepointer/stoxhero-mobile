import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';
import 'package:stoxhero/src/modules/orders/views/infinity_trade_orders_tab_view.dart';
import 'package:stoxhero/src/modules/orders/views/tenx_trade_orders_tab_view.dart';

import 'virtual_trade_orders_tab_view.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            tabs: [
              controller.userDetailsData.designation == AppConstants.equityTraderType
                  ? Tab(
                      child: Text(
                        'Infinity Trade\nOrders',
                        style: Theme.of(context).textTheme.tsRegular12,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Tab(
                      child: Text(
                        'TenX Trade\nOrders',
                        style: Theme.of(context).textTheme.tsRegular12,
                        textAlign: TextAlign.center,
                      ),
                    ),
              Tab(
                child: Text(
                  'Virtual Trade\nOrders',
                  style: Theme.of(context).textTheme.tsRegular12,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        body: Obx(
          () => Visibility(
            visible: !controller.isLoadingStatus,
            replacement: CommonLoader(),
            child: TabBarView(
              children: [
                controller.userDetailsData.designation == AppConstants.equityTraderType
                    ? InfinityTradeOrdersTabView()
                    : TenxTradeOrdersTabView(),
                VirtualTradeOrdersTabView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
