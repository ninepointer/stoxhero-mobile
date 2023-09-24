import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';
import 'package:stoxhero/src/modules/virtual_trading/widgets/stock_card.dart';

import '../../../core/core.dart';

class VirtualTradingView extends GetView<VirtualTradingController> {
  const VirtualTradingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: RefreshIndicator(
            onRefresh: controller.loadData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StockCard(),
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
                    onPressed: controller.gotoSearchInstrument,
                    padding: EdgeInsets.only(left: 16),
                  ),
                  controller.virtualWatchList.isEmpty
                      ? NoDataFound()
                      : SizedBox(
                          height: controller.virtualWatchList.length >= 5
                              ? 300
                              : controller.virtualWatchList.length * 76,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.virtualWatchList.length,
                            itemBuilder: (context, index) {
                              return VirtualWatchListCard(
                                index: index,
                                data: controller.virtualWatchList[index],
                              );
                            },
                          ),
                        ),
                  if (controller.virtualPositionsList.isNotEmpty)
                    CommonTile(label: 'My Position Details'),
                  if (controller.virtualPositionsList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              VirtualPositionDetailsCard(
                                isNum: true,
                                label: 'Running Lots',
                                value: controller.tenxTotalPositionDetails.value.lots,
                              ),
                              SizedBox(width: 8),
                              VirtualPositionDetailsCard(
                                label: 'Brokerage',
                                value: controller.tenxTotalPositionDetails.value.brokerage,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              VirtualPositionDetailsCard(
                                label: 'Gross P&L',
                                // value:
                              ),
                              SizedBox(width: 8),
                              VirtualPositionDetailsCard(
                                label: 'Net P&L',
                                // value: FormatHelper.formatNumbers(
                                //   controller.calculateNetPNL(
                                //     controller.getInstrumentLastPrice(
                                //       controller.virtualPosition.value.iId!.instrumentToken!,
                                //       controller
                                //           .virtualPosition.value.iId!.exchangeInstrumentToken!,
                                //     ),
                                //     controller.virtualPosition.value.lastaverageprice,
                                //     controller.virtualPosition.value.lots,
                                //     controller.tenxTotalPositionDetails.value.brokerage,
                                //   ),
                                // ),
                                value: '0',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  CommonTile(label: 'My Position'),
                  controller.virtualPositionsList.isEmpty
                      ? NoDataFound()
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.virtualPositionsList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            return VirtualPositionCard(
                              position: controller.virtualPositionsList[index],
                            );
                          },
                        ),
                  CommonTile(label: 'Portfolio Details'),
                  VirtualPortfolioDetailsCard(
                    label: 'Portfolio Value',
                    value: controller.virtualPortfolio.value.totalFund,
                  ),
                  VirtualPortfolioDetailsCard(
                    label: 'Available Margin',
                    value: controller.virtualPortfolio.value.openingBalance,
                  ),
                  VirtualPortfolioDetailsCard(
                    label: 'Used Margin',
                    // value: controller.tenxTotalPositionDetails.value.brokerage,
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
