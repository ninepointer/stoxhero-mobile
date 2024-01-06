import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Book'),
          bottom: TabBar(
            indicatorColor: AppColors.lightGreen,
            tabs: [
              Tab(
                child: Text(
                  'TenX Trade\nOrders',
                  style: Theme.of(context).textTheme.tsRegular12,
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  'Market',
                  style: Theme.of(context).textTheme.tsRegular16,
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
                TenxTradeOrdersTabView(
                  tenxSub: controller.tenxTrade.value.sId,
                ),
                MarketOrdersView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Orders'),
//       ),
//       body: Obx(
//         () => CommonTabBar(
//           index: controller.selectedTabBarIndex.value,
//           onTap: controller.changeTabBarIndex,
//           tabsTitle: [
//             AppStrings.tenX,
//             AppStrings.virtual,
//           ],
//           tabs: [
//             CommonTabBar(
//               tabsTitle: [
//                 AppStrings.todayOrders,
//                 AppStrings.allOrders,
//               ],
//               tabs: [
//                 Visibility(
//                   visible: !controller.isLoadingStatus,
//                   replacement: CommonLoader(),
//                   child: TabBarView(
//                     children: [
//                       TenxTradeOrdersTabView(
//                         tenxSub: controller.tenxTrade.value.sId,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
