import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/contest/views/resultView.dart';
// import 'package:get_storage/get_storage.dart';
import '../../../app/app.dart';

class ContestTradingView extends GetView<ContestController> {
  final bool isLiveContest;
  const ContestTradingView({Key? key, this.isLiveContest = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '${isLiveContest ? controller.liveContest.value.contestName : controller.liveFeatured.value.contestName}',
        style: Theme.of(context).textTheme.tsRegular16,
        textAlign: TextAlign.center,
      )),
      body: Obx(
        () => Visibility(
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
                                // item.lastPrice! - (item.ohlc?.close ?? 0),
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
                              return ContestWatchlistCard(
                                index: index,
                                tradingWatchlist:
                                    controller.tradingWatchlist[index],
                              );
                            },
                          ),
                        ),
                  CommonTile(
                    label: 'My Rank',
                    showSeeAllButton: true,
                    seeAllLabel: 'Leaderboard',
                    onPressed: () =>
                        Get.toNamed(AppRoutes.contestLiveLeaderboard),
                  ),
                  // CommonRankCard(
                  //   rank: controller.myRank.toString(),
                  //   name:
                  //       '${controller.userDetails.value.firstName} ${controller.userDetails.value.lastName} ',
                  //   netPnL: controller.calculateTotalNetPNL().toString(),
                  //   reward: controller.liveContest.value.payoutType == 'Reward'
                  //       ? controller
                  //           .calculateUserReward(controller.myRank.toString())
                  //           .toString()
                  //       : controller.calculatePayout().toString(),
                  // ),
                  CommonCard(
                    hasBorder: false,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(.25),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '#${controller.myRank.toString()}',
                              style: AppStyles.tsSecondarySemiBold14,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${controller.userDetails.value.firstName} ${controller.userDetails.value.lastName}'
                                    .capitalize ??
                                '',
                            style: Theme.of(context).textTheme.tsMedium14,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Net P&L (Profit & Loss)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .tsGreyMedium12,
                                ),
                                Text(
                                  FormatHelper.formatNumbers(
                                    controller
                                        .calculateTotalNetPNL()
                                        .toString(),
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .tsMedium12
                                      .copyWith(
                                        color: controller.getValueColor(
                                            controller
                                                .calculateTotalNetPNL()
                                                .toString()),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          controller.liveFeatured.value.rewardType !=
                                      "Goodies" &&
                                  controller.liveContest.value.rewardType !=
                                      "Goodies"
                              ? Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Reward',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsGreyMedium12,
                                      ),
                                      Text(
                                        FormatHelper.formatNumbers(
                                          controller.liveContest.value
                                                      .payoutType !=
                                                  "Reward"
                                              ? controller
                                                  .calculatePayout()
                                                  .toString()
                                              : controller
                                                  .calculateUserReward(
                                                      controller.myRank
                                                          .toString())
                                                  .toString(),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsMedium12
                                            .copyWith(
                                              color: controller.getValueColor(
                                                controller.liveContest.value
                                                            .payoutType !=
                                                        "Reward"
                                                    ? controller
                                                        .calculatePayout()
                                                        .toString()
                                                    : controller
                                                        .calculateUserReward(
                                                            controller.myRank
                                                                .toString())
                                                        .toString(),
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ],
                  ),
                  if (controller.contestPositionsList.isNotEmpty)
                    CommonTile(label: 'My Position Summary'),
                  if (controller.contestPositionsList.isNotEmpty)
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
                                  controller.calculateTotalGrossPNL(),
                                ),
                              ),
                              SizedBox(width: 8),
                              PositionDetailCardTile(
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
                              if (controller.liveFeatured.value.rewardType != "Goodies" &&
                                  controller.liveContest.value.rewardType !=
                                      "Goodies")
                                PositionDetailCardTile(
                                    label: 'Reward',
                                    // valueColor: AppColors.success,
                                    value: controller.getRewardCapAmount(
                                        (controller.liveFeatured.value.entryFee ?? controller.liveContest.value.entryFee) == 0
                                            ? controller.liveFeatured.value.portfolio?.portfolioValue ??
                                                controller
                                                    .liveContest
                                                    .value
                                                    .portfolio
                                                    ?.portfolioValue ??
                                                0
                                            : (controller.liveFeatured.value.entryFee ??
                                                    controller.liveContest.value
                                                        .entryFee) ??
                                                0,
                                        controller.liveFeatured.value.payoutCapPercentage ??
                                            controller.liveContest.value
                                                .payoutCapPercentage ??
                                            0,
                                        controller.liveFeatured.value.payoutPercentage ??
                                            controller.liveContest.value
                                                .payoutPercentage ??
                                            0),
                                    valueColor: controller.getValueColor(controller.getRewardCapAmount((controller.liveFeatured.value.entryFee ?? controller.liveContest.value.entryFee) == 0 ? controller.liveFeatured.value.portfolio?.portfolioValue ?? controller.liveContest.value.portfolio?.portfolioValue ?? 0 : (controller.liveFeatured.value.entryFee ?? controller.liveContest.value.entryFee) ?? 0, controller.liveFeatured.value.payoutCapPercentage ?? controller.liveContest.value.payoutCapPercentage ?? 0, controller.liveFeatured.value.payoutPercentage ?? controller.liveContest.value.payoutPercentage ?? 0))),
                              SizedBox(width: 8),
                              if (controller.liveFeatured.value.rewardType !=
                                      "Goodies" &&
                                  controller.liveContest.value.rewardType !=
                                      "Goodies")
                                PositionDetailCardTile(
                                  label: 'TDS',
                                  value: controller.calculateTDS().round(),
                                  valueColor: controller.getValueColor(
                                    controller.calculateTDS(),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 8),
                          if (controller.liveFeatured.value.rewardType !=
                                  "Goodies" &&
                              controller.liveContest.value.rewardType !=
                                  "Goodies")
                            Row(
                              children: [
                                PositionDetailCardTile(
                                  label: 'Payout',
                                  value: controller.calculatefinalPayout(),
                                  valueColor: controller.getValueColor(
                                    controller.calculatefinalPayout(),
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
                  controller.contestPositionsList.isEmpty
                      ? NoDataFound(
                          label: AppStrings.noDataFoundPositions,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.contestPositionsList.length,
                          itemBuilder: (context, index) {
                            final position =
                                controller.contestPositionsList[index];
                            if (position.id?.isLimit != true) {
                              return ContestPositionCard(
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
                            return ContestStoplossPendingOrderCard(
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
                  controller.contestOrdersList.isEmpty
                      ? NoDataFound(
                          label: AppStrings.noDataFoundCompletedRejectedOrders,
                        )
                      : SizedBox(
                          height: controller.contestOrdersList.length >= 3
                              ? 180
                              : controller.contestOrdersList.length * 130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.contestOrdersList.length,
                            itemBuilder: (context, index) {
                              return ContestTodayOrderCard(
                                order: controller.contestOrdersList[index],
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
                    value: controller.contestPortfolio.value.totalFund,
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
        ),
      ),
    );
  }
}
