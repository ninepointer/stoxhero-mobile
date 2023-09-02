import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/careers/views/workshop_view.dart';
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
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customCard(
                context: context,
                title: 'Internship',
                image: AppImages.internship,
                onPressed: () {
                  Get.to(() => InternshipView());
                },
              ),
              SizedBox(height: 12),
              customCard(
                context: context,
                title: 'Workshop',
                image: AppImages.workshop,
                onPressed: () {
                  Get.to(() => WorkshopView());
                },
              ),
              SizedBox(height: 12),
              customCard(
                context: context,
                title: 'Jobs',
                image: AppImages.job,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customCard({
    required String title,
    required String image,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return CommonCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      color: AppColors.white,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                // style: Theme.of(context).textTheme.tsMedium18,
                style: AppStyles.tsBlackMedium18,
              ),
            ),
            Image.asset(
              image,
              height: 120,
            ),
            SizedBox(height: 8),
            CommonFilledButton(
              label: 'Click here to Apply!',
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ],
    );
  }
}
