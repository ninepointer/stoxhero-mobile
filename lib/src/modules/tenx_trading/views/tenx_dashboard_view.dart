import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenxDashboardView extends GetView<TenxTradingController> {
  const TenxDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${controller.tenxMyActiveSubcribed.value.planName ?? 'TenX Trading'}',
          style: Theme.of(context).textTheme.tsRegular16,
          textAlign: TextAlign.center,
        ),
      ),
      body: Obx(
        () => Visibility(
          visible: controller.isLoadingStatus,
          child: TradingShimmer(),
          replacement: RefreshIndicator(
            onRefresh: controller.loadTenxData,
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
                  CommonCard(
                    margin: EdgeInsets.only(left: 8, right: 8, top: 4),
                    children: [
                      if (controller.tenxCountTradingDays.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '# of Trading Days : ${controller.tenxCountTradingDays[0].totalTradingDays}',
                                    style: AppStyles.tsSecondaryMedium12,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Subscribed On : ${FormatHelper.formatDateTimeToIST(controller.tenxMyActiveSubcribed.value.subscribedOn)}',
                                    style: AppStyles.tsSecondaryMedium12,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '# of Trading Days Left : ${controller.tenxCountTradingDays[0].actualRemainingDay}',
                                    style: AppStyles.tsWhiteMedium12.copyWith(
                                      color: AppColors.success,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Expires On: ${FormatHelper.formatDateTimeToIST(controller.date().toString())}',
                                    textAlign: TextAlign.end,
                                    style: AppStyles.tsWhiteMedium12.copyWith(
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
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
                              return TenxWatchlistCard(
                                index: index,
                                tradingWatchlist: controller.tradingWatchlist[index],
                              );
                            },
                          ),
                        ),
                  if (controller.tenxPositionsList.isNotEmpty) CommonTile(label: 'My Position Summary'),
                  if (controller.tenxPositionsList.isNotEmpty)
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
                  controller.tenxPositionsList.isEmpty
                      ? NoDataFound()
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.tenxPositionsList.length,
                          itemBuilder: (context, index) {
                            return TenxPositionCard(
                              position: controller.tenxPositionsList[index],
                            );
                          },
                        ),
                  CommonTile(
                    isLoading: controller.isPendingOrderStateLoadingStatus,
                    label: 'My Pending Orders',
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  controller.stopLossPendingOrderList.isEmpty
                      ? NoDataFound(
                          label: 'Nothing here!\n Please Take Trade',
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.stopLossPendingOrderList.length,
                          itemBuilder: (context, index) {
                            return StoplossPendingOrderCard(
                              stopLoss: controller.stopLossPendingOrderList[index],
                            );
                          },
                        ),
                  CommonTile(
                    isLoading: controller.isPortfolioStateLoadingStatus,
                    label: 'My Executed Orders',
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  controller.stopLossExecutedOrdersList.isEmpty
                      ? NoDataFound(
                          label: 'Nothing here!\n Please Take Trade',
                        )
                      : SizedBox(
                          height: controller.stopLossExecutedOrdersList.length >= 3
                              ? 180
                              : controller.stopLossExecutedOrdersList.length * 130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.stopLossExecutedOrdersList.length,
                            itemBuilder: (context, index) {
                              return StoplossExecutedOrderCard(
                                stopLoss: controller.stopLossExecutedOrdersList[index],
                              );
                            },
                          ),
                        ),
                  CommonTile(
                    isLoading: controller.isPortfolioStateLoadingStatus,
                    label: 'My Orders',
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  controller.tenxTradeTodaysOrdersList.isEmpty
                      ? NoDataFound(
                          label: 'Nothing here!\n Please Take Trade',
                        )
                      : SizedBox(
                          height: controller.tenxTradeTodaysOrdersList.length >= 3
                              ? 180
                              : controller.tenxTradeTodaysOrdersList.length * 130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.tenxTradeTodaysOrdersList.length,
                            itemBuilder: (context, index) {
                              // return StoplossExecutedOrderCard(
                              //     // stopLoss: controller.tenxTradeTodaysOrdersList[index],
                              //     );
                            },
                          ),
                        ),
                  CommonTile(
                    isLoading: controller.isPortfolioStateLoadingStatus,
                    label: 'Portfolio Details',
                    margin: EdgeInsets.only(bottom: 0, top: 8),
                  ),
                  PortfolioDetailCardTile(
                    label: 'Virtual Margin Money',
                    info: 'Total funds added by StoxHero in your Account',
                    value: controller.tenxPortfolioDetails.value.totalFund,
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
                    label: 'Opening Balance',
                    info: 'Cash available at the beginning of the day',
                    value: (controller.tenxPortfolioDetails.value.openingBalance ?? 0) > 0
                        ? controller.tenxPortfolioDetails.value.openingBalance
                        : controller.tenxPortfolioDetails.value.totalFund,
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
