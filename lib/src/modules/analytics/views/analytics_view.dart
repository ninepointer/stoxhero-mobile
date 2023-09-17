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
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: DefaultTabController(
            length: 2,
            initialIndex: controller.selectedTab.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.grey.withOpacity(.25),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: AppColors.primary,
                        border: Border.all(
                          width: 1,
                          color: AppColors.primary,
                        ),
                      ),
                      labelStyle: Theme.of(context).textTheme.tsWhiteMedium14.copyWith(
                            color: AppColors.white,
                          ),
                      unselectedLabelStyle: Theme.of(context).textTheme.tsMedium14,
                      tabs: [
                        controller.userDetailsData.designation == AppConstants.equityTraderType
                            ? Tab(text: 'Infinity Trading')
                            : Tab(text: 'TenX Trading'),
                        Tab(text: 'Virtual Trading'),
                      ],
                      onTap: (value) {
                        controller.selectedTab(value);
                        controller.rangeCalculation();
                      },
                    ),
                  ),
                ),
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
                              SizedBox(width: 16),
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
                        SizedBox(height: 16),
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
                              SizedBox(width: 16),
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
                          margin: EdgeInsets.symmetric(vertical: 16),
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
                                    Text(
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
                                    Text(
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
                                    Text(
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
                                          style: AppStyles.tsPrimaryMedium18.copyWith(
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
                                          style: AppStyles.tsPrimaryMedium18.copyWith(
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
                                          style: AppStyles.tsPrimaryMedium18.copyWith(
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
                                          style: AppStyles.tsPrimaryMedium18.copyWith(
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
                        AnalyticsChart(
                          title: 'Risk Reward Ratio',
                          barGroups: controller.getOrdersChartsData(
                            barColor: AppColors.cyan,
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
