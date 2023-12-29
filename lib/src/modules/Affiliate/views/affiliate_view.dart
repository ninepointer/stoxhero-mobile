import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/Affiliate/widgets/affiliate_paid_referrlas_pie_chart.dart';
import '../../../app/app.dart';

class AffiliateView extends StatefulWidget {
  @override
  _AffiliateViewState createState() => _AffiliateViewState();
}

class _AffiliateViewState extends State<AffiliateView> {
  late AffiliateController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AffiliateController>();
  }

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
        child: Column(
          children: [
            MyAffilateDashboardSummary(),
            // AffiliateChart(
            //   title: "Last 30 days daily earnings",
            //   barGroups:
            // ),
            PieChartReferrals(),
            SizedBox(
              height: 8,
            ),
            PieChartPaidReferrals(),
            // AffiliateChart(
            //   title: "Last 30 days daily",
            // ),
            SizedBox(
              height: 8,
            ),
            // AffiliateChart(
            //   title: "Last 30 days daily ",
            // ),
            // Text("hello"),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(16),
              color: Theme.of(context).cardColor,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(
                                8.0), // Set border radius as needed
                          ),
                          child: CommonDropdown(
                            useSeptValue: true,
                            color: Theme.of(context).cardColor,
                            hint: 'Date',
                            value: controller.selectedTimeFrame,
                            dropdownItems: controller.timeFrames,
                            onChanged: (String? value) {
                              setState(() {
                                controller.selectedTimeFrame = value ?? '';
                                controller.loadData();
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Visibility(
                    visible: controller.selectedTimeFrame == 'custom',
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
                                  controller:
                                      controller.startDateTextController,
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
                              ? AppColors.white
                              : AppColors.lightGreen,
                          height: 42,
                          label: 'Show Details',
                          onPressed: () {
                            controller.getAffiliateSummaryDetails();
                            controller.getAffiliateSignUpDetails();
                            controller.getMyAffiliateTransctionDetails();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isLoadingStatus,
                      child: ListViewShimmer(),
                      replacement: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(
                                    context,
                                    label: 'No of\nReferrals',
                                    earning: "3",
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: customCard(
                                    context,
                                    label: 'Active \nReferrlas',
                                    earning: "3",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(
                                    context,
                                    label: 'Act\nConversion',
                                    earning: "2.3%",
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: customCard(
                                    context,
                                    label: 'Paid \nReferrals',
                                    earning: "3%",
                                    // valueColor: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(
                                    context,
                                    label: 'Paid \nConversion',
                                    earning: "2.3%",
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: customCard(
                                    context,
                                    label: 'Referral\nAmount',
                                    earning:
                                        "${FormatHelper.formatNumbers("15", decimal: 0)}",
                                    // valueColor: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(context,
                                      label: 'Activation\nAmount',
                                      earning:
                                          "${FormatHelper.formatNumbers("15", decimal: 0)}"
                                      // controller.summaryCount().toString()
                                      ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: customCard(
                                    context,
                                    label: 'No. of \nPurchases',
                                    earning: "15",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(
                                    context,
                                    label: 'Commission',
                                    earning:
                                        "${FormatHelper.formatNumbers("15", decimal: 0)}",
                                    // valueColor: AppColors.success,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: customCard(
                                    context,
                                    label: 'Total\nAmount',
                                    earning:
                                        "${FormatHelper.formatNumbers("15", decimal: 0)}",
                                    valueColor: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: customCard(
                            //         context,
                            //         label: 'Total Earnings',
                            //         earning: FormatHelper.formatNumbers(totalEarning(), decimal: 0),
                            //         valueColor: AppColors.success,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 12),
                            if (controller.myAffiliateRefferalsList.isNotEmpty)
                              CommonTile(
                                label: "Referrals",
                                margin: EdgeInsets.zero,
                              ),
                            if (controller.myAffiliateRefferalsList.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.myAffiliateRefferalsList.length,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  MyAffiliateRefferal? affiliateReferral =
                                      controller
                                          .myAffiliateRefferalsList[index];
                                  return MyAffilateReferralDetailCard(
                                    rank:
                                        (controller.reffralsCurrentPage.value *
                                                controller.reffralsItemsPerPage
                                                    .value) +
                                            index +
                                            1,
                                    affiliateReferral: affiliateReferral,
                                  );
                                },
                              ),
                            SizedBox(
                              height: 8,
                            ),
                            if (controller.reffralsTotalItems > 10)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: controller
                                              .isrefferlsPreviousButtonDisabled
                                          ? null
                                          : controller.reffralsPreviousPage,
                                      child: Text(
                                        'Previous',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsMedium14
                                            .copyWith(
                                              color: AppColors.primary,
                                            ),
                                      ),
                                    ),
                                    // SizedBox(width: 16),
                                    // Text(
                                    //   'Page ${controller.reffralsCurrentPage + 1} of ${controller.reffralsLastPage + 1}',
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .tsMedium14
                                    //       .copyWith(
                                    //         color: AppColors.primary,
                                    //       ),
                                    // ),
                                    SizedBox(width: 16),
                                    GestureDetector(
                                      onTap: controller
                                              .isreferralsNextButtonDisabled
                                          ? null
                                          : controller.refferalsNextPage,
                                      child: Text(
                                        'Next',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsMedium14
                                            .copyWith(
                                              color: AppColors.primary,
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 8,
                            ),
                            if (controller.myAffiliateRefferalsList.isNotEmpty)
                              SizedBox(height: 12),
                            if (controller.transactionList.isNotEmpty)
                              CommonTile(
                                label: "Affiliate Transactions",
                                margin: EdgeInsets.zero,
                              ),
                            if (controller.myAffiliateTransctionList.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.myAffiliateTransctionList.length,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var user = controller
                                      .myAffiliateTransctionList[index];
                                  return AffilateTransactionCard(
                                    name:
                                        '${user.buyerFirstName!.capitalizeFirst ?? ""}',
                                    productName: "${user.productName ?? ''}",
                                    transactionId:
                                        "${user.transactionId ?? ''}",
                                    earnings: user.payout ?? 0,
                                    date: "${user.date ?? ""}",
                                  );
                                },
                              ),
                            SizedBox(height: 8),
                            if (controller.transctionTotalItems > 10)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: controller.isPreviousButtonDisabled
                                          ? null
                                          : controller.previousPage,
                                      child: Text(
                                        'Previous',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsMedium14
                                            .copyWith(
                                              color: AppColors.primary,
                                            ),
                                      ),
                                    ),
                                    // SizedBox(width: 16),
                                    // Text(
                                    //   'Page ${controller.transctionCurrentPage + 1} of ${controller.transctionLastPage + 1}',
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .tsMedium14
                                    //       .copyWith(
                                    //         color: AppColors.primary,
                                    //       ),
                                    // ),
                                    SizedBox(width: 16),
                                    GestureDetector(
                                      onTap: controller.isNextButtonDisabled
                                          ? null
                                          : controller.nextPage,
                                      child: Text(
                                        'Next',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsMedium14
                                            .copyWith(
                                              color: AppColors.primary,
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
