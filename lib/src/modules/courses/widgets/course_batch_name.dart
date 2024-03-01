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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "${courseData?.courseName}",
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
                                      "${FormatHelper.categoryFormatter(courseData?.userEnrolled)}"),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Seat Left:",
                        style: AppStyles.tsBlackMedium12,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Text(
                        "${FormatHelper.categoryFormatter(courseData?.maxEnrolments != null ? ((courseData?.maxEnrolments ?? 0) - (courseData?.userEnrolled ?? 0)) : 0)}",
                        style: AppStyles.tsBlackMedium14,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0204,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Course Fee:",
                        style: AppStyles.tsBlackMedium12,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Text(
                        "${FormatHelper.formatNumbers(courseData?.coursePrice, decimal: 0)}",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black,
                            decorationThickness: 3),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Text(
                          "${FormatHelper.formatNumbers(courseData?.discountedPrice, decimal: 0)}"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0204,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0204,
              ),
              if ((courseData?.instructorName?.length ?? 0) > 0) ...{
                Row(
                  children: [
                    Text(
                      "Instructors - ",
                      style: AppStyles.tsBlackMedium14,
                    ),
                    Row(
                      children: courseData!.instructorName!
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final value = entry.value;
                        final isLast =
                            index == courseData!.instructorName!.length - 1;

                        return Text(
                          isLast ? value : '$value, ',
                          style: AppStyles.tsBlackMedium14,
                        );
                      }).toList(),
                    ),
                  ],
                )
              }
            } else ...{
              GestureDetector(
                onTap: () {
                  controller.getCourseOverviewDetails(courseData?.sId ?? '');
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${courseData?.courseName}",
                            style: AppStyles.tsBlackRegular16),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0102,
                            ),
                            Text(
                                "${FormatHelper.categoryFormatter(courseData?.userEnrolled)}"),
                          ],
                        ),
                      ],
                    ),
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