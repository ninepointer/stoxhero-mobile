import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class TenxDashboardView extends GetView<TenxTradingController> {
  const TenxDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trading'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: controller.gotoSearchInstrument,
          ),
        ],
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: RefreshIndicator(
            onRefresh: controller.loadData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CommonStockInfo(
                        label: 'Nifty 50',
                        stockPrice: '₹ 12,500.90',
                        stockLTP: '₹ 183.15',
                        stockChange: '(+ 34.42%)',
                      ),
                      CommonStockInfo(
                        label: 'Bank Nifty',
                        stockPrice: '₹ 12,500.90',
                        stockLTP: '₹ 183.15',
                        stockChange: '(+ 34.42%)',
                      ),
                      CommonStockInfo(
                        label: 'Finnifty',
                        stockPrice: '₹ 12,500.90',
                        stockLTP: '₹ 183.15',
                        stockChange: '(+ 34.42%)',
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  Row(
                    children: [
                      CommonStockInfo(
                        label: 'Margin',
                        stockPrice: '₹ 19,454.09',
                        stockLTP: '₹ 183.15',
                        stockChange: '(+ 34.42%)',
                      ),
                      CommonStockInfo(
                        label: 'Net P&L',
                        stockPrice: '₹ 19,454.98',
                        stockLTP: '₹ 183.15',
                        stockChange: '(+ 34.42%)',
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  CommonTile(label: 'My Watchlist'),
                  controller.tenxWatchlist.isEmpty
                      ? NoDataFound()
                      : SizedBox(
                          height: controller.tenxWatchlist.length >= 5 ? 300 : controller.tenxWatchlist.length * 76,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.tenxWatchlist.length,
                            itemBuilder: (context, index) {
                              return TenxWatchlistCard(
                                index: index,
                                data: controller.tenxWatchlist[index],
                              );
                            },
                          ),
                        ),
                  CommonTile(label: 'My Rank'),
                  CommonRankCard(
                    rank: '#1000',
                    name: 'Ritik Prajapat',
                    netPnl: '+ ₹12,02.69',
                  ),
                  CommonTile(label: 'Top Rank'),
                  CommonRankCard(
                    rank: '#1000',
                    name: 'Ritik Prajapat',
                    netPnl: '+ ₹12,02.69',
                  ),
                  SizedBox(height: 8),
                  CommonRankCard(
                    rank: '#1000',
                    name: 'Ritik Prajapat',
                    netPnl: '+ ₹12,02.69',
                  ),
                  SizedBox(height: 8),
                  CommonRankCard(
                    rank: '#1000',
                    name: 'Ritik Prajapat',
                    netPnl: '+ ₹12,02.69',
                  ),
                  if (controller.tenxPositionsList.isNotEmpty) CommonTile(label: 'My Position Details'),
                  if (controller.tenxPositionsList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TenxPositionDetailsCard(
                                isNum: true,
                                label: 'Running Lots',
                                value: controller.tenxTotalPositionDetails.value.lots,
                              ),
                              SizedBox(width: 8),
                              TenxPositionDetailsCard(
                                label: 'Brokerage',
                                value: controller.tenxTotalPositionDetails.value.brokerage,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              TenxPositionDetailsCard(
                                label: 'Gross P&L',
                                value: '0',
                              ),
                              SizedBox(width: 8),
                              TenxPositionDetailsCard(
                                label: 'Net P&L',
                                value: '0',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  CommonTile(label: 'My Position'),
                  controller.tenxPositionsList.isEmpty
                      ? NoDataFound()
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.tenxPositionsList.length,
                          itemBuilder: (context, index) {
                            var item = controller.tenxPositionsList[index];
                            return TenxPositionCard(data: item);
                          },
                        ),
                  CommonTile(label: 'Portfolio Details'),
                  TenxPortfolioDetailsCard(
                    label: 'Portfolio Value',
                    info: 'Total funds added by StoxHero in your Account',
                    value: controller.tenxPortfolioDetails.value.totalFund,
                  ),
                  TenxPortfolioDetailsCard(
                    label: 'Available Margin',
                    info: 'Funds that you can used to trade today',
                    value: '0',
                  ),
                  TenxPortfolioDetailsCard(
                    label: 'Used Margin',
                    info: 'Net funds utilized for your executed trades',
                    value: controller.tenxTotalPositionDetails.value.brokerage,
                  ),
                  TenxPortfolioDetailsCard(
                    label: 'Opening Balance',
                    info: 'Cash available at the beginning of the day',
                    value: controller.tenxPortfolioDetails.value.openingBalance,
                  ),
                  SizedBox(height: 56),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
