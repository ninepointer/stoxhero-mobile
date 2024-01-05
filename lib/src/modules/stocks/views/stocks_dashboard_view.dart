import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:stoxhero/src/modules/stocks/controllers/stocks_controller.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/beststocks_tab.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/funds_tab.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/portfolio_tab.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/orders_tab.dart';
import 'package:stoxhero/src/modules/stocks/views/tabs/watchlist_tab.dart';
import 'package:stoxhero/src/modules/stocks/widget/profit_summary_expansion_tile.dart';
import 'package:stoxhero/src/modules/stocks/widget/top_index_card.dart';

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
    final StocksTradingController controller =
        Get.find<StocksTradingController>();

    controller.getReadSetting();

    //  print("hii${controller.stockIndexInstrumentList}");
    //  print("yo${controller.stockIndexDetailsList.map((element) => element.lastPrice)}");

    print('endtime ${controller.readSetting.value.appEndTime}');
    return Scaffold(
      appBar: AppBar(title: Text('Stocks Trading')),
      body: Obx(
        () => Visibility(
          visible: controller.isLoadingStatus,
          child: TradingShimmer(),
          replacement: RefreshIndicator(
            onRefresh: controller.loadData,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      if (controller.stockIndexDetailsList.isNotEmpty &&
                          controller.stockIndexInstrumentList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var item
                                  in controller.stockIndexDetailsList) ...[
                                IndexCard(
                                  label: controller.getStockIndexName(
                                      item.instrumentToken ?? 0),
                                  stockPrice: FormatHelper.formatNumbers(
                                    item.lastPrice,
                                  ),
                                  stockColor: controller.getValueColor(
                                    item.lastPrice! - (item.ohlc?.close ?? 0),
                                  ),
                                  stockLTP: FormatHelper.formatNumbers(
                                    item.lastPrice! - (item.ohlc?.close ?? 0),
                                  ),
                                  stockChange:
                                      '(${item.change?.toStringAsFixed(2)}%)',
                                  stockLTPColor: controller.getValueColor(
                                    item.lastPrice! - (item.ohlc?.close ?? 0),
                                  ),
                                ),
                                if (item !=
                                    controller.stockIndexDetailsList.last)
                                  SizedBox(width: 4),
                              ]
                            ],
                          ),
                        ),
                    ]),
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
                                text:
                                    'Watchlist', // Change 'Holdings' to 'Watchlist'
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
          ),
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
