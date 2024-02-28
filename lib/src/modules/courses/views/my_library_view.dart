import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../app/app.dart';

class MyLibraryView extends StatefulWidget {
  const MyLibraryView({super.key});

  @override
  State<MyLibraryView> createState() => _MyLibraryViewState();
}

class _MyLibraryViewState extends State<MyLibraryView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => CourseVideoView());
        Get.to(() => CourseAllTopicView());
      },
      child: Container(
        width: double.infinity,
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("What is equity?", style: AppStyles.tsBlackRegular16),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0306,
              ),
              // for instructor

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "By - Rakesh kumar",
                    style: AppStyles.tsBlackRegular14
                        .copyWith(color: AppColors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0306,
              ),
              LinearPercentIndicator(
                padding: EdgeInsets.zero,
                lineHeight: MediaQuery.of(context).size.width * 0.0156,
                percent: 0.3,
                progressColor: AppColors.lightGreen,
                backgroundColor: AppColors.grey.withOpacity(0.3),
                barRadius: Radius.circular(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
