import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class CareerView extends GetView<CareerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Careers'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  customCard(
                    context: context,
                    title: 'Internship',
                    buttonLabel: 'View Opening',
                    image: AppImages.internship,
                    onPressed: () {
                      controller.getCareerList('Job');
                      Get.to(() => InternshipView());
                    },
                  ),
                  SizedBox(height: 12),
                  customCard(
                    context: context,
                    title: 'Workshop',
                    buttonLabel: 'View Opening',
                    image: AppImages.workshop,
                    onPressed: () {
                      controller.getCareerList('Workshop');
                      Get.to(() => WorkshopView());
                    },
                  ),
                  SizedBox(height: 12),
                  customCard(
                    context: context,
                    title: 'Jobs',
                    buttonLabel: 'View Opening',
                    image: AppImages.job,
                    onPressed: () {},
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customCard({
    required String title,
    required String buttonLabel,
    required String image,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return CommonCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
              margin: EdgeInsets.all(16).copyWith(
                bottom: 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.asset(
                image,
                height: 120,
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.tsMedium18,
                    // style: AppStyles.tsBlackMedium18,
                  ),
                  Text(
                    'Join the StoxHero Derivatives Internship & Workshop for expertise and success',
                    style: Theme.of(context).textTheme.tsGreyRegular14,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16).copyWith(
                top: 0,
              ),
              alignment: Alignment.bottomRight,
              child: CommonFilledButton(
                label: buttonLabel,
                height: 42,
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
