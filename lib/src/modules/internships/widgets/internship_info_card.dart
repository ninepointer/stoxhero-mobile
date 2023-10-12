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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Batch",
                    style: Theme.of(context).textTheme.tsGreyMedium14,
                  ),
                  Text(
                    "${controller.internshipBatchDetails.value.batchName ?? '-'}",
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start Date",
                        style: Theme.of(context).textTheme.tsGreyMedium14,
                      ),
                      Text(
                        "${FormatHelper.formatDateYear(controller.internshipBatchDetails.value.batchStartDate)}",
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "End Date",
                        style: Theme.of(context).textTheme.tsGreyMedium14,
                      ),
                      Text(
                        "${FormatHelper.formatDateYear(controller.internshipBatchDetails.value.batchEndDate)}",
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Portfolio",
                        style: Theme.of(context).textTheme.tsGreyMedium14,
                      ),
                      Text(
                        "${FormatHelper.formatNumbers(controller.internshipBatchDetails.value.portfolio?.portfolioValue)}",
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Available Margin Money",
                        style: Theme.of(context).textTheme.tsGreyMedium14,
                      ),
                      Text(
                        "${FormatHelper.formatNumbers(controller.calculateMargin().round())}",
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
