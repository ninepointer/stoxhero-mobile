import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../../../data/data.dart';
import '../../modules.dart';

class ResponsibilitiesView extends GetView<CareerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roles & Responsibilities'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Job Description', style: AppStyles.tsSecondaryMedium20),
              SizedBox(height: 16),
              CommonCard(
                margin: EdgeInsets.zero,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.careerList.length,
                    itemBuilder: (BuildContext context, index) {
                      List<RolesAndResponsibilities>? responsibilities =
                          controller.careerList[index].rolesAndResponsibilities;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < (responsibilities?.length ?? 0); i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${FormatHelper.formatNumbers(
                                        responsibilities![i].orderNo ?? 0,
                                        showSymbol: false,
                                        decimal: 0,
                                      )})',
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        responsibilities[i].description ?? '',
                                        style: Theme.of(context).textTheme.tsRegular14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14),
                              ],
                            ),
                        ],
                      );
                    },
                  ),
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
}
