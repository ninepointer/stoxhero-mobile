import 'package:flutter/material.dart';

import '../../../app/app.dart';

class InternshipInfoCard extends GetView<InternshipController> {
  const InternshipInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
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
                    "Batch",
                    style: Theme.of(context).textTheme.tsGreyMedium12,
                  ),
                  SizedBox(height: 2),
                  Text(
                    "${controller.internshipBatchDetails.value.batchName ?? '-'}",
                    style: Theme.of(context).textTheme.tsMedium12,
                  ),
                ],
              ),
              SizedBox(height: 4),
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
                        "${FormatHelper.formatDateYear(controller.internshipBatchDetails.value.batchStartDate)}",
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
                        "${FormatHelper.formatDateYear(controller.internshipBatchDetails.value.batchEndDate)}",
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
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
                        "${FormatHelper.formatNumbers(controller.calculateMargin().round())}",
                        style: Theme.of(context).textTheme.tsMedium12,
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
