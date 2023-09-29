import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenxDashboardView extends GetView<TenxTradingController> {
  const TenxDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num netPnl = controller.calculateTotalNetPNL();
    num displayedValue = netPnl >= 0 ? 0 : netPnl.abs();

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Tenx Trading'),
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
                              stockColor: controller.getValueColor(item.lastPrice),
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
                  // Row(
                  //   children: [
                  //     CommonStockInfo(
                  //       label: 'Margin',
                  //       stockPrice: '₹ 19,454.09',
                  //       stockLTP: '₹ 183.15',
                  //       stockChange: '(+ 34.42%)',
                  //     ),
                  //     CommonStockInfo(
                  //       label: 'Net P&L',
                  //       stockPrice: '₹ 19,454.98',
                  //       stockLTP: '₹ 183.15',
                  //       stockChange: '(+ 34.42%)',
                  //     ),
                  //     SizedBox(width: 8),
                  //   ],
                  // ),
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
                              return TenxWatchlistCard(
                                index: index,
                                tradingWatchlist: controller.tradingWatchlist[index],
                              );
                            },
                          ),
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
                                value: controller.calculateTotalGrossPNL(),
                                valueColor: controller.getValueColor(controller.calculateTotalGrossPNL()),
                              ),
                              SizedBox(width: 8),
                              TenxPositionDetailsCard(
                                label: 'Net P&L',
                                value: controller.calculateTotalNetPNL(),
                                valueColor: controller.getValueColor(controller.calculateTotalNetPNL()),
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
                            return TenxPositionCard(tenxTradingPosition: item);
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
                    info: 'Funds that you can use to trade today',
                    value: controller.calOpening(),
                  ),
                  TenxPortfolioDetailsCard(
                    label: 'Used Margin',
                    info: 'Net funds utilized for your executed trades',
                    value: displayedValue,
                  ),
                  TenxPortfolioDetailsCard(
                    label: 'Opening Balance',
                    info: 'Cash available at the beginning of the day',
                    value: controller.tenxPortfolioDetails.value.totalFund,
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
