import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/subtabs/portfolio_holding.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/subtabs/portfolio_position.dart';

class holding extends StatefulWidget {
  const holding({Key? key}) : super(key: key);

  @override
  State<holding> createState() => _PortfolioState();
}

class _PortfolioState extends State<holding>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Color(0xFF1B2937) : Colors.white54,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: TabBar(
                    labelColor:
                        Get.isDarkMode ? Colors.white : Colors.green[600],
                    unselectedLabelColor:
                        Get.isDarkMode ? Colors.grey[300] : Colors.grey,
                    indicator: BoxDecoration(
                      color: Get.isDarkMode ? Colors.blue : Colors.green[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    controller: tabController,
                    tabs: [
                      Tab(
                        text: 'Positions',
                      ),
                      Tab(
                        text: 'Holdings', // Change 'Holdings' to 'holdings'
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          //Conten for the 2 tabs
          Expanded(
            child: Container(
              height: MediaQuery.of(context)
                  .size
                  .height, // Adjust the height as needed
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  PortfolioPosition(),
                  PortfolioHolding(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
