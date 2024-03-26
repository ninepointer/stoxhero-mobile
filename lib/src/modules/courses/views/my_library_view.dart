import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../app/app.dart';
import 'package:url_launcher/url_launcher.dart';

class MyLibraryView extends StatefulWidget {
  final List<UserMyCoursesData>? data;
  final List<UserMyCoursesData>? workshopData;
  const MyLibraryView(this.data, {this.workshopData});

  @override
  State<MyLibraryView> createState() => _MyLibraryViewState();
}

class _MyLibraryViewState extends State<MyLibraryView> {
  late CourseController controller;

  void initState() {
    super.initState();
    controller = Get.find<CourseController>();
    controller.getUserMyCoursesDetails();
    //controller.getUserMyCoursesDetails();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        controller.getUserMyCoursesDetails();
        return Future.value();
      },
      child: Obx(
        () => ListView(
          children: [
            if ((widget.workshopData == null || widget.workshopData!.isEmpty) &&
                (widget.data == null || widget.data!.isEmpty))
              NoDataFound()
            else ...{
              if (widget.workshopData != null &&
                  widget.workshopData!.isNotEmpty)
                _buildSection("Workshops", widget.workshopData),
              if (widget.data != null && widget.data!.isNotEmpty)
                _buildCourseSection("Courses", widget.data),
            }
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<UserMyCoursesData>? courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: courses?.length,
          itemBuilder: (context, index) {
            //   return _buildCourseItem(courses![index]);
            var courseData = courses![index];
            DateTime courseStartTime =
                DateTime.parse((courseData.courseStartTime ?? ''));
            DateTime courseEndTime =
                DateTime.parse((courseData.courseEndTime ?? ''));
            return GestureDetector(
                onTap: () async {
                  if (DateTime.now().isBefore(courseStartTime)) {
                    SnackbarHelper.showSnackbar(
                      "Workshop will start on ${FormatHelper.formatDateTimeOnlyToIST(courseData.courseStartTime)}",
                    );
                  }
                  if (DateTime.now().isAfter(courseEndTime)) {
                    SnackbarHelper.showSnackbar(
                      "The workshop has ended. The recorded content will be made available soon",
                    );
                  } else {
                    final googleMeetUrl = '${courseData.meetLink ?? ''}';

                    // Check if the URL can be launched
                    if (await canLaunch(googleMeetUrl)) {
                      // Launch the URL
                      await launch(googleMeetUrl);
                    } else {
                      // Handle error if URL cannot be launched
                      SnackbarHelper.showSnackbar(
                          'Could not launch Google Meet');
                    }
                  }
                },
                child: Container(
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
                                    height: MediaQuery.of(context).size.width *
                                        0.225,
                                    width: MediaQuery.of(context).size.width *
                                        0.450,
                                    //fit: BoxFit.cover,
                                  ),
                                )
                              } else ...{
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    courseData?.courseImage ?? '',
                                    height: MediaQuery.of(context).size.width *
                                        0.225,
                                    width: MediaQuery.of(context).size.width *
                                        0.450,
                                    errorBuilder:
                                        (context, exception, stackTrace) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          AppImages.lightAppName,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.225,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.450,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              },
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0306,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "${courseData.courseName}"
                                                .capitalizeFirst ??
                                            '',
                                        style: Get.isDarkMode
                                            ? AppStyles.tsWhiteMedium16
                                            : AppStyles.tsBlackMedium16,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.0102,
                                    ),
                                    Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${courseData?.courseDuration ?? ''} Min",
                                              style: Get.isDarkMode
                                                  ? AppStyles.tsWhiteRegular12
                                                  : AppStyles.tsBlackRegular12,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.0102,
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
                            children: [
                              if ((courseData?.instructorName?.length ?? 0) >
                                  0) ...{
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
                                        final isLast = index ==
                                            courseData!.instructorName!.length -
                                                1;

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
                              ////dg/g//gd/g/g
                              Row(
                                children: [
                                  Text(
                                    "Workshop Starts : ",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteMedium12
                                        : AppStyles.tsBlackMedium12,
                                  ),
                                  Text(
                                    "${FormatHelper.formatDateTimeOnlyToIST(courseData?.courseStartTime ?? "")}",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.0102,
                                  ),
                                  if (courseData?.discountedPrice == 0) ...{
                                    Text(
                                      "Free",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.lightGreen),
                                    ),
                                  } else ...{
                                    (courseData?.coursePrice ?? 0) !=
                                            (courseData?.discountedPrice ?? 0)
                                        ? Row(
                                            children: [
                                              Text(
                                                "${FormatHelper.formatNumbers(courseData?.coursePrice, decimal: 0)}",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        AppColors.lightGreen,
                                                    decorationThickness: 3,
                                                    fontSize: 18,
                                                    color:
                                                        AppColors.lightGreen),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
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
                                                fontSize: 18,
                                                color: AppColors.lightGreen),
                                          ),
                                  }
                                ],
                              ),
                            ],
                          ),
                        }
                      ],
                    ),
                  ),
                ));
          },
        ),
      ],
    );
  }

  Widget _buildCourseSection(String title, List<UserMyCoursesData>? courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: courses?.length,
          itemBuilder: (context, index) {
            //   return _buildCourseItem(courses![index]);
            var data = courses![index];
            return GestureDetector(
              onTap: () {
                if (data.lactures != 0) {
                  Get.to(() => CourseVideoView(data: data));
                } else {
                  SnackbarHelper.showSnackbar(
                      "No lectures are available for this course.");
                }
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 8, top: 8),
                color: Get.isDarkMode
                    ? AppColors.darkCardBackgroundColor
                    : AppColors.lightCardBackgroundColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data?.courseImage == null) ...{
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                AppImages.lightAppLogo,
                                height:
                                    MediaQuery.of(context).size.width * 0.225,
                                width:
                                    MediaQuery.of(context).size.width * 0.450,
                              ),
                            )
                          } else ...{
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                data?.courseImage ?? '',
                                height:
                                    MediaQuery.of(context).size.width * 0.225,
                                width:
                                    MediaQuery.of(context).size.width * 0.450,
                                errorBuilder: (context, exception, stackTrace) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      AppImages.lightAppName,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.225,
                                      width: MediaQuery.of(context).size.width *
                                          0.450,
                                    ),
                                  );
                                },
                              ),
                            )
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
                                    "${data?.courseName}".capitalizeFirst ?? '',
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteMedium16
                                        : AppStyles.tsBlackMedium16,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      0.0102,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        StarRatingWidget(
                                          starCount: 5,
                                          rating: (data?.averageRating
                                                          ?.toDouble() ??
                                                      0) >
                                                  0
                                              ? data?.averageRating
                                                      ?.toDouble() ??
                                                  0
                                              : 4,
                                          color: AppColors.lightGreen,
                                          size: 15.0,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0102,
                                        ),
                                        Text(
                                            "(${((data?.averageRating ?? 0) > 0) ? data?.averageRating ?? 0 : 4})")
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      0.0102,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "For ${data?.level ?? ''}",
                                      style: Get.isDarkMode
                                          ? AppStyles.tsWhiteRegular14
                                          : AppStyles.tsGreyRegular14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Row(
                        children: [
                          if ((data?.instructorName?.length ?? 0) > 0) ...{
                            Row(
                              children: [
                                Text(
                                  "By: ",
                                  style: Get.isDarkMode
                                      ? AppStyles.tsWhiteMedium12
                                      : AppStyles.tsBlackMedium12,
                                ),
                                Wrap(
                                  children: data!.instructorName!
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final index = entry.key;
                                    final value = entry.value;
                                    final isLast = index ==
                                        data.instructorName!.length - 1;

                                    return Text(
                                      isLast ? value : '$value,',
                                      style: Get.isDarkMode
                                          ? AppStyles.tsWhiteRegular14
                                          : AppStyles.tsBlackRegular14,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${data?.courseDuration ?? ''} Min",
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
                                    "${data?.lactures ?? ''} Lectures",
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
                                width:
                                    MediaQuery.of(context).size.width * 0.0102,
                              ),
                              if ((data?.coursePrice ?? 0) !=
                                  (data?.discountedPrice ?? 0)) ...{
                                Text(
                                  "${FormatHelper.formatNumbers(data?.coursePrice, decimal: 0)}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: AppColors.lightGreen,
                                      fontSize: 18,
                                      color: AppColors.lightGreen,
                                      decorationThickness: 3),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0102,
                                ),
                                Text(
                                  "${FormatHelper.formatNumbers(data?.discountedPrice, decimal: 0)}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.lightGreen),
                                ),
                              } else ...{
                                Text(
                                  "${FormatHelper.formatNumbers(data?.coursePrice, decimal: 0)}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.lightGreen),
                                ),
                              },
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0204,
                              )
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.width * 0.0102,
                      // ),
                      // LinearPercentIndicator(
                      //   padding: EdgeInsets.zero,
                      //   lineHeight: MediaQuery.of(context).size.width * 0.0156,
                      //   percent: (data?.coursePrgress?.toDouble() ?? 0.0),
                      //   progressColor: AppColors.lightGreen,
                      //   backgroundColor: AppColors.grey.withOpacity(0.3),
                      //   barRadius: Radius.circular(10),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
  // Widget _buildCourseItem(UserMyCoursesData data) {
  //   return
  // }
}
