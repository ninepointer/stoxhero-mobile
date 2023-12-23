import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class AffiliateView extends GetView<AffiliateController> {
  const AffiliateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Affiliate'),
      ),
      body: Obx(() => Visibility(
            visible: controller.isLoadingStatus,
            child: ListViewShimmer(),
            replacement: Column(
              children: [
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
                              onTap: () =>
                                  controller.showDateRangePicker(context),
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
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen,
                        labelColor: Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen,
                        height: 42,
                        label: 'Show Details',
                        onPressed: () {
                          controller.getAffiliateSummaryDetails();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16)
                            .copyWith(top: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: customCard(
                                context,
                                label: 'Product\nTransaction',
                                earning: controller.summeryList.isNotEmpty
                                    ? controller
                                        .summeryList.first.totalProductCount
                                        .toString()
                                    : "0",

                                // controller.summaryCount().toString()
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: customCard(
                                context,
                                label: 'Product \nEarnings',
                                earning:
                                    "${FormatHelper.formatNumbers(controller.summeryList.isNotEmpty ? controller.summeryList.first.totalProductCPayout ?? 0 : 0, decimal: 0)}",
                                valueColor: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
