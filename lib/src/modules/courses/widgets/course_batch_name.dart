import 'package:flutter/material.dart';
import '../../../app/app.dart';
import 'package:flutter_share/flutter_share.dart';

class CourseBatchNameWidget extends GetView<CourseController> {
  final InfluencerCourseData? courseData;

  CourseBatchNameWidget(this.courseData);

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Course share',
        text: 'Share this course',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        AppImages.lightAppLogo,
                        height: MediaQuery.of(context).size.width * 0.225,
                        width: MediaQuery.of(context).size.width * 0.450,
                        //fit: BoxFit.cover,
                      ),
                    )
                  } else ...{
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        courseData?.courseImage ?? '',
                        height: MediaQuery.of(context).size.width * 0.225,
                        width: MediaQuery.of(context).size.width * 0.450,
                        errorBuilder: (context, exception, stackTrace) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              AppImages.lightAppName,
                              height: MediaQuery.of(context).size.width * 0.225,
                              width: MediaQuery.of(context).size.width * 0.450,
                            ),
                          );
                        },
                      ),
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
                                ? AppStyles.tsWhiteMedium16
                                : AppStyles.tsBlackMedium16,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.0102,
                        ),
                        Row(
                          children: [
                            StarRatingWidget(
                              starCount: 5,
                              rating: (courseData?.averageRating?.toDouble() ??
                                          0) >
                                      0
                                  ? courseData?.averageRating?.toDouble() ?? 0
                                  : 4,
                              color: AppColors.lightGreen,
                              size: 15.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0102,
                            ),
                            Text(
                                "(${((courseData?.averageRating ?? 0) > 0) ? courseData?.averageRating ?? 0 : 4})")
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.0102,
                        ),
                        Row(
                          children: [
                            Text(
                              "For ${courseData?.level ?? ''}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsGreyRegular14,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0102,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if ((courseData?.instructorName?.length ?? 0) > 0) ...{
                    Row(
                      children: [
                        Text(
                          "By: ",
                          style: Get.isDarkMode
                              ? AppStyles.tsWhiteMedium12
                              : AppStyles.tsBlackMedium12,
                        ),
                        Wrap(
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
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  },
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0102,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${courseData?.courseDurationInMinutes ?? ''} Min",
                            style: Get.isDarkMode
                                ? AppStyles.tsWhiteRegular12
                                : AppStyles.tsBlackRegular12,
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0204,
                      ),
                      Icon(
                        Icons.circle,
                        size: 10,
                        color:
                            Get.isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0204,
                      ),
                      Row(
                        children: [
                          Text(
                            "${courseData?.lectures ?? ''} Lectures",
                            style: Get.isDarkMode
                                ? AppStyles.tsWhiteRegular12
                                : AppStyles.tsBlackRegular12,
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Price:",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteMedium12
                            : AppStyles.tsBlackMedium12,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      (courseData?.coursePrice ?? 0) !=
                              (courseData?.discountedPrice ?? 0)
                          ? Row(
                              children: [
                                Text(
                                  "${FormatHelper.formatNumbers(courseData?.coursePrice, decimal: 0)}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: AppColors.lightGreen,
                                      decorationThickness: 3,
                                      fontSize: 18,
                                      color: AppColors.lightGreen),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0102,
                                ),
                                Text(
                                  "${FormatHelper.formatNumbers(courseData?.discountedPrice, decimal: 0)}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors
                                          .lightGreen), // Adjust the font size as needed
                                ),
                              ],
                            )
                          : Text(
                              "${FormatHelper.formatNumbers(courseData?.coursePrice, decimal: 0)}",
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.lightGreen),
                            ),
                    ],
                  ),
                ],
              ),
            } else ...{
              GestureDetector(
                onTap: () {
                  controller.getCourseOverviewDetails(courseData?.sId ?? '');
                  Get.to(() => BatchDetailsView(courseData));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (courseData?.courseImage == null) ...{
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          AppImages.lightAppLogo,

                          height: MediaQuery.of(context).size.width * 0.225,
                          width: MediaQuery.of(context).size.width * 0.450,
                          // fit: BoxFit.cover,
                        ),
                      )
                    } else ...{
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          courseData?.courseImage ?? '',
                          height: MediaQuery.of(context).size.width * 0.225,
                          width: MediaQuery.of(context).size.width * 0.450,
                          errorBuilder: (context, exception, stackTrace) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                AppImages.lightAppLogo,
                                height:
                                    MediaQuery.of(context).size.width * 0.225,
                                width:
                                    MediaQuery.of(context).size.width * 0.450,
                              ),
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
                                  ? AppStyles.tsWhiteMedium16
                                  : AppStyles.tsBlackMedium16,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Row(
                              //   children: [
                              //     Icon(
                              //       Icons.people,
                              //       size: 15,
                              //     ),
                              //     SizedBox(
                              //       width: MediaQuery.of(context).size.width *
                              //           0.0102,
                              //     ),
                              //     Text(
                              //         "${FormatHelper.categoryFormatter(courseData?.userEnrolled)}"),
                              //   ],
                              // ),
                              // Icon(
                              //   Icons.circle,
                              //   size: 10,
                              //   color: Get.isDarkMode
                              //       ? AppColors.white
                              //       : AppColors.black,
                              // ),
                              Row(
                                children: [
                                  Text(
                                    "${courseData?.courseDurationInMinutes ?? ''} Min",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular12
                                        : AppStyles.tsBlackRegular12,
                                  )
                                ],
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0204,
                              ),
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: Get.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0204,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${courseData?.lectures ?? ''} Lectures",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular12
                                        : AppStyles.tsBlackRegular12,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "For ${courseData?.level ?? ''}",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteMedium12
                                        : AppStyles.tsGreyMedium12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0102,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      share();
                    },
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
                  ),
                  Row(
                    children: [
                      Text(
                        "Price:",
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
                              decorationColor: AppColors.lightGreen,
                              fontSize: 18,
                              color: AppColors.lightGreen,
                              decorationThickness: 3),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0102,
                        ),
                        Text(
                          "${FormatHelper.formatNumbers(courseData?.discountedPrice, decimal: 0)}",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.lightGreen,
                          ),
                        ),
                      } else ...{
                        Text(
                          "${FormatHelper.formatNumbers(courseData?.coursePrice, decimal: 0)}",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.lightGreen,
                          ),
                        ),
                      },
                    ],
                  ),
                ],
              )
            }
          ],
        ),
      ),
    );
  }
}
