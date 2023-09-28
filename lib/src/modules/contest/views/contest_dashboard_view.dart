import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class ContestDashboardView extends GetView<ContestController> {
  const ContestDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contest Trading'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: RefreshIndicator(
            onRefresh: controller.loadTradingData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (controller.stockIndexDetailsList.isNotEmpty)
                    Row(
                      children: [
                        for (var item in controller.stockIndexDetailsList)
                          CommonStockInfo(
                            label: controller.getStockIndexName(item.instrumentToken ?? 0),
                            stockPrice: FormatHelper.formatNumbers(
                              item.lastPrice,
                            ),
                            stockColor: controller.getValueColor(item.lastPrice),
                            stockLTP: FormatHelper.formatNumbers(
                              item.lastPrice! - (item.ohlc?.close ?? 0),
                            ),
                            stockChange: '(${item.change?.toStringAsFixed(2)}%)',
                            stockLTPColor: controller.getValueColor(
                              item.lastPrice! - (item.ohlc?.close ?? 0),
                            ),
                          ),
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
                    ],
                  ),
                  CommonTile(
                    label: 'My Watchlist',
                    showIconButton: true,
                    icon: Icons.add,
                    onPressed: controller.gotoSearchInstrument,
                    padding: EdgeInsets.only(left: 16),
                  ),
                  controller.contestWatchList.isEmpty
                      ? NoDataFound()
                      : SizedBox(
                          height: controller.contestWatchList.length >= 5
                              ? 300
                              : controller.contestWatchList.length * 76,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.contestWatchList.length,
                            itemBuilder: (context, index) {
                              return ContestWatchlistCard(
                                index: index,
                                contestWatchlist: controller.contestWatchList[index],
                              );
                            },
                          ),
                        ),
                  // CommonTile(label: 'My Rank'),
                  // CommonRankCard(
                  //   rank: '#1000',
                  //   name: 'Ritik Prajapat',
                  //   netPnl: '+ ₹12,02.69',
                  // ),
                  // CommonTile(label: 'Top Rank'),
                  // CommonRankCard(
                  //   rank: '#1000',
                  //   name: 'Ritik Prajapat',
                  //   netPnl: '+ ₹12,02.69',
                  // ),
                  // SizedBox(height: 4),
                  // CommonRankCard(
                  //   rank: '#1000',
                  //   name: 'Ritik Prajapat',
                  //   netPnl: '+ ₹12,02.69',
                  // ),
                  // SizedBox(height: 4),
                  // CommonRankCard(
                  //   rank: '#1000',
                  //   name: 'Ritik Prajapat',
                  //   netPnl: '+ ₹12,02.69',
                  // ),
                  if (controller.contestPositionsList.isNotEmpty)
                    CommonTile(label: 'My Position Details'),
                  if (controller.contestPositionsList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ContestPositionDetailsCard(
                                isNum: true,
                                label: 'Running Lots',
                                value: controller.tenxTotalPositionDetails.value.lots,
                              ),
                              SizedBox(width: 8),
                              ContestPositionDetailsCard(
                                label: 'Brokerage',
                                value: controller.tenxTotalPositionDetails.value.brokerage,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              ContestPositionDetailsCard(
                                label: 'Gross P&L',
                                value: controller.tenxTotalPositionDetails.value.gross,
                              ),
                              SizedBox(width: 8),
                              ContestPositionDetailsCard(
                                label: 'Net P&L',
                                value: controller.contestPositionsList[0].lastaverageprice,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  CommonTile(label: 'My Position'),
                  controller.contestPositionsList.isEmpty
                      ? NoDataFound()
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.contestPositionsList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            return ContestPositionCard(
                              position: controller.contestPositionsList[index],
                            );
                          },
                        ),
                  CommonTile(label: 'Portfolio Details'),
                  ContestPortfolioDetailsCard(
                    label: 'Portfolio Value',
                    value: controller.contestPortfolio.value.totalFund,
                  ),
                  ContestPortfolioDetailsCard(
                    label: 'Available Margin',
                    // value: controller.virtualPortfolio.value.openingBalance,
                  ),
                  ContestPortfolioDetailsCard(
                    label: 'Used Margin',
                    // value: controller.tenxTotalPositionDetails.value.brokerage,
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
