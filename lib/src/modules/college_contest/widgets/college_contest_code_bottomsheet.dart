import 'package:flutter/material.dart';

import '../../../app/app.dart';

class CollegeContestCodeBottomsheet extends GetView<CollegeContestController> {
  final VoidCallback onSubmit;
  const CollegeContestCodeBottomsheet({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withOpacity(0.25),
                ),
                child: Icon(
                  Icons.school,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Enter your College Code shared by your college POC to participate in the contest.',
                textAlign: TextAlign.center,
                style: AppStyles.tsGreyRegular14,
              ),
              SizedBox(height: 8),
              CommonTextField(
                autoFocus: true,
                hintText: 'College Code',
                controller: controller.collegeCodeTextController,
              ),
              CommonFilledButton(
                height: 40,
                label: 'Submit',
                onPressed: onSubmit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
