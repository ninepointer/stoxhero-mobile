import 'package:flutter/material.dart';

import '../../../app/app.dart';

class InternshipInfoCard extends GetView<InternshipController> {
  const InternshipInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Batch: ${controller.internshipBatchDetails.value.batchName ?? '-'}",
                  style: Theme.of(context).textTheme.tsMedium16,
                ),
              ),
              SizedBox(height: 8),
              // Container(
              //   child: Text(
              //     college ?? '-',
              //     style: AppStyles.tsWhiteMedium16,
              //   ),
              // ),
              SizedBox(height: 8),
              Container(
                child: Text(
                  "Start Date: ${FormatHelper.formatDateYear(controller.internshipBatchDetails.value.batchStartDate)}",
                  style: Theme.of(context).textTheme.tsMedium16,
                ),
              ),
              SizedBox(height: 8),
              Container(
                child: Text(
                  "End Date: ${FormatHelper.formatDateYear(controller.internshipBatchDetails.value.batchEndDate)}",
                  style: Theme.of(context).textTheme.tsMedium16,
                ),
              ),
              SizedBox(height: 8),
              Container(
                child: Text(
                  "Portfolio: ${FormatHelper.formatNumbers(controller.internshipBatchDetails.value.portfolio?.portfolioValue)}",
                  style: Theme.of(context).textTheme.tsMedium16,
                ),
              ),
              SizedBox(height: 8),
              Container(
                child: Text(
                  "Available Margin: ${FormatHelper.formatNumbers(controller.internshipBatchPortfolio.value.openingBalance)}",
                  style: Theme.of(context).textTheme.tsMedium16,
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
