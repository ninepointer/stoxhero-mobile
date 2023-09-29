import 'package:flutter/material.dart';
import '../../../../app/app.dart';

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
                  if (controller.stockIndexDetailsList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: marginNPNLCard(
                            context,
                            label: 'Margin',
                            value: controller.tenxTotalPositionDetails.value.net,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: marginNPNLCard(
                            context,
                            label: 'Net P & L',
                            value: controller.calculateTotalNetPNL(),
                          ),
                        ),
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
                              return VirtualWatchListCard(
                                index: index,
                                tradingWatchlist: controller.tradingWatchlist[index],
                              );
                            },
                          ),
                        ),
                  if (controller.virtualPositionsList.isNotEmpty) CommonTile(label: 'My Position Details'),
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
                                value: controller.calculateTotalGrossPNL(),
                              ),
                              SizedBox(width: 8),
                              VirtualPositionDetailsCard(
                                label: 'Net P&L',
                                value: controller.calculateTotalNetPNL(),
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
                    label: 'Virtual Portfolio Value',
                    value: controller.virtualPortfolio.value.totalFund,
                  ),
                  VirtualPortfolioDetailsCard(
                    label: 'Available Margin',
                    // value: difference,
                    value: controller.calculateMargin(),
                  ),
                  VirtualPortfolioDetailsCard(
                    label: 'Virtual Used Margin',
                    value: controller.calculateTotalNetPNL().abs(),
                    valueColor:
                        (controller.tenxTotalPositionDetails.value.net ?? 0) < 0 ? AppColors.danger : AppColors.success,
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

  Widget marginNPNLCard(
    BuildContext context, {
    String? label,
    dynamic value,
  }) {
    return CommonCard(
      margin: EdgeInsets.zero,
      children: [
        Text(
          label ?? '',
          style: AppStyles.tsSecondaryMedium16,
        ),
        SizedBox(height: 4),
        Text(
          FormatHelper.formatNumbers(
            value,
          ),
          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                color: (value is num && value < 0) ? AppColors.danger : AppColors.success,
              ),
        ),
      ],
    );
  }
}
