import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';
import '../widgets/analytics_chart.dart';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
      body: Obx(
        () => Visibility(
          visible: controller.isLoadingStatus,
          child: ListViewShimmer(),
          replacement: DefaultTabController(
            length: 2,
            initialIndex: controller.selectedTab.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.all(8).copyWith(top: 0),
                  color: Theme.of(context).cardColor,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.grey.withOpacity(.25),
                    ),
                    child: TabBar(
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.black,
                      splashBorderRadius: BorderRadius.circular(50),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.primary,
                      ),
                      tabs: [
                        AppStrings.tenX,
                        AppStrings.virtual,
                      ].map((label) => Tab(text: label)).toList(),
                      onTap: (value) => controller.selectedTab(value),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: AnalyticsInfoCard(
                                  title: "Today",
                                  grossValue: controller.overviewDetails.grossPNLDaily,
                                  brokeValue: controller.overviewDetails.brokerageSumDaily,
                                  netValue: controller.overviewDetails.netPNLDaily,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: AnalyticsInfoCard(
                                  title: "This Month",
                                  grossValue: controller.overviewDetails.grossPNLMonthly,
                                  brokeValue: controller.overviewDetails.brokerageSumMonthly,
                                  netValue: controller.overviewDetails.netPNLMonthly,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: AnalyticsInfoCard(
                                  title: "This Year",
                                  grossValue: controller.overviewDetails.grossPNLYearly,
                                  brokeValue: controller.overviewDetails.brokerageSumYearly,
                                  netValue: controller.overviewDetails.netPNLYearly,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: AnalyticsInfoCard(
                                  title: "Lifetime",
                                  grossValue: controller.overviewDetails.grossPNLLifetime,
                                  brokeValue: controller.overviewDetails.brokerageSumLifetime,
                                  netValue: controller.overviewDetails.netPNLLifetime,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.all(16),
                          color: Theme.of(context).cardColor,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Date Range',
                                style: AppStyles.tsSecondaryRegular18,
                              ),
                              Divider(thickness: 1, height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => controller.showDateRangePicker(context),
                                      child: CommonTextField(
                                        isDisabled: true,
                                        controller: controller.startDateTextController,
                                        hasLabel: true,
                                        hintText: 'Start Date',
                                        suffixIcon: Icon(
                                          Icons.calendar_month,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => controller.showDateRangePicker(
                                        context,
                                        isStartDate: false,
                                      ),
                                      child: CommonTextField(
                                        controller: controller.endDateTextController,
                                        isDisabled: true,
                                        hasLabel: true,
                                        hintText: 'End Date',
                                        suffixIcon: Icon(
                                          Icons.calendar_month,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CommonOutlinedButton(
                                height: 42,
                                label: 'Show Details',
                                onPressed: () {
                                  if (controller.selectedTab.value == 0) {
                                    controller.userDetailsData.designation == AppConstants.equityTraderType
                                        ? controller.getInfinityTradingDateWiseDetails()
                                        : controller.getTenxTradingDateWiseDetails();
                                  } else {
                                    controller.selectedTab(1);
                                    controller.getVirtualTradingDateWiseDetails();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonCard(
                                  margin: EdgeInsets.zero,
                                  children: [
                                    Text(
                                      'Gross',
                                      style: Theme.of(context).textTheme.tsRegular14,
                                    ),
                                    SizedBox(height: 2),
                                    FittedBox(
                                      child: Text(
                                        FormatHelper.formatNumbers(
                                          controller.rangeGrossAmount.value,
                                        ),
                                        style: AppStyles.tsPrimaryMedium14.copyWith(
                                          color: controller.rangeGrossAmount.value == 0
                                              ? AppColors.info
                                              : controller.rangeGrossAmount.value < 0
                                                  ? AppColors.danger
                                                  : AppColors.success,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: CommonCard(
                                  margin: EdgeInsets.zero,
                                  children: [
                                    Text(
                                      'Net',
                                      style: Theme.of(context).textTheme.tsRegular14,
                                    ),
                                    SizedBox(height: 2),
                                    FittedBox(
                                      child: Text(
                                        FormatHelper.formatNumbers(
                                          controller.rangeNetAmount.value,
                                        ),
                                        style: AppStyles.tsPrimaryMedium14.copyWith(
                                          color: controller.rangeNetAmount.value == 0
                                              ? AppColors.info
                                              : controller.rangeNetAmount.value < 0
                                                  ? AppColors.danger
                                                  : AppColors.success,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: CommonCard(
                                  margin: EdgeInsets.zero,
                                  children: [
                                    Text(
                                      'Brokerage',
                                      style: Theme.of(context).textTheme.tsRegular14,
                                    ),
                                    SizedBox(height: 2),
                                    FittedBox(
                                      child: Text(
                                        FormatHelper.formatNumbers(
                                          controller.rangeBrokerageAmount.value,
                                        ),
                                        style: AppStyles.tsPrimaryMedium14.copyWith(
                                          color: controller.rangeBrokerageAmount.value == 0
                                              ? AppColors.info
                                              : controller.rangeBrokerageAmount.value < 0
                                                  ? AppColors.danger
                                                  : AppColors.success,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonCard(
                                  margin: EdgeInsets.zero,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Orders',
                                          style: Theme.of(context).textTheme.tsRegular14,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          controller.rangeTotalOrders.value.toString(),
                                          style: AppStyles.tsPrimaryMedium14.copyWith(
                                            color: AppColors.info,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: CommonCard(
                                  margin: EdgeInsets.zero,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Trading Days',
                                          style: Theme.of(context).textTheme.tsRegular14,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          controller.rangeTotalTradingDays.value.toString(),
                                          style: AppStyles.tsPrimaryMedium14.copyWith(
                                            color: AppColors.info,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonCard(
                                  margin: EdgeInsets.zero,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Green Days',
                                          style: Theme.of(context).textTheme.tsRegular14,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          controller.rangeTotalGreenDays.value.toString(),
                                          style: AppStyles.tsPrimaryMedium14.copyWith(
                                            color: AppColors.success,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: CommonCard(
                                  margin: EdgeInsets.zero,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Red Days',
                                          style: Theme.of(context).textTheme.tsRegular14,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          controller.rangeTotalRedDays.value.toString(),
                                          style: AppStyles.tsPrimaryMedium14.copyWith(
                                            color: AppColors.danger,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnalyticsChart(
                          title: 'Gross P & L',
                          barGroups: controller.getGrossChartsData(
                            barColor: AppColors.success,
                          ),
                        ),
                        AnalyticsChart(
                          title: 'Net P & L',
                          barGroups: controller.getNetChartsData(
                            barColor: AppColors.info,
                          ),
                        ),
                        AnalyticsChart(
                          title: 'Brokerage',
                          barGroups: controller.getBrokerageChartsData(
                            barColor: AppColors.warning,
                          ),
                        ),
                        AnalyticsChart(
                          title: 'Orders',
                          barGroups: controller.getOrdersChartsData(
                            barColor: AppColors.cyan,
                          ),
                        ),
                        ExpectedAnalyticsChart(
                          title: 'Expected Avg Profit',
                          barGroups: controller.getExpectedAvgProfitChartData(
                            barColor: AppColors.cyan,
                          ),
                        ),
                        ExpectedAnalyticsChart(
                          title: 'Expected Avg Loss',
                          barGroups: controller.getExpectedAvgLossChartData(
                            barColor: AppColors.cyan,
                          ),
                        ),
                        ExpectedAnalyticsChart(
                          title: 'Expected P&L',
                          barGroups: controller.getExpectedPnLChartData(
                            barColor: AppColors.cyan,
                          ),
                        ),
                        ExpectedAnalyticsChart(
                          title: 'Risk Reward Ratio',
                          barGroups: controller.getRiskRewardChartData(
                            barColor: AppColors.danger,
                          ),
                        ),
                        MonthlyAnalyticsChart(
                          title: 'Monthly Gross P&L',
                          barGroups: controller.getMonthlyGPnLChartData(
                            barColor: AppColors.primary,
                          ),
                        ),
                        MonthlyAnalyticsChart(
                          title: 'Monthly Net P&L',
                          barGroups: controller.getMonthlyNPnlChartData(
                            barColor: AppColors.secondary,
                          ),
                        ),
                        SizedBox(height: 36),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
