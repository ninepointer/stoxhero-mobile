import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class AffiliateView extends GetView<AffiliateController> {
  const AffiliateView({Key? key}) : super(key: key);

  num? totalEarning() {
    num sum = 0;
    sum = (controller.affiliateSignupSummeryList.isNotEmpty
            ? controller
                    .affiliateSignupSummeryList.first.affiliateRefferalPayout ??
                0
            : 0) +
        (controller.summeryList.isNotEmpty
            ? controller.summeryList.first.totalProductCPayout ?? 0
            : 0);
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Affiliate Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // Column(
          //  children: [
          //   return
          //  ],
          // ),
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
                  backgroundColor: Get.isDarkMode
                      ? AppColors.darkGreen
                      : AppColors.lightGreen,
                  labelColor:
                      Get.isDarkMode ? AppColors.white : AppColors.lightGreen,
                  height: 42,
                  label: 'Show Details',
                  onPressed: () {
                    controller.getAffiliateSummaryDetails();
                    controller.getAffiliateSignUpDetails();
                    controller.getMyAffiliateTransctionDetails();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isLoadingStatus,
                    child: ListViewShimmer(),
                    replacement: Column(
                      children: [
                        Row(
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
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: customCard(
                                context,
                                label: 'Total\nSignup',
                                earning: (controller.affiliateSignupSummeryList
                                            .isNotEmpty
                                        ? controller.affiliateSignupSummeryList
                                                .first.affiliateRefferalCount ??
                                            0
                                        : 0)
                                    .toString(),

                                // controller.summaryCount().toString()
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: customCard(
                                context,
                                label: 'SignUp \nEarnings',
                                earning:
                                    "${FormatHelper.formatNumbers(controller.affiliateSignupSummeryList.isNotEmpty ? controller.affiliateSignupSummeryList.first.affiliateRefferalPayout ?? 0 : 0, decimal: 0)}",
                                valueColor: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: customCard(
                                context,
                                label: 'Total Earnings',
                                earning: FormatHelper.formatNumbers(
                                    totalEarning(),
                                    decimal: 0),
                                valueColor: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        controller.affiliateSignUpDetails.length != 0
                            ? CommonTile(
                                label: "Referrals",
                                margin: EdgeInsets.zero,
                              )
                            : Container(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.affiliateSignUpDetails.length,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var user = controller.affiliateSignUpDetails[index];
                            return AffilateSignUpDetailsCard(
                              rank: index + 1,
                              name: '${user.name ?? ""} ',
                              earnings: user.payout ?? 0,
                              date: "${user.joiningDate ?? ''}",
                            );
                          },
                        ),
                        controller.affiliateSignUpDetails.length != 0
                            ? SizedBox(height: 12)
                            : Container(),
                        controller.myAffiliateTransctionList.length != 0
                            ? CommonTile(
                                label: "Affiliate Transactions",
                                margin: EdgeInsets.zero,
                              )
                            : Container(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              controller.myAffiliateTransctionList.length,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var user =
                                controller.myAffiliateTransctionList[index];
                            return AffilateTransactionCard(
                              name:
                                  '${user.buyerFirstName!.capitalizeFirst ?? ""}',
                              productName: "${user.productName ?? ''}",
                              transactionId: "${user.transactionId ?? ''}",
                              earnings: user.payout ?? 0,
                              date: "${user.date ?? ""}",
                            );
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: controller.isPreviousButtonDisabled
                                  ? null
                                  : controller.previousPage,
                              child: Text(
                                'Previous',
                                style: Theme.of(context)
                                    .textTheme
                                    .tsMedium12
                                    .copyWith(
                                      color: AppColors.primary,
                                    ),
                              ),
                            ),
                            SizedBox(width: 16),
                            GestureDetector(
                                onTap: controller.isNextButtonDisabled
                                    ? null
                                    : controller.nextPage,
                                child: Text('Next',
                                    style: Theme.of(context)
                                        .textTheme
                                        .tsMedium12
                                        .copyWith(
                                          color: AppColors.primary,
                                        ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
