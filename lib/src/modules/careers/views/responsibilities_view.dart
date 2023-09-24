import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../../../data/data.dart';
import '../../modules.dart';

class ResponsibilitiesView extends GetView<CareerController> {
  final String? careerId;

  ResponsibilitiesView({required this.careerId});

  @override
  Widget build(BuildContext context) {
    final CareerList? selectedCareer = controller.careerList.firstWhere(
      (item) => item.sId == careerId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Roles & Responsibilities'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Job Description',
                style: AppStyles.tsSecondaryMedium20,
              ),
              SizedBox(height: 16),
              CommonCard(
                margin: EdgeInsets.zero,
                children: [
                  if (selectedCareer != null)
                    ...selectedCareer.rolesAndResponsibilities
                            ?.map((responsibility) =>
                                _buildResponsibilityRow(responsibility, context))
                            .toList() ??
                        [], // Use map to create rows
                ],
              ),
              SizedBox(height: 16),
              CommonFilledButton(
                label: 'Apply',
                onPressed: () => Get.to(() => CareerForm()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsibilityRow(RolesAndResponsibilities responsibility, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${FormatHelper.formatNumbers(
                responsibility.orderNo ?? 0,
                showSymbol: false,
                decimal: 0,
              )})',
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                responsibility.description ?? '',
                style: Theme.of(context).textTheme.tsRegular14,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
      ],
    );
  }
}
