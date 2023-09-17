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
                    image: AppImages.internship,
                    onPressed: () {
                      controller.getCareerList('Job');
                      if (controller.careerList.isNotEmpty &&
                          controller.careerList[0].listingType == 'Job') {
                        Get.to(() => InternshipView());
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  customCard(
                    context: context,
                    title: 'Workshop',
                    image: AppImages.workshop,
                    onPressed: () {
                      controller.getCareerList('Workshop');
                      if (controller.careerList.isNotEmpty &&
                          controller.careerList[0].listingType == 'Workshop') {
                        Get.to(() => WorkshopView());
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  customCard(
                    context: context,
                    title: 'Jobs',
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
    required String image,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return CommonCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 160,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  image,
                  height: 140,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.tsMedium18,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Join the StoxHero Derivatives Internship & Workshop for expertise and success',
                    style: Theme.of(context).textTheme.tsGreyRegular14,
                  ),
                ],
              ),
              SizedBox(height: 8),
              CommonFilledButton(
                label: 'Click here to Apply!',
                height: 48,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
