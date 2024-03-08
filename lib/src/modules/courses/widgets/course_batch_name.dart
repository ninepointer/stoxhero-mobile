import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CourseBatchNameWidget extends GetView<CourseController> {
  final InfluencerCourseData? courseData;

  CourseBatchNameWidget(this.courseData);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Get.isDarkMode
          ? AppColors.darkCardBackgroundColor
          : AppColors.lightCardBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          children: [
            if (isStudent) ...{
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (courseData?.courseImage == null) ...{
                    Image.asset(
                      AppImages.lightAppLogo,
                      height: MediaQuery.of(context).size.width * 0.178,
                      width: MediaQuery.of(context).size.width * 0.178,
                      fit: BoxFit.cover,
                    ),
                  } else ...{
                    Image.network(
                      courseData?.courseImage ?? '',
                      height: MediaQuery.of(context).size.width * 0.178,
                      width: MediaQuery.of(context).size.width * 0.178,
                      fit: BoxFit.cover,
                      errorBuilder: (context, exception, stackTrace) {
                        return Image.asset(
                          AppImages.lightAppName,
                          height: MediaQuery.of(context).size.width * 0.178,
                          width: MediaQuery.of(context).size.width * 0.178,
                        );
                      },
                    ),
                  },
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.0306,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "${courseData?.courseName}",
                            style: Get.isDarkMode
                                ? AppStyles.tsWhiteMedium18
                                : AppStyles.tsBlackMedium18,
                          ),
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.width * 0.0204,
                        // ),
                        if ((courseData?.instructorName?.length ?? 0) > 0) ...{
                          Row(
                            children: [
                              Row(
                                children: courseData!.instructorName!
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key;
                                  final value = entry.value;
                                  final isLast = index ==
                                      courseData!.instructorName!.length - 1;

                                  return Text(
                                    isLast ? value : '$value, ',
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
                                  );
                                }).toList(),
                              ),
                            ],
                          )
                        },
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.0204,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StarRatingWidget(
                                starCount: 5,
                                rating:
                                    courseData?.averageRating?.toDouble() ?? 0,
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
                        "Seats Left:",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteMedium12
                            : AppStyles.tsBlackMedium12,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Text(
                        "${FormatHelper.categoryFormatter(courseData?.maxEnrolments != null ? ((courseData?.maxEnrolments ?? 0) - (courseData?.userEnrolled ?? 0)) : 0)}",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteMedium12
                            : AppStyles.tsBlackMedium12,
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
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteMedium12
                            : AppStyles.tsBlackMedium12,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      if ((courseData?.coursePrice ?? 0) !=
                          (courseData?.discountedPrice ?? 0)) ...{
                        Text(
                          "${FormatHelper.formatNumbers(courseData?.coursePrice, decimal: 0)}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Get.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              decorationThickness: 3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0102,
                        ),
                        Text(
                            "${FormatHelper.formatNumbers(courseData?.discountedPrice, decimal: 0)}"),
                      } else ...{
                        Text(
                            "${FormatHelper.formatNumbers(courseData?.coursePrice, decimal: 0)}"),
                      },
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0204,
                      )
                    ],
                  ),
                ],
              ),
            } else ...{
              GestureDetector(
                onTap: () {
                  controller.getCourseOverviewDetails(courseData?.sId ?? '');
                  Get.to(() => BatchDetailsView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (courseData?.courseImage == null) ...{
                      Image.asset(
                        AppImages.lightAppLogo,
                        height: MediaQuery.of(context).size.width * 0.178,
                        width: MediaQuery.of(context).size.width * 0.178,
                        fit: BoxFit.cover,
                      ),
                    } else ...{
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          courseData?.courseImage ?? '',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width * 0.178,
                          width: MediaQuery.of(context).size.width * 0.178,
                          errorBuilder: (context, exception, stackTrace) {
                            return Image.asset(
                              AppImages.lightAppLogo,
                              height: MediaQuery.of(context).size.width * 0.178,
                              width: MediaQuery.of(context).size.width * 0.178,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      )
                    },
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "${courseData?.courseName}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteMedium18
                                  : AppStyles.tsBlackMedium18,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 15,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0102,
                              ),
                              Text(
                                  "${FormatHelper.categoryFormatter(courseData?.userEnrolled)}"),
                            ],
                          ),
                        ],
                      ),
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
