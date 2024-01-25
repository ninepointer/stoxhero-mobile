import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:stoxhero/src/modules/stocks/widget/orders_card.dart';
import 'package:get/get.dart';

class ExecutedOrders extends StatefulWidget {
  const ExecutedOrders({super.key});

  @override
  State<ExecutedOrders> createState() => _ExecutedOrdersState();
}

class _ExecutedOrdersState extends State<ExecutedOrders> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStocksStopLossExecutedOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.stocksStopLossExecutedOrdersList.isEmpty
          ? NoDataFound(
              label: AppStrings.noDataFoundExecutedOrders,
            )
          : ListView.builder(
              itemCount: controller.stocksStopLossExecutedOrdersList
                  .length, // Specify the number of items you want to display
              itemBuilder: (context, index) {
                return StocksExcuatedOrderCard(
                    stopLoss:
                        controller.stocksStopLossExecutedOrdersList[index]);
              }),
    );
  }
}
