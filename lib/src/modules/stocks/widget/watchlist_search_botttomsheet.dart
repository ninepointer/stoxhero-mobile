import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/stocks/controllers/stocks_controller.dart';
import '../../../app/app.dart';
import 'dart:async';
import 'dart:developer';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({Key? key}) : super(key: key);

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  late StocksTradingController controller;
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    controller = StocksTradingController();
    controller.loadData();

    myFocusNode = FocusNode();

    // Request focus when the bottom sheet is opened
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      myFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  // ... your existing code ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 55),
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
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 60,
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
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: TextFormField(
                        focusNode: myFocusNode,
                        controller: controller.searchTextController,
                        onChanged: (value) {
                          if (value.isEmpty || value == "") {
                            controller.isSearchCleared.value = true;
                          } else {
                            controller.isSearchCleared(false);
                          }
                          controller.getStocksTradingInstruments(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Search & add...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.isSearchCleared(false);
                                  controller.tradingInstruments([]);
                                  controller.searchTextController.clear();
                                  // Request focus after clearing text
                                  Future.delayed(Duration.zero, () {
                                    myFocusNode.requestFocus();
                                  });
                                },
                                icon: Text(
                                  'Clear',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(
              () => ListView.builder(
                itemCount: controller.tradingInstruments.length,
                itemBuilder: (context, index) {
                  var stock = controller.tradingInstruments[index];

                  return Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                stock.tradingsymbol.toString(),
                                style: AppStyles.tsBlackRegular16,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "LTP: ₹150.75",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      Text(
                                        " (+2.5%)",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      controller.selectedWatchlistStock(stock);
                                      controller.addStocktoWatchlist();
                                      print(
                                          "Add button tapped for: ${stock.tradingsymbol}");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[200],
                            thickness: 1,
                            indent: 15,
                            endIndent: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
