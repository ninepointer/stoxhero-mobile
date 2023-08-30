import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/careers/views/career_form.dart';
import 'package:stoxhero/src/modules/modules.dart';

class CareerView extends StatelessWidget {
  const CareerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Careers'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customCard(
                title: 'Internship',
                image: AppImages.internship,
              ),
              SizedBox(height: 8),
              customCard(
                title: 'Workshop',
                image: AppImages.workshop,
              ),
              SizedBox(height: 8),
              customCard(
                title: 'Jobs',
                image: AppImages.job,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customCard({required String title, required String image}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppStyles.tsPrimaryMedium18,
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Image.asset(
                image,
                height: 150,
              ),
              CommonFilledButton(
                label: 'Click here to Apply!',
                height: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                onPressed: () {
                  Get.to(() => InternshipView());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
