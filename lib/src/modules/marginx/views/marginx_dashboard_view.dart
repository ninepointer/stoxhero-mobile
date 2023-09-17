import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class MarginxDashboardView extends GetView<MarginXController> {
  const MarginxDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MarginX Trading'),
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
                    // onPressed: controller.gotoSearchInstrument,
                    padding: EdgeInsets.only(left: 16),
                  ),
                  // controller.contestWatchList.isEmpty
                  //     ? NoDataFound()
                  //     : SizedBox(
                  //         height: controller.contestWatchList.length >= 5
                  //             ? 300
                  //             : controller.contestWatchList.length * 76,
                  //         child: ListView.builder(
                  //           shrinkWrap: true,
                  //           padding: EdgeInsets.zero,
                  //           itemCount: controller.contestWatchList.length,
                  //           itemBuilder: (context, index) {
                  //             return ContestWatchlistCard(
                  //               index: index,
                  //               contestWatchList: controller.contestWatchList[index],
                  //             );
                  //           },
                  //         ),
                  //       ),
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
                  SizedBox(height: 4),
                  CommonRankCard(
                    rank: '#1000',
                    name: 'Ritik Prajapat',
                    netPnl: '+ ₹12,02.69',
                  ),
                  SizedBox(height: 4),
                  CommonRankCard(
                    rank: '#1000',
                    name: 'Ritik Prajapat',
                    netPnl: '+ ₹12,02.69',
                  ),
                  // if (controller.contestPositionsList.isNotEmpty)
                  //   CommonTile(label: 'My Position Details'),
                  // if (controller.contestPositionsList.isNotEmpty)
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           children: [
                  //             ContestPositionDetailsCard(
                  //               isNum: true,
                  //               label: 'Running Lots',
                  //               value: controller.contestPositionsList[0].lots,
                  //             ),
                  //             SizedBox(width: 8),
                  //             ContestPositionDetailsCard(
                  //               label: 'Brokerage',
                  //               value: controller.contestPositionsList[0].brokerage,
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(height: 8),
                  //         Row(
                  //           children: [
                  //             ContestPositionDetailsCard(
                  //               label: 'Gross P&L',
                  //               value: controller.contestPositionsList[0].amount,
                  //             ),
                  //             SizedBox(width: 8),
                  //             ContestPositionDetailsCard(
                  //               label: 'Net P&L',
                  //               value: controller.contestPositionsList[0].lastaverageprice,
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  CommonTile(label: 'My Position'),
                  // controller.contestPositionsList.isEmpty
                  //     ? NoDataFound()
                  //     : ListView.separated(
                  //         shrinkWrap: true,
                  //         padding: EdgeInsets.zero,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemCount: controller.contestPositionsList.length,
                  //         separatorBuilder: (_, __) => SizedBox(height: 8),
                  //         itemBuilder: (context, index) {
                  //           return ContestPositionCard(
                  //             position: controller.contestPositionsList[index],
                  //           );
                  //         },
                  //       ),
                  CommonTile(label: 'Portfolio Details'),
                  MarginXPortfolioDetailsCard(
                    label: 'Portfolio Value',
                    // value: controller.contestPortfolio.value.totalFund,
                  ),
                  MarginXPortfolioDetailsCard(
                    label: 'Available Margin',
                    // value: controller.virtualPortfolio.value.openingBalance,
                  ),
                  MarginXPortfolioDetailsCard(
                    label: 'Used Margin',
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
