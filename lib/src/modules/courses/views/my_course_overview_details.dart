import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stoxhero/src/app/app.dart';

class MyCoursesOverViewDetailsView extends StatefulWidget {
  MyCoursesOverViewDetailsView();

  @override
  State<MyCoursesOverViewDetailsView> createState() =>
      _MyCoursesOverViewDetailsViewState();
}

class _MyCoursesOverViewDetailsViewState
    extends State<MyCoursesOverViewDetailsView> {
  late CourseController controller;
  int maxLinesToShow = 70;
  int maxWordsToShow = 100;

  bool showFullContent = false;

  bool showFullContentForInstructor = false;
  @override
  void initState() {
    super.initState();
    controller = Get.find<CourseController>();
  }

  int _countWords(String text) {
    return text.split(' ').length;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("About this Course"),
        ),
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.0204),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0306,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkCardBackgroundColor
                          : AppColors.lightCardBackgroundColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.userCourseOverview.value.courseName}",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteMedium18
                            : AppStyles.tsBlackMedium18,
                      ),
                      Text(
                        "Language: ${controller.userCourseOverview.value.courseLanguages}",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular14
                            : AppStyles.tsBlackRegular14,
                      ),
                      (controller.userCourseOverview.value.courseType == "Live")
                          ? Text(
                              "Max Enrolments: ${controller.userCourseOverview.value.maxEnrolments ?? 0}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            )
                          : Container(),
                      Text(
                        "Level: ${controller.userCourseOverview.value.level ?? ''}",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular14
                            : AppStyles.tsBlackRegular14,
                      ),
                      Text(
                        "Course Category: ${isStudent ? controller.userCourseOverview.value.category ?? '' : controller.courseOverview.value.category ?? ''}",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular14
                            : AppStyles.tsBlackRegular14,
                      ),
                      Text(
                        "Type: ${isStudent ? controller.userCourseOverview.value.type ?? '' : controller.courseOverview.value.type ?? ''}",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular14
                            : AppStyles.tsBlackRegular14,
                      ),
                      Text(
                        "Course Type: ${isStudent ? controller.userCourseOverview.value.courseType : controller.courseOverview.value.courseType}",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular14
                            : AppStyles.tsBlackRegular14,
                      ),
                      Text(
                        "Course duration: ${formatDuration(isStudent ? controller.userCourseOverview.value.courseDurationInMinutes ?? 0 : controller.courseOverview.value.courseDurationInMinutes ?? 0)} ",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular14
                            : AppStyles.tsBlackRegular14,
                      ),
                      if (isStudent
                          ? controller.userCourseOverview.value.courseType ==
                              "Live"
                          : controller.courseOverview.value.courseType ==
                              "Live") ...{
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Registration Starts: ${FormatHelper.formatDateTimeToIST(isStudent ? controller.userCourseOverview.value.registrationStartTime : controller.courseOverview.value.registrationStartTime)}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                            Text(
                              "Registration End: ${FormatHelper.formatDateTimeToIST(isStudent ? controller.userCourseOverview.value.registrationEndTime : controller.courseOverview.value.registrationEndTime)}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                            Text(
                              "Course Starts: ${FormatHelper.formatDateTimeToIST(isStudent ? controller.userCourseOverview.value.courseStartTime : controller.courseOverview.value.courseStartTime)}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                            Text(
                              "Course End: ${FormatHelper.formatDateTimeToIST(isStudent ? controller.userCourseOverview.value.courseEndTime : controller.courseOverview.value.courseEndTime)}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                          ],
                        )
                      },
                      isStudent == false
                          ? Text(
                              "Course Price: ${FormatHelper.formatNumbers(isStudent ? controller.userCourseOverview.value.coursePrice ?? 0 : controller.courseOverview.value.coursePrice ?? 0, decimal: 0)}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            )
                          : Container(),
                      isStudent == false
                          ? Text(
                              "Discounted Price:  ${FormatHelper.formatNumbers(isStudent ? controller.userCourseOverview.value.discountedPrice ?? 0 : controller.courseOverview.value.discountedPrice ?? 0, decimal: 0)}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            )
                          : Container(),
                      isStudent == false
                          ? Text(
                              "Commission:  ${controller.courseOverview.value.commissionPercentage ?? 0}%",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            )
                          : Container(),
                    ],
                  ),
                ),
                if (isStudent
                    ? (controller.userCourseOverview.value.courseBenefits
                                ?.length ??
                            0) >
                        0
                    : (controller.courseOverview.value.courseBenefits?.length ??
                            0) >
                        0) ...{
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.0204,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Benefits of course:-",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteMedium14
                            : AppStyles.tsBlackMedium14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.0204,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? AppColors.darkCardBackgroundColor
                            : AppColors.lightCardBackgroundColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...isStudent
                            ? controller
                                .userCourseOverview.value.courseBenefits!
                                .map((value) =>
                                    textItemWidget(value.benefits ?? ''))
                                .toList()
                            : controller.courseOverview.value.courseBenefits!
                                .map((value) =>
                                    textItemWidget(value.benefits ?? ''))
                                .toList(),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.0204,
                        ),
                        if ((_countWords(isStudent
                                    ? controller.userCourseOverview.value
                                        .courseBenefits!
                                        .map((value) => value.benefits ?? '')
                                        .toList()
                                        .join(' ')
                                    : controller
                                        .courseOverview.value.courseBenefits!
                                        .map((value) => value.benefits ?? '')
                                        .toList()
                                        .join(' ')) >
                                maxWordsToShow) ||
                            showFullContent)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showFullContent = !showFullContent;
                              });
                            },
                            child: Text(
                              showFullContent ? "Show less" : "Show more",
                              style: TextStyle(
                                  color: Colors
                                      .blue), // Customize button text color
                            ),
                          ),
                      ],
                    ),
                  ),
                },
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                if (isStudent
                    ? (controller.userCourseOverview.value.courseInstructors
                                ?.length ??
                            0) >
                        0
                    : (controller.courseOverview.value.courseInstructors
                                ?.length ??
                            0) >
                        0) ...{
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Course Instructor:-",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteMedium14
                            : AppStyles.tsBlackMedium14,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? AppColors.darkCardBackgroundColor
                            : AppColors.lightCardBackgroundColor),
                    child: isStudent
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: controller
                                .userCourseOverview.value.courseInstructors!
                                .map(
                                  (value) => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (value.image == null) ...{
                                            ClipRRect(
                                              child: Image.asset(
                                                AppImages.lightAppLogo,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.148,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.148,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          } else ...{
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.network(
                                                value.image ?? '',
                                                //  fit: BoxFit.fill,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.148,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.148,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context,
                                                    exception, stackTrace) {
                                                  return Image.asset(
                                                    AppImages.lightAppLogo,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.148,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.148,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            )
                                          },
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0306,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${value.id?.firstName ?? ''} ${value.id?.lastName ?? ''}",
                                                  style: Get.isDarkMode
                                                      ? AppStyles
                                                          .tsWhiteMedium16
                                                      : AppStyles
                                                          .tsBlackMedium16,
                                                ),
                                                Column(
                                                  children: [
                                                    // Other widgets if any

                                                    if ((value.about?.length ??
                                                            0) >
                                                        100) // Add condition to display "Show more" button
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              showFullContentForInstructor
                                                                  ? value.about ??
                                                                      ''
                                                                  : '${value.about?.substring(0, 100)}...', // Display truncated or full text
                                                            ),
                                                          ),
                                                          if ((value.about
                                                                      ?.length ??
                                                                  0) >
                                                              100) // Add condition to display "Show more" button
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  showFullContentForInstructor =
                                                                      !showFullContentForInstructor; // Toggle showFullContent flag
                                                                });
                                                              },
                                                              child: Text(
                                                                showFullContentForInstructor
                                                                    ? "Show less"
                                                                    : "Show more",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    if ((value.about?.length ??
                                                            0) <=
                                                        100) // If text length is less than or equal to 100, display full text
                                                      Text("${value.about}"),
                                                  ],
                                                ),
                                                //    Text("${value.about}"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.0204,
                                      )
                                    ],
                                  ),
                                )
                                .toList(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: controller
                                .courseOverview.value.courseInstructors!
                                .map(
                                  (value) => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          if (value.image == null) ...{
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.asset(
                                                  AppImages.lightAppLogo,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.148,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.148,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          } else ...{
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.network(
                                                  value.image ?? '',
                                                  fit: BoxFit.fill,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.148,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.148,
                                                  errorBuilder: (context,
                                                      exception, stackTrace) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.asset(
                                                    AppImages.lightAppLogo,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.148,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.148,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              }),
                                            )
                                          },
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0204,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${value.id?.firstName ?? ''} ${value.id?.lastName ?? ''}",
                                                  style: Get.isDarkMode
                                                      ? AppStyles
                                                          .tsWhiteMedium16
                                                      : AppStyles
                                                          .tsBlackMedium16,
                                                ),
                                                Column(
                                                  children: [
                                                    // Other widgets if any

                                                    if ((value.about?.length ??
                                                            0) >
                                                        100) // Add condition to display "Show more" button
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              showFullContentForInstructor
                                                                  ? value.about ??
                                                                      ''
                                                                  : '${value.about?.substring(0, 100)}...', // Display truncated or full text
                                                            ),
                                                          ),
                                                          if ((value.about
                                                                      ?.length ??
                                                                  0) >
                                                              100) // Add condition to display "Show more" button
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  showFullContentForInstructor =
                                                                      !showFullContentForInstructor; // Toggle showFullContent flag
                                                                });
                                                              },
                                                              child: Text(
                                                                showFullContentForInstructor
                                                                    ? "Show less"
                                                                    : "Show more",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    if ((value.about?.length ??
                                                            0) <=
                                                        100) // If text length is less than or equal to 100, display full text
                                                      Text("${value.about}"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.0204,
                                      )
                                    ],
                                  ),
                                )
                                .toList()),
                  ),
                },
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Course description:-",
                      style: Get.isDarkMode
                          ? AppStyles.tsWhiteMedium14
                          : AppStyles.tsBlackMedium14,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkCardBackgroundColor
                          : AppColors.lightCardBackgroundColor),
                  child: Html(
                    data:
                        """${isStudent ? controller.userCourseOverview.value.courseDescription : controller.courseOverview.value.courseDescription}""",
                    style: {
                      "body": Style(
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkCardBackgroundColor
                            : AppColors.lightCardBackgroundColor,
                        color:
                            Get.isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      "p": Style(
                        whiteSpace: WhiteSpace.pre,
                        padding: HtmlPaddings.zero,
                        lineHeight: LineHeight.number(1),
                        margin: Margins.zero,
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkCardBackgroundColor
                            : AppColors.lightCardBackgroundColor,
                        color:
                            Get.isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      "div": Style(
                        whiteSpace: WhiteSpace.pre,
                        padding: HtmlPaddings.zero,
                        lineHeight: LineHeight.number(1),
                        margin: Margins.zero,
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkCardBackgroundColor
                            : AppColors.lightCardBackgroundColor,
                        color:
                            Get.isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      "span": Style(
                        whiteSpace: WhiteSpace.pre,
                        padding: HtmlPaddings.zero,
                        lineHeight: LineHeight.number(1),
                        margin: Margins.zero,
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkCardBackgroundColor
                            : AppColors.lightCardBackgroundColor,
                        color:
                            Get.isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      "a": Style(
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkCardBackgroundColor
                            : AppColors.lightCardBackgroundColor,
                      ),
                      "b": Style(
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkCardBackgroundColor
                            : AppColors.lightCardBackgroundColor,
                        color:
                            Get.isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      "strong": Style(
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkCardBackgroundColor
                            : AppColors.lightCardBackgroundColor,
                        color:
                            Get.isDarkMode ? AppColors.white : AppColors.black,
                      ),
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "FAQ\'s:-",
                      style: Get.isDarkMode
                          ? AppStyles.tsWhiteMedium14
                          : AppStyles.tsBlackMedium14,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                if (isStudent) ...{
                  for (int i = 0;
                      i <
                          (controller.userCourseOverview.value.faqs?.length ??
                              0);
                      i++)
                    CourseFAQSWidget(
                        i, controller.userCourseOverview.value.faqs?[i]),
                } else ...{
                  for (int i = 0;
                      i < (controller.courseOverview.value.faqs?.length ?? 0);
                      i++)
                    CourseFAQSWidget(
                        i, controller.courseOverview.value.faqs?[i]),
                },
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                if (isStudent == false) ...{
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Changes:-",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteMedium14
                            : AppStyles.tsBlackMedium14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.0204,
                  ),
                  if (((controller
                              .courseOverview.value.suggestChanges?.length ??
                          0) >
                      0)) ...{
                    Row(
                      children: [
                        Row(
                          children: controller
                              .courseOverview.value.suggestChanges!
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final value = entry.value;

                            return Text(
                              value,
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  },
                },
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0408,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textItemWidget(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Icon(
              Icons.circle,
              size: 8,
              color: AppColors.grey,
            ),
          ],
        ),
        SizedBox(
          width: 4,
        ),
        Flexible(
          child: Text(
            showFullContent ? _truncateText(text) : text,
            maxLines: showFullContent ? maxLinesToShow : null,
            overflow: TextOverflow.ellipsis,
            style: Get.isDarkMode
                ? AppStyles.tsWhiteRegular14
                : AppStyles.tsBlackRegular14,
          ),
        ),
      ],
    );
  }

  String _truncateText(String text) {
    return text.length > 1000 ? text.substring(0, 1000) + "..." : text;
  }
}
