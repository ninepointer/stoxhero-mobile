import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';
import '../../../core/core.dart';
import '../../modules.dart';

class InfoCard extends StatelessWidget {
  final CareerData? career;
  const InfoCard({
    Key? key,
    this.career,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.school,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  career?.jobTitle ?? '',
                  style: Theme.of(context).textTheme.tsMedium18,
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 1, height: 0),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            career?.jobDescription ?? '',
            style: AppStyles.tsGreyRegular14,
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  career?.listingType == 'Workshop' ? '${career?.listingType}' : '${career?.jobType}',
                  textAlign: TextAlign.center,
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.info,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  career?.jobLocation ?? '',
                  textAlign: TextAlign.center,
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: CommonFilledButton(
            label: 'Click here to Apply!',
            height: 42,
            onPressed: () {
              Get.to(
                () => ResponsibilitiesView(
                  careerId: career?.id,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
