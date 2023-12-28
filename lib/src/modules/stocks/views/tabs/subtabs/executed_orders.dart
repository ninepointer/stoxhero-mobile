import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/stocks/widget/orders_card.dart';

class ExecutedOrders extends StatefulWidget {
  const ExecutedOrders({super.key});

  @override
  State<ExecutedOrders> createState() => _ExecutedOrdersState();
}

class _ExecutedOrdersState extends State<ExecutedOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              OrdersCard(
                status: "COMPLETED",
                type: "BUY",
                symbol: "Reliance Power",
                quantity: "35",
                price: "5.30",
                totalamount: "9,540.00",
                orderid: "231219669591731",
                timestamp: "19 Dec 2023 05:22 PM",
              ),

              // Add more cards as needed
            ],
          ),
        ],
      ),
    );
  }
}
