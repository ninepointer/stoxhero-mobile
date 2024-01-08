import 'package:flutter/material.dart';
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
    return Padding(
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
                      unselectedLabelColor: Colors.grey,
                      indicator: BoxDecoration(
                        color: Colors.green[200],
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
      ),
    );
  }
}

