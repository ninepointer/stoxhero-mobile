import 'package:flutter/material.dart';

import '../../../app/app.dart';

class InternshipAnalyticsView extends GetView<InternshipController> {
  const InternshipAnalyticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship Analytics'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: AnalyticsInfoCard(
                            title: "Today",
                            grossValue: controller.internshipOverview.value.grossPNLDaily,
                            netValue: controller.internshipOverview.value.netPNLDaily,
                            brokeValue: controller.internshipOverview.value.brokerageSumDaily,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: AnalyticsInfoCard(
                            title: "This Month",
                            grossValue: controller.internshipOverview.value.grossPNLMonthly,
                            netValue: controller.internshipOverview.value.netPNLMonthly,
                            brokeValue: controller.internshipOverview.value.brokerageSumMonthly,
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
                            grossValue: controller.internshipOverview.value.grossPNLYearly,
                            netValue: controller.internshipOverview.value.netPNLYearly,
                            brokeValue: controller.internshipOverview.value.brokerageSumYearly,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: AnalyticsInfoCard(
                            title: "Lifetime",
                            grossValue: controller.internshipOverview.value.grossPNLLifetime,
                            netValue: controller.internshipOverview.value.netPNLLifetime,
                            brokeValue: controller.internshipOverview.value.brokerageSumLifetime,
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
                          backgroundColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                          labelColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                          height: 42,
                          label: 'Show Details',
                          onPressed: () {
                            controller.getInternshipAnalyticsDateWisePnLOverviewDetails();
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
                  InternshipAnalyticsChart(
                    title: 'Gross P & L',
                    barGroups: controller.getGrossChartsData(
                      barColor: AppColors.success,
                    ),
                  ),
                  InternshipAnalyticsChart(
                    title: 'Net P & L',
                    barGroups: controller.getNetChartsData(
                      barColor: AppColors.info,
                    ),
                  ),
                  InternshipAnalyticsChart(
                    title: 'Brokerage',
                    barGroups: controller.getBrokerageChartsData(
                      barColor: AppColors.warning,
                    ),
                  ),
                  InternshipAnalyticsChart(
                    title: 'Orders',
                    barGroups: controller.getOrdersChartsData(
                      barColor: AppColors.cyan,
                    ),
                  ),
                  MonthlyAnalyticsChart(
                    title: 'Monthly Gross P&L',
                    barGroups: controller.getMonthlyGrossPNLChartsData(
                      barColor: AppColors.danger,
                    ),
                  ),
                  MonthlyAnalyticsChart(
                    title: 'Monthly Net P&L',
                    barGroups: controller.getMonthlyNetPNLChartsData(
                      barColor: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
