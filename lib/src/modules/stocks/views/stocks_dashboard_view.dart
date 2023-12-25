import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/beststocks_tab.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/funds_tab.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/portfolio_tab.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/orders_tab.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/watchlist_tab.dart';
import 'package:stoxhero/src/modules/stocks/widget/profit_summary_expansion_tile.dart';

class StocksDashboardView extends StatefulWidget {
  const StocksDashboardView({Key? key}) : super(key: key);

  @override
  State<StocksDashboardView> createState() => _StocksDashboardViewState();
}

class _StocksDashboardViewState extends State<StocksDashboardView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: () {
            // Handle back button press here
          },
        ),
        title: Text("Stocks Trading"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 140,
                    height: 60,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("NIFTY")),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 140,
                    height: 60,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("BANKNIFTY")),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 140,
                    height: 60,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("FINNIFTY")),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 140,
                    height: 60,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("SENSEX")),
                  ),
                ],
              ),
            ),
            Container(
              child: CustomExpansionTile(
                invested: '929360',
                profitloss: '-2720.00',
                percentage: '(0.29%)',
                currentvalue: '926640',
                availablemargin: '50000',
                marginmoney: '678888',
                marginused: '678',
                openpositions: '4',
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: TabBar(
                      isScrollable: true,
                      labelColor: Colors.green[600],
                      unselectedLabelColor: Colors.grey,
                      indicator: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: 'Watchlist', // Change 'Holdings' to 'Watchlist'
                        ),
                        Tab(
                          text: 'Portfolio',
                        ),
                        Tab(
                          text: 'BestStocks',
                        ),
                        Tab(
                          text: '  Orders  ',
                        ),
                        Tab(
                          text: '  Funds  ',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      child: ToDoListScreen(),
                    ),
                    Container(
                      child: holding(),
                    ),
                    Container(
                      child: BestStocks(),
                    ),
                    Container(
                      child: orders(),
                    ),
                    Container(
                      child: Funds(
                          marginavailable: '1',
                          usedmargin: '2',
                          allocatedmargin: '3',
                          investmentamount: '4',
                          returns: '5',
                          unrealisedPL: '6',
                          returnpercentage: '7'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: StocksDashboardView(),
    ),
  );
}
