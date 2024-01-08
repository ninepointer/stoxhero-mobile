import 'package:flutter/material.dart';
import '../../../../../app/app.dart';
import 'package:get/get.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({super.key});

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStocksStopLossPendingOrder();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.stopLossPendingOrderList.isEmpty
          ? NoDataFound(
              label: AppStrings.noDataFoundPendingOrders,
            )
          : ListView.builder(
              itemCount: controller.stopLossPendingOrderList
                  .length, // Specify the number of items you want to display
              itemBuilder: (context, index) {
                return StocksPendingOrderCard(
                    stopLoss: controller.stopLossPendingOrderList[index]);
              }),
    );
  }
}
