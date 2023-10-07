import 'package:flutter/material.dart';
import '../../../app/app.dart';

class ContestTradingView extends GetView<ContestController> {
  const ContestTradingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Contest Trading'),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(
                        bottom: 0,
                      ),
                      child: Row(
                        children: [
                          for (var item in controller.stockIndexDetailsList) ...[
                            CommonStockInfo(
                              label: controller.getStockIndexName(item.instrumentToken ?? 0),
                              stockPrice: FormatHelper.formatNumbers(
                                item.lastPrice,
                              ),
                              stockColor: controller.getValueColor(
                                item.lastPrice! - (item.ohlc?.close ?? 0),
                              ),
                              stockLTP: FormatHelper.formatNumbers(
                                item.lastPrice! - (item.ohlc?.close ?? 0),
                              ),
                              stockChange: '(${item.change?.toStringAsFixed(2)}%)',
                              stockLTPColor: controller.getValueColor(
                                item.lastPrice! - (item.ohlc?.close ?? 0),
                              ),
                            ),
                            if (item != controller.stockIndexDetailsList.last) SizedBox(width: 4),
                          ]
                        ],
                      ),
                    ),
                  CommonTile(
                    label: 'My Watchlist',
                    showIconButton: true,
                    icon: Icons.add,
                    onPressed: controller.gotoSearchInstrument,
                    padding: EdgeInsets.only(left: 16),
                  ),
                  controller.tradingWatchlist.isEmpty
                      ? NoDataFound()
                      : SizedBox(
                          height:
                              controller.tradingWatchlist.length >= 3 ? 340 : controller.tradingWatchlist.length * 120,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.tradingWatchlist.length,
                            itemBuilder: (context, index) {
                              return ContestWatchlistCard(
                                index: index,
                                tradingWatchlist: controller.tradingWatchlist[index],
                              );
                            },
                          ),
                        ),
                  // CommonTile(label: 'My Rank'),
                  // for (var item in controller.liveLeaderboardList) ...[
                  //   CommonRankCard(
                  //     rank: "",
                  //     name: item.userName.toString(),
                  //     netPnl: item.npnl.toString(),
                  //   ),
                  // ],
                  // CommonRankCard(
                  //   rank: controller.liveLeaderboard.value.npnl.toString(),
                  //   name: controller.userDetails.value.name.toString(),
                  //   netPnl: controller.calculateTotalNetPNL().toString(),
                  // ),
                  if (controller.contestPositionsList.isNotEmpty) CommonTile(label: 'My Position Details'),
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
                                value: controller.calculateTotalGrossPNL(),
                                valueColor: controller.getValueColor(
                                  controller.calculateTotalGrossPNL(),
                                ),
                              ),
                              SizedBox(width: 8),
                              ContestPositionDetailsCard(
                                label: 'Net P&L',
                                value: controller.calculateTotalNetPNL(),
                                valueColor: controller.getValueColor(
                                  controller.calculateTotalNetPNL(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              ContestPositionDetailsCard(
                                label: 'Payout',
                                value: controller.calculatePayout(),
                                valueColor: controller.getValueColor(
                                  controller.calculatePayout(),
                                ),
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
                    info: 'Total funds added by StoxHero in your Account',
                    value: controller.contestPortfolio.value.totalFund,
                  ),
                  ContestPortfolioDetailsCard(
                    label: 'Available Margin',
                    info: 'Funds that you can use to trade today',
                    value: controller.calculateMargin(),
                  ),
                  ContestPortfolioDetailsCard(
                    label: 'Used Margin',
                    info: 'Net funds utilized for your executed trades',
                    value: controller.calculateTotalNetPNL() > 0 ? 0 : controller.calculateTotalNetPNL().abs(),
                    valueColor: controller.getValueColor(controller.calculateTotalNetPNL()),
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
