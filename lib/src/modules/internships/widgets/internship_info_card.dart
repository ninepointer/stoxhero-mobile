import 'package:flutter/material.dart';

import '../../../app/app.dart';

class InternshipInfoCard extends GetView<InternshipController> {
  const InternshipInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // // num? mycurrentAttendance =
    // //     controller.internshipBatchDetails.value.myAttendance as num;
    // // print('mycurrentAtrtendece $mycurrentAttendance');
    // // num? requiredAttendance =
    // //     controller.internshipBatchDetails.value.attendancePercentage as num;
    // // print('requiredAttendance $requiredAttendance');
    // bool certificateEligibility =
    //     double.parse(controller.internshipBatchDetails.value.myAttendance??0) >= controller.internshipBatchDetails.value.attendancePercentage??0;
    // print('certificateEligibility $certificateEligibility');

    return Obx(
      () => CommonCard(
        margin: EdgeInsets.symmetric(vertical: 16),
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Batch Name",
                      style: Theme.of(context).textTheme.tsGreyMedium12,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${controller.internshipBatchDetails.value.batchName ?? '-'}",
                      style: Theme.of(context).textTheme.tsMedium12,
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Starts",
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${FormatHelper.formatDateTimeToIST(controller.internshipBatchDetails.value.batchStartDate)}",
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Ends",
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${FormatHelper.formatDateTimeToIST(controller.internshipBatchDetails.value.batchEndDate)}",
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Virtual Margin Money",
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${FormatHelper.formatNumbers(controller.internshipBatchDetails.value.portfolio?.portfolioValue)}",
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Available Margin Money",
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          FormatHelper.formatNumbers(
                              controller.calculateMargin().round()),
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ],
                ),

                //////asbdksbfkb
                ///sdknfkgnk
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Attendance",
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${controller.internshipBatchDetails.value.myAttendance}%",
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Min Attendance Required',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                            "${controller.internshipBatchDetails.value.attendancePercentage}%",
                            style: Theme.of(context).textTheme.tsMedium12),
                      ],
                    ),
                  ],
                ),

                ///edshfi
                ///svhhribg
                ///seiog
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Referrals",
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${controller.internshipBatchDetails.value.myReferrals}",
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Required Referrals',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                            "${controller.internshipBatchDetails.value.referralCount}",
                            style: Theme.of(context).textTheme.tsMedium12),
                      ],
                    ),
                  ],
                ),

                ///agege
                ///gsaehh/sehs
                ///shdshh
                ///hsgh
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Max Stipend Amount",
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          FormatHelper.formatNumbers('15000'),
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Stipend',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                            "${controller.internshipBatchDetails.value.payoutPercentage}% of net P&L",
                            style: Theme.of(context).textTheme.tsMedium12),
                      ],
                    ),
                  ],
                ),

                ///sgg
                ///sgg
                ///sgbsh
                SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Eligibility for Certificate",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${double.parse(controller.internshipBatchDetails.value.myAttendance ?? '0') >= double.parse(controller.internshipBatchDetails.value.attendancePercentage.toString()) && double.parse(controller.internshipBatchDetails.value.myReferrals.toString()) >= double.parse(controller.internshipBatchDetails.value.referralCount.toString()) ? "Yes" : 'Not Yet'}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
                // SizedBox(height: 3),
                // Row(
                //   children: [
                //     Column(
                //       children: [
                //         Text(
                //           "Trading on a given a day is equivalent to marking attendance\nfor that day.",
                //           style: TextStyle(color: Colors.grey, fontSize: 10),
                //         )
                //       ],
                //     )
                //   ],
                // ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Eligibility for Stipend",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${double.parse(controller.internshipBatchDetails.value.myAttendance ?? '0') >= double.parse(controller.internshipBatchDetails.value.attendancePercentage.toString()) && double.parse(controller.internshipBatchDetails.value.myReferrals.toString()) >= double.parse(controller.internshipBatchDetails.value.referralCount.toString()) ? "Yes" : 'Not Yet'}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),

                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CommonOutlinedButton(
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen,
                        labelColor: Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen,
                        height: 42,
                        label: 'View Orders',
                        onPressed: () {
                          controller.loadOrderData();
                          Get.to(() => InternshipOrdersView());
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CommonOutlinedButton(
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen,
                        labelColor: Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen,
                        height: 42,
                        label: 'View Analytics',
                        onPressed: () {
                          Get.to(() => InternshipAnalyticsView());
                          Get.find<InternshipController>()
                              .loadInternshipAnalyticsData();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                CommonOutlinedButton(
                  backgroundColor: Get.isDarkMode
                      ? AppColors.darkGreen
                      : AppColors.lightGreen,
                  labelColor: Get.isDarkMode
                      ? AppColors.darkGreen
                      : AppColors.lightGreen,
                  height: 42,
                  label: 'Start Trading',
                  onPressed: () {
                    controller.loadTradingData();
                    Get.to(() => InternshipTradingView());
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
