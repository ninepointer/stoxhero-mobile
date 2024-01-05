import 'package:flutter/material.dart';
import '../../../app/app.dart';

class MarginXTradingView extends GetView<MarginXController> {
  const MarginXTradingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${controller.liveMarginX.value.marginXName ?? 'MarginX Trading'}',
          style: Theme.of(context).textTheme.tsRegular16,
          textAlign: TextAlign.center,
        ),
      ),
      body: Obx(() {
        return Visibility(
          visible: !controller.isLoadingStatus,
          replacement: TradingShimmer(),
          child: RefreshIndicator(
            onRefresh: controller.loadTradingData,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                            TradingStockCard(
                              label: controller
                                  .getStockIndexName(item.instrumentToken ?? 0),
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
                            if (item != controller.stockIndexDetailsList.last)
                              SizedBox(width: 4),
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
                          label: AppStrings.noDataFoundWatchlist,
                        )
                      : SizedBox(
                          height: controller.tradingWatchlist.length >= 3
                              ? 260
                              : controller.tradingWatchlist.length * 130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.tradingWatchlist.length,
                            itemBuilder: (context, index) {
                              return MarginXWatchlistCard(
                                index: index,
                                tradingWatchlist:
                                    controller.tradingWatchlist[index],
                              );
                            },
                          ),
                        ),
                  if (controller.marginXPositionList.isNotEmpty)
                    CommonTile(label: 'My Position Summary'),
                  if (controller.marginXPositionList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              PositionDetailCardTile(
                                isNum: true,
                                label: 'Running Lots',
                                value: controller
                                    .tenxTotalPositionDetails.value.lots,
                              ),
                              SizedBox(width: 8),
                              PositionDetailCardTile(
                                label: 'Brokerage',
                                value: controller
                                    .tenxTotalPositionDetails.value.brokerage,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              PositionDetailCardTile(
                                label: 'Gross P&L',
                                value: controller.calculateTotalGrossPNL(),
                                valueColor: controller.getValueColor(
                                    controller.calculateTotalGrossPNL()),
                              ),
                              SizedBox(width: 8),
                              PositionDetailCardTile(
                                label: 'Net P&L',
                                value: controller.calculateTotalNetPNL(),
                                valueColor: controller.getValueColor(
                                    controller.calculateTotalNetPNL()),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              PositionDetailCardTile(
                                label: 'Invested Amount',
                                value: controller.liveMarginX.value
                                    .marginXTemplate?.entryFee,
                                valueColor: AppColors.info,
                              ),
                              SizedBox(width: 8),
                              PositionDetailCardTile(
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
                              PositionDetailCardTile(
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
                  CommonTile(
                    isLoading: controller.isPositionStateLoadingStatus,
                    label: 'My Positions',
                    showSeeAllButton: true,
                    seeAllLabel:
                        '( Open P: ${controller.getOpenPositionCount()} | Close P: ${controller.getClosePositionCount()} )',
                    sellAllColor: AppColors.grey,
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  controller.marginXPositionList.isEmpty
                      ? NoDataFound(
                          label: AppStrings.noDataFoundPositions,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.marginXPositionList.length,
                          itemBuilder: (context, index) {
                            final position =
                                controller.marginXPositionList[index];
                            if (position.id?.isLimit != true) {
                              return MarginXPositionCard(
                                position: position,
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                  CommonTile(
                    isLoading: controller.isPendingOrderStateLoadingStatus,
                    label: 'My Pending Orders',
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  controller.stopLossPendingOrderList.isEmpty
                      ? NoDataFound(
                          label: AppStrings.noDataFoundPendingOrders,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.stopLossPendingOrderList.length,
                          itemBuilder: (context, index) {
                            return MarginXStoplossPendingOrderCard(
                              stopLoss:
                                  controller.stopLossPendingOrderList[index],
                            );
                          },
                        ),
                  CommonTile(
                    isLoading: controller.isExecutedOrderStateLoadingStatus,
                    label: 'My Executed Orders',
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  controller.stopLossExecutedOrdersList.isEmpty
                      ? NoDataFound(
                          label: AppStrings.noDataFoundExecutedOrders,
                        )
                      : SizedBox(
                          height:
                              controller.stopLossExecutedOrdersList.length >= 3
                                  ? 180
                                  : controller
                                          .stopLossExecutedOrdersList.length *
                                      130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount:
                                controller.stopLossExecutedOrdersList.length,
                            itemBuilder: (context, index) {
                              return StoplossExecutedOrderCard(
                                stopLoss: controller
                                    .stopLossExecutedOrdersList[index],
                              );
                            },
                          ),
                        ),
                  CommonTile(
                    isLoading: controller.isPortfolioStateLoadingStatus,
                    label: 'My Orders',
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  controller.completedMarginXOrdersList.isEmpty
                      ? NoDataFound(
                          label: AppStrings.noDataFoundCompletedRejectedOrders,
                        )
                      : SizedBox(
                          height:
                              controller.completedMarginXOrdersList.length >= 3
                                  ? 180
                                  : controller
                                          .completedMarginXOrdersList.length *
                                      130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount:
                                controller.completedMarginXOrdersList.length,
                            itemBuilder: (context, index) {
                              return MarginXTodayOrderCard(
                                order: controller
                                    .completedMarginXOrdersList[index],
                              );
                            },
                          ),
                        ),
                  CommonTile(
                    isLoading: controller.isPortfolioStateLoadingStatus,
                    label: 'Virtual Margin Details',
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  PortfolioDetailCardTile(
                    label: 'Virtual Margin Money',
                    info: 'Total funds added by StoxHero in your Account',
                    value: controller.marginXPortfolio.value.totalFund,
                  ),
                  PortfolioDetailCardTile(
                    label: 'Available Margin Money',
                    info: 'Funds that you can use to trade today',
                    value: controller.calculateMargin(),
                  ),
                  PortfolioDetailCardTile(
                    label: 'Used Margin Money',
                    info: 'Net funds utilized for your executed trades',
                    value: controller.calculateTotalNetPNL() > 0
                        ? 0
                        : controller.calculateTotalNetPNL().abs(),
                    valueColor: controller
                        .getValueColor(controller.calculateTotalNetPNL()),
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
        );
      }),
    );
  }
}
