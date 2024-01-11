import 'package:flutter/material.dart';
import '../../../app/app.dart';

class VirtualTradingView extends GetView<VirtualTradingController> {
  const VirtualTradingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Future & Options')),
      body: Obx(
        () {
          return Visibility(
            visible: controller.isLoadingStatus,
            child: TradingShimmer(),
            replacement: RefreshIndicator(
              onRefresh: controller.loadData,
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
                                label: controller.getStockIndexName(
                                    item.instrumentToken ?? 0),
                                stockPrice: FormatHelper.formatNumbers(
                                  item.lastPrice,
                                ),
                                stockColor: controller.getValueColor(
                                  (item.lastPrice! * item.change!) / 100,
                                ),
                                stockLTP: FormatHelper.formatNumbers(
                                  // item.lastPrice! - (item.ohlc?.close ?? 0),
                                  (item.lastPrice! * item.change!) / 100,
                                ),
                                stockChange:
                                    '(${item.change?.toStringAsFixed(2)}%)',
                                stockLTPColor: controller.getValueColor(
                                  // item.lastPrice! - (item.ohlc?.close ?? 0),
                                  (item.lastPrice! * item.change!) / 100,
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
                    // CommonTile(
                    //   isLoading: controller.isPositionStateLoadingStatus,
                    //   label: '',
                    //   showSeeAllButton: true,
                    //   seeAllLabel: '${getTradingStatus(DateTime.now())}',
                    //   sellAllColor: AppColors.grey,
                    //   margin: EdgeInsets.only(bottom: 0, top: 8),
                    // ),
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
                                return VirtualWatchListCard(
                                  index: index,
                                  tradingWatchlist:
                                      controller.tradingWatchlist[index],
                                );
                              },
                            ),
                          ),
                    if (controller.virtualPositionsList.isNotEmpty)
                      CommonTile(label: 'My Position Summary'),
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
                          ],
                        ),
                      ),


                      
                    CommonTile(
                      isLoading: controller.isPositionStateLoadingStatus,
                      label: 'My Position',
                      showSeeAllButton: true,
                      seeAllLabel:
                          '( Open P: ${controller.getOpenPositionCount()} | Close P: ${controller.getClosePositionCount()} )',
                      sellAllColor: AppColors.grey,
                      margin: EdgeInsets.only(bottom: 0, top: 8),
                    ),
                    controller.virtualPositionsList.isEmpty
                        ? NoDataFound(
                            label: AppStrings.noDataFoundPositions,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.virtualPositionsList.length,
                            itemBuilder: (context, index) {
                              final position =
                                  controller.virtualPositionsList[index];
                              if (position.id?.isLimit != true) {
                                return VirtualPositionCard(
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
                            itemCount:
                                controller.stopLossPendingOrderList.length,
                            itemBuilder: (context, index) {
                              return VirtualStoplossPendingOrderCard(
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
                            height: controller
                                        .stopLossExecutedOrdersList.length >=
                                    3
                                ? 180
                                : controller.stopLossExecutedOrdersList.length *
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
                      isLoading: controller.isOrderStateLoadingStatus,
                      label: 'My Orders',
                      margin: EdgeInsets.only(bottom: 0, top: 8),
                    ),
                    controller.virtualTradeTodaysOrdersList.isEmpty
                        ? NoDataFound(
                            label:
                                AppStrings.noDataFoundCompletedRejectedOrders,
                          )
                        : SizedBox(
                            height: controller
                                        .virtualTradeTodaysOrdersList.length >=
                                    3
                                ? 180
                                : controller
                                        .virtualTradeTodaysOrdersList.length *
                                    130,
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: controller
                                  .virtualTradeTodaysOrdersList.length,
                              itemBuilder: (context, index) {
                                return VirtualTodayOrderCard(
                                  order: controller
                                      .virtualTradeTodaysOrdersList[index],
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
                      value: controller.calculateTotalNetPNL() > 0
                          ? 0
                          : controller.calculateTotalNetPNL().abs(),
                      valueColor: controller.getValueColor(
                        controller.calculateTotalNetPNL(),
                      ),
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
        },
      ),
    );
  }
}
