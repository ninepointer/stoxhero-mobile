import 'package:flutter/material.dart';
import '../../../widget/orders_card.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({super.key});

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            // OrdersCard(
            //   status: "PENDING",
            //   type: "BUY",
            //   symbol: "Adani Power",
            //   quantity: "35",
            //   price: "5.30",
            //   totalamount: "9,540.00",
            //   orderid: "231219669591731",
            //   timestamp: "19 Dec 2023 05:22 PM",
            // ),

            // Add more cards as needed
          ],
        ),
      ],
    );
  }
}
