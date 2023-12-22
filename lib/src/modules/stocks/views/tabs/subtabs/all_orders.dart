import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/stocks/widget/orders_card.dart';
class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrdersCard(
              status: "COMPLETED",
              type:"BUY",
              symbol: "Reliance Power",
              quantity: "35",
              price: "5.30",
              totalamount:"9,540.00",
              orderid:"231219669591731",
              timestamp:"19 Dec 2023 05:22 PM",
             
            ),
            OrdersCard(
              status: "PENDING",
              type:"SELL",
              symbol: "Adani Power",
              quantity: "35",
              price: "5.30",
              totalamount:"9,540.00",
              orderid:"231219669591731",
              timestamp:"19 Dec 2023 05:22 PM",
             
            ),
            
           
            // Add more cards as needed
          ],
        ),
      ),
    );
  }
}