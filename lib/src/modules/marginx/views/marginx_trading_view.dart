import 'package:flutter/material.dart';
import '../../../app/app.dart';

class MarginXTradingView extends GetView<MarginXController> {
  const MarginXTradingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' MarginX Trading'),
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
                          height: controller.tradingWatchlist.length >= 3
                              ? 340
                              : controller.tradingWatchlist.length * 120,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.tradingWatchlist.length,
                            itemBuilder: (context, index) {
                              return MarginXWatchListCard(
                                index: index,
                                tradingWatchlist: controller.tradingWatchlist[index],
                              );
                            },
                          ),
                        ),
                  if (controller.marginXTradingPosition.isNotEmpty)
                    CommonTile(label: 'My Position Details'),
                  if (controller.marginXTradingPosition.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              MarginXPositionDetailsCard(
                                isNum: true,
                                label: 'Running Lots',
                                value: controller.tenxTotalPositionDetails.value.lots,
                              ),
                              SizedBox(width: 8),
                              MarginXPositionDetailsCard(
                                label: 'Brokerage',
                                value: controller.tenxTotalPositionDetails.value.brokerage,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              MarginXPositionDetailsCard(
                                label: 'Gross P&L',
                                value: controller.calculateTotalGrossPNL(),
                                valueColor:
                                    controller.getValueColor(controller.calculateTotalGrossPNL()),
                              ),
                              SizedBox(width: 8),
                              MarginXPositionDetailsCard(
                                label: 'Net P&L',
                                value: controller.calculateTotalNetPNL(),
                                valueColor:
                                    controller.getValueColor(controller.calculateTotalNetPNL()),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              MarginXPositionDetailsCard(
                                label: 'Invested Amount',
                                value: controller.liveMarginX.value.marginXTemplate?.entryFee,
                                valueColor: AppColors.info,
                              ),
                              SizedBox(width: 8),
                              MarginXPositionDetailsCard(
                                label: 'Return',
                                value: controller.calculateReturn(),
                                valueColor: controller.getValueColor(
                                  controller.calculateReturn(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              MarginXPositionDetailsCard(
                                label: 'Account Balance',
                                value: controller.calculateAccountBalance(),
                                valueColor: controller.getValueColor(
                                  controller.calculateAccountBalance(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  CommonTile(label: 'My Position'),
                  controller.marginXTradingPosition.isEmpty
                      ? NoDataFound()
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.marginXTradingPosition.length,
                          itemBuilder: (context, index) {
                            var item = controller.marginXTradingPosition[index];
                            return MarginXPositionCard(position: item);
                          },
                        ),
                  CommonTile(label: 'Portfolio Details'),
                  MarginXPortfolioDetailsCard(
                    label: 'Portfolio Value',
                    info: 'Total funds added by StoxHero in your Account',
                    value: controller.marginXPortfolio.value.totalFund,
                  ),
                  MarginXPortfolioDetailsCard(
                    label: 'Available Margin',
                    info: 'Funds that you can use to trade today',
                    value: controller.calculateMargin(),
                  ),
                  MarginXPortfolioDetailsCard(
                    label: 'Used Margin',
                    info: 'Net funds utilized for your executed trades',
                    value: controller.calculateTotalNetPNL() > 0
                        ? 0
                        : controller.calculateTotalNetPNL().abs(),
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
