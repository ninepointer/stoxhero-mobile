import 'package:flutter/material.dart';
import '../../../app/app.dart';

class VirtualTradingView extends GetView<VirtualTradingController> {
  const VirtualTradingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Visibility(
          visible: controller.isLoadingStatus,
          child: TradingShimmer(),
          replacement: RefreshIndicator(
            onRefresh: controller.loadData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (controller.stockIndexDetailsList.isNotEmpty && controller.stockIndexInstrumentList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var item in controller.stockIndexDetailsList) ...[
                            TradingStockCard(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TradingMarginNpnlCard(
                            label: 'Available Margin',
                            value: controller.calculateMargin().round(),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: TradingMarginNpnlCard(
                            label: 'Net P&L',
                            value: controller.calculateTotalNetPNL(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CommonTile(
                    isLoading: controller.isWatchlistStateLoadingStatus,
                    label: 'My Watchlist',
                    showIconButton: true,
                    icon: Icons.add,
                    onPressed: controller.gotoSearchInstrument,
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  controller.tradingWatchlist.isEmpty
                      ? NoDataFound(
                          label: 'Nothing here! \nClick on + icon to add instruments',
                        )
                      : SizedBox(
                          height:
                              controller.tradingWatchlist.length >= 3 ? 260 : controller.tradingWatchlist.length * 130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.tradingWatchlist.length,
                            itemBuilder: (context, index) {
                              return VirtualWatchListCard(
                                index: index,
                                tradingWatchlist: controller.tradingWatchlist[index],
                              );
                            },
                          ),
                        ),
                  if (controller.virtualPositionsList.isNotEmpty) CommonTile(label: 'My Position Summary'),
                  if (controller.virtualPositionsList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              PositionDetailCardTile(
                                isNum: true,
                                label: 'Running Lots',
                                value: controller.tenxTotalPositionDetails.value.lots,
                              ),
                              SizedBox(width: 8),
                              PositionDetailCardTile(
                                label: 'Brokerage',
                                value: controller.tenxTotalPositionDetails.value.brokerage,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              PositionDetailCardTile(
                                label: 'Gross P&L',
                                value: controller.calculateTotalGrossPNL(),
                                valueColor: controller.getValueColor(controller.calculateTotalGrossPNL()),
                              ),
                              SizedBox(width: 8),
                              PositionDetailCardTile(
                                label: 'Net P&L',
                                value: controller.calculateTotalNetPNL(),
                                valueColor: controller.getValueColor(controller.calculateTotalNetPNL()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  CommonTile(
                    isLoading: controller.isPositionStateLoadingStatus,
                    label: 'My Positions',
                    showSeeAllButton: true,
                    seeAllLabel:
                        '( Open P: ${controller.getOpenPositionCount()} | Close P: ${controller.getClosePositionCount()} )',
                    sellAllColor: AppColors.grey,
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  controller.virtualPositionsList.isEmpty
                      ? NoDataFound()
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.virtualPositionsList.length,
                          itemBuilder: (context, index) {
                            return VirtualPositionCard(
                              position: controller.virtualPositionsList[index],
                            );
                          },
                        ),
                  CommonTile(
                    isLoading: controller.isPortfolioStateLoadingStatus,
                    label: 'Portfolio Details',
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  PortfolioDetailCardTile(
                    label: 'Virtual Margin Money',
                    info: 'Total funds added by StoxHero in your Account',
                    value: controller.virtualPortfolio.value.totalFund,
                  ),
                  PortfolioDetailCardTile(
                    label: 'Available Margin Money',
                    info: 'Funds that you can use to trade today',
                    value: controller.calculateMargin(),
                  ),
                  PortfolioDetailCardTile(
                    label: 'Used Margin Money',
                    info: 'Net funds utilized for your executed trades',
                    value: controller.calculateTotalNetPNL() > 0 ? 0 : controller.calculateTotalNetPNL().abs(),
                    valueColor: controller.getValueColor(controller.calculateTotalNetPNL()),
                  ),
                  PortfolioDetailCardTile(
                    label: 'Unrealised Profit & Loss',
                    info: 'Increased value of your investment',
                    value: controller.calculateUnRealisedPNL(),
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
