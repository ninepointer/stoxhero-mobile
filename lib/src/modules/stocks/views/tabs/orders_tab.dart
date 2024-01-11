import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/subtabs/today_orders.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/subtabs/executed_orders.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/subtabs/pending_orders.dart';

class orders extends StatefulWidget {
  const orders({Key? key}) : super(key: key);

  @override
  State<orders> createState() => _ordersState();
}

class _ordersState extends State<orders> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                //height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: TabBar(
                        labelColor: Colors.green[600],
                        isScrollable: true,
                        unselectedLabelColor: Colors.grey,
                        indicator: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        controller: tabController,
                        tabs: [
                          Tab(
                            text:
                                'Today Orders', // Change 'Holdings' to 'holdings'
                          ),
                          Tab(
                            text: 'Executed Orders',
                          ),
                          Tab(
                            text: 'Pending Orders',
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
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    StockTodayOrders(),
                    ExecutedOrders(),
                    PendingOrders(),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
