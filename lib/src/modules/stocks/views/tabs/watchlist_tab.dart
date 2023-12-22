import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/stocks/controllers/stocks_controller.dart';
import 'package:stoxhero/src/modules/stocks/widget/watchlist_card.dart';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import '../../../../app/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ToDoListScreen(),
      ),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  late StocksTradingController controller;


   @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
  }


  bool isSlidableOpen = false;
  @override
  Widget build(BuildContext context) {
   print("hello${controller.tradingInstruments.toJson()}");
    return Scaffold(
      body: Stack(
        children: [
          // Background container with rounded edges
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            ),
          ),

          // Container with search bar and button
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.grey,
                  onPressed: () {
                    // Handle the search action here
                    // For simplicity, I'm adding a hardcoded result
                    
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search & add",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Display existing todo items
          Positioned(
            top: 65, // Adjust the top position as needed
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView(
             children: [
              Column(
                children: [
                  WatchlistCard(
                imagePath:'assets/images/10Xlogo.jpg', 
                title: "Reliance Power", 
                price: "₹61.8", 
                  percentage: "+0.70 (3.01%)",
              ),
              
                ],
              )
             ],
             
            ),
          ),
        ],
      ),
    );
  }
}