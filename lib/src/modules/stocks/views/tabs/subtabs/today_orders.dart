import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:stoxhero/src/modules/stocks/widget/orders_card.dart';

import '../../../../../core/core.dart';
import '../../../controllers/stocks_controller.dart';

class StockTodayOrders extends StatefulWidget {
  const StockTodayOrders({Key? key}) : super(key: key);

  @override
  State<StockTodayOrders> createState() => _StockTodayOrdersState();
}

class _StockTodayOrdersState extends State<StockTodayOrders> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStockTodayOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.stockTradeTodaysOrdersList.isEmpty
          ? NoDataFound(
              label: AppStrings.noDataFoundTodayOrders,
            )
          : ListView.builder(
              itemCount: controller.stockTradeTodaysOrdersList
                  .length, // Specify the number of items you want to display
              itemBuilder: (context, index) {
                return OrdersCard(
                  order: controller.stockTradeTodaysOrdersList[index],
                  // status: "COMPLETED",
                  // type: "BUY",
                  // symbol: "Reliance Power",
                  // quantity: "35",
                  // price: "5.30",
                  // totalamount: "9,540.00",
                  // orderid: "231219669591731",
                  // timestamp: "19 Dec 2023 05:22 PM",
                );
              },
            ),
    );
  }
}
