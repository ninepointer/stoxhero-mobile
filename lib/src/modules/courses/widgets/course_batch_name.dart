import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CourseBatchNameWidget extends GetView<CourseController> {
  final InfluencerCourseData? courseData;
  CourseBatchNameWidget(this.courseData);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          children: [
            if (isStudent) ...{
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    child: Image.asset(
                      AppImages.contest,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.0204,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "What is equity ?",
                            style: AppStyles.tsBlackRegular16,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.0204,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StarRatingWidget(
                                starCount: 5,
                                rating: 3.5,
                                color: AppColors.lightGreen,
                                size: 15.0,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.0102,
                                  ),
                                  Text(
                                      "${FormatHelper.categoryFormatter(1000)}"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.0204,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0204,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "By - Rakesh kumar, Rakesh kumar, Rakesh kumar",
                      style: AppStyles.tsBlackRegular14
                          .copyWith(color: AppColors.grey),
                    ),
                  ),
                ],
              )
            } else ...{
              GestureDetector(
                onTap: () {
                  Get.to(() => BatchDetailsView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (courseData?.courseImage == null) ...{
                      Image.asset(
                        AppImages.contest,
                        height: 70,
                        width: 70,
                        //   fit: BoxFit.cover,
                      ),
                    } else ...{
                      Image.network(
                        courseData?.courseImage ?? '',
                        //  fit: BoxFit.fill,
                        height: 70,
                        width: 70,
                      ),
                    },
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.0204,
                    ),
                    Text("${courseData?.courseName}",
                        style: AppStyles.tsBlackRegular16),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0306,
              ),
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.share,
                      size: 15,
                      color: AppColors.lightGreen,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Text(
                      "Share this course",
                      style: AppStyles.tsBlackRegular16
                          .copyWith(color: AppColors.lightGreen),
                    )
                  ],
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}
