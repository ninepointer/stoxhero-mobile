import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class TenxDashboardView extends GetView<TenxTradingController> {
  const TenxDashboardView({Key? key}) : super(key: key);

  Widget buildInfoCard(BuildContext context, {required String label}) {
    return Expanded(
      child: Card(
        elevation: 0,
        margin: EdgeInsets.only(top: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.grey.shade400,
                    ),
                    child: Icon(
                      Icons.trending_up_rounded,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: AppStyles.tsSecondaryMedium10,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '₹ 12,500.90',
                        style: AppStyles.tsWhiteSemiBold14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Today',
                    style: AppStyles.tsPrimaryRegular12,
                  ),
                  Spacer(),
                  Text(
                    '₹ 125.87',
                    style: Theme.of(context).textTheme.tsMedium12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '(+ 0.25%)',
                    style: Theme.of(context).textTheme.tsMedium12.copyWith(
                          color: AppColors.success,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trading'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: controller.gotoSearchInstrument,
          ),
        ],
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        buildInfoCard(context, label: "NIFTY 50"),
                        SizedBox(width: 8),
                        buildInfoCard(context, label: "BANK NIFTY"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        buildInfoCard(context, label: "Margin"),
                        SizedBox(width: 8),
                        buildInfoCard(context, label: "NET P&L"),
                      ],
                    ),
                  ),
                  CustomTile(label: 'My Watchlist'),
                  controller.tenxWatchlist.isEmpty
                      ? NoDataFound()
                      : SizedBox(
                          height: controller.tenxWatchlist.length >= 5 ? 300 : controller.tenxWatchlist.length * 60,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.tenxWatchlist.length,
                            itemBuilder: (context, index) {
                              return TenxWatchlistCard(
                                index: index,
                                data: controller.tenxWatchlist[index],
                              );
                            },
                          ),
                        ),
                  if (controller.tenxPositionsList.isNotEmpty) CustomTile(label: 'My Position Details'),
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
                                value: '0',
                              ),
                              SizedBox(width: 8),
                              TenxPositionDetailsCard(
                                label: 'Net P&L',
                                value: '0',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  CustomTile(label: 'My Position'),
                  controller.tenxPositionsList.isEmpty
                      ? NoDataFound()
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.tenxPositionsList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            return TenxPositionCard(
                              data: controller.tenxPositionsList[index],
                            );
                          },
                        ),
                  CustomTile(label: 'Portfolio Details'),
                  TenxPortfolioDetailsCard(
                    label: 'Portfolio Value',
                    info: 'Total funds added by StoxHero in your Account',
                    value: controller.tenxPortfolioDetails.value.totalFund,
                  ),
                  TenxPortfolioDetailsCard(
                    label: 'Available Margin',
                    info: 'Funds that you can used to trade today',
                    value: '0',
                  ),
                  TenxPortfolioDetailsCard(
                    label: 'Used Margin',
                    info: 'Net funds utilized for your executed trades',
                    value: controller.tenxTotalPositionDetails.value.brokerage,
                  ),
                  TenxPortfolioDetailsCard(
                    label: 'Opening Balance',
                    info: 'Cash available at the beginning of the day',
                    value: controller.tenxPortfolioDetails.value.openingBalance,
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
