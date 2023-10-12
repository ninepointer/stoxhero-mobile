import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CollegeContestTradingView extends GetView<CollegeContestController> {
  const CollegeContestTradingView({Key? key}) : super(key: key);

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
                              return CollegeContestWatchlistCard(
                                index: index,
                                tradingWatchlist: controller.tradingWatchlist[index],
                              );
                            },
                          ),
                        ),
                  CommonTile(
                    label: 'My Rank',
                    showSeeAllButton: true,
                    seeAllLabel: 'Leaderboard',
                    onPressed: () => Get.toNamed(AppRoutes.collegeContestLiveLeaderboard),
                  ),
                  CommonRankCard(
                    rank: controller.myRank.toString(),
                    name: '${controller.userDetails.value.firstName} ${controller.userDetails.value.lastName} ',
                    netPnL: controller.calculateTotalNetPNL().toString(),
                    reward: controller.calculatePayout().toString(),
                  ),
                  if (controller.contestPositionsList.isNotEmpty) CommonTile(label: 'My Position Summary'),
                  if (controller.contestPositionsList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CollegeContestPositionDetailsCard(
                                isNum: true,
                                label: 'Running Lots',
                                value: controller.tenxTotalPositionDetails.value.lots,
                              ),
                              SizedBox(width: 8),
                              CollegeContestPositionDetailsCard(
                                label: 'Brokerage',
                                value: controller.tenxTotalPositionDetails.value.brokerage,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              CollegeContestPositionDetailsCard(
                                label: 'Gross P&L',
                                value: controller.calculateTotalGrossPNL(),
                                valueColor: controller.getValueColor(
                                  controller.calculateTotalGrossPNL(),
                                ),
                              ),
                              SizedBox(width: 8),
                              CollegeContestPositionDetailsCard(
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
                              CollegeContestPositionDetailsCard(
                                label: 'Payout',
                                value: controller.calculatePayout().round(),
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
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.contestPositionsList.length,
                          itemBuilder: (context, index) {
                            return CollegeContestPositionCard(
                              position: controller.contestPositionsList[index],
                            );
                          },
                        ),
                  CommonTile(label: 'Portfolio Details'),
                  CollegeContestPortfolioDetailsCard(
                    label: 'Portfolio Value',
                    info: 'Total funds added by StoxHero in your Account',
                    value: controller.contestPortfolio.value.totalFund,
                  ),
                  CollegeContestPortfolioDetailsCard(
                    label: 'Available Margin',
                    info: 'Funds that you can use to trade today',
                    value: controller.calculateMargin(),
                  ),
                  CollegeContestPortfolioDetailsCard(
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
