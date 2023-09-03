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
                    'loremEu nisi ut aute anim est. Ea nulla dolore enim ea enim proident minim cupidatat fugiat. ',
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
