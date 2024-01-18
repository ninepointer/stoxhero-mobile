import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stoxhero/src/modules/stocks/controllers/stocks_controller.dart';
import 'package:stoxhero/src/modules/stocks/widget/watchlist_card.dart';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:stoxhero/src/modules/stocks/widget/watchlist_search_botttomsheet.dart';
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
    controller.getEquityInstrumentDetails();
  }

  bool isSlidableOpen = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background container with rounded edges
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Color(0xFF1B2937) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
          ),
        ),

        // Container with search bar and button
        InkWell(
          onTap: () {
            // Open the SearchBottomSheet when the container is tapped
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SearchBottomSheet();
              },
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Color(0xFF1B2937) : Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Get.isDarkMode
                      ? Color(0xFF151F2B).withOpacity(0.8)
                      : Colors.grey.withOpacity(0.2),
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
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                Text(
                  "Search and add... ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        Obx(() {
          print(
              'equityInstrumentDetailList : ${controller.equityInstrumentDetailList.length}');

          return Positioned(
              top: 65, // Adjust the top position as needed
              left: 0,
              right: 0,
              bottom: 0,
              child: GetBuilder<StocksTradingController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.equityInstrumentDetailList.length,
                    itemBuilder: (context, index) {
                      //  var stock = controller.tradingInstruments[index];
                      EquityInstrumentDetail data =
                          controller.equityInstrumentDetailList[index];

                      return WatchlistCard(
                        imagePath: 'assets/images/10Xlogo.jpg',
                        title: data.symbol ?? '-',
                        price: controller
                            .getInstrumentLastPrice(
                              data.instrumentToken ?? 0,
                              data.exchangeInstrumentToken ?? 0,
                            )
                            .toString(),
                        percentage: controller.getInstrumentChanges(
                          data.instrumentToken ?? 0,
                          data.exchangeInstrumentToken ?? 0,
                        ),
                        equityInstrumentDetail:
                            controller.equityInstrumentDetailList[index],
                      );
                    },
                  );
                },
              ));
        }
            // child: ListView(
            //   children: [
            //     Column(
            //       children: [
            //         WatchlistCard(
            //           imagePath: 'assets/images/10Xlogo.jpg',
            //           title: "Reliance Power",
            //           price: "₹61.8",
            //           percentage: "+0.70 (3.01%)",
            //         ),
            //       ],
            //     )
            //   ],
            // ),
            ),
      ],
    );
  }
}
