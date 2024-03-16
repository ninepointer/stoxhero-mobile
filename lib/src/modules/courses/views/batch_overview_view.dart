import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class BatchOverViewDetailsView extends StatefulWidget {
  const BatchOverViewDetailsView({super.key});

  @override
  State<BatchOverViewDetailsView> createState() =>
      _BatchOverViewDetailsViewState();
}

class _BatchOverViewDetailsViewState extends State<BatchOverViewDetailsView> {
  late CachedVideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;
  late CourseController controller;
  int maxLinesToShow = 70;
  int maxWordsToShow = 100;

  bool showFullContent = false;

  bool showFullContentForInstructor = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CourseController>();

    _controller = CachedVideoPlayerController.network(
        '${isStudent ? controller.userCourseOverview.value.salesVideo : controller.courseOverview.value.salesVideo}')
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _controller,
    );
  }

  int _countWords(String text) {
    return text.split(' ').length;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.0306,
                  ),
                  _customVideoPlayerController
                          .videoPlayerController.value.isInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CustomVideoPlayer(
                                customVideoPlayerController:
                                    _customVideoPlayerController),
                          ),
                        )
                      : AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Center(child: CircularProgressIndicator())),
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
                          "${isStudent ? controller.userCourseOverview.value.courseName : controller.courseOverview.value.courseName}",
                          style: Get.isDarkMode
                              ? AppStyles.tsWhiteMedium18
                              : AppStyles.tsBlackMedium18,
                        ),
                        Row(
                          children: [
                            StarRatingWidget(
                              starCount: 5,
                              rating: (controller.userCourseOverview.value
                                              .averageRating
                                              ?.toDouble() ??
                                          0.0) >
                                      0
                                  ? controller.userCourseOverview.value
                                          .averageRating
                                          ?.toDouble() ??
                                      0.0
                                  : 4.0,
                              color: AppColors.lightGreen,
                              size: 15.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0102,
                            ),
                            Text(
                              "(${((controller.userCourseOverview.value.averageRating?.toDouble() ?? 0.0) > 0) ? controller.userCourseOverview.value.averageRating?.toDouble() ?? 0.0 : 4.0})",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            )
                          ],
                        ),
                        if ((isStudent
                                ? controller.userCourseOverview.value
                                        .courseInstructors?.length ??
                                    0
                                : controller.courseOverview.value
                                        .courseInstructors?.length ??
                                    0) >
                            0) ...{
                          Row(
                            children: [
                              Text(
                                "Created by: ",
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteMedium12
                                    : AppStyles.tsBlackMedium12,
                              ),
                              Row(
                                children: (isStudent
                                        ? controller.userCourseOverview.value
                                            .courseInstructors
                                        : controller.courseOverview.value
                                            .courseInstructors)!
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key;
                                  final value =
                                      "${entry.value.id?.firstName} ${entry.value.id?.lastName}";
                                  final isLast = index ==
                                      (isStudent
                                          ? controller.userCourseOverview.value
                                                  .courseInstructors?.length ??
                                              0 - 1
                                          : controller.courseOverview.value
                                                  .courseInstructors?.length ??
                                              0 - 1);

                                  return Text(
                                    isLast ? value : '$value, ',
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14.copyWith(
                                            color: AppColors.lightGreen)
                                        : AppStyles.tsBlackRegular14.copyWith(
                                            color: AppColors.lightGreen),
                                  );
                                }).toList(),
                              ),
                            ],
                          )
                        },
                        Row(
                          children: [
                            Text(
                              "Language: ",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteMedium12
                                  : AppStyles.tsBlackMedium12,
                            ),
                            Text(
                              "${isStudent ? controller.userCourseOverview.value.courseLanguages : controller.courseOverview.value.courseLanguages}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                          ],
                        ),
                        (controller.userCourseOverview.value.courseType ==
                                    "Live" ||
                                controller.courseOverview.value.courseType ==
                                    "Live")
                            ? Row(
                                children: [
                                  Text(
                                    "Max Enrolments: ",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteMedium12
                                        : AppStyles.tsBlackMedium12,
                                  ),
                                  Text(
                                    "${isStudent ? controller.userCourseOverview.value.maxEnrolments ?? 0 : controller.courseOverview.value.maxEnrolments ?? 0}",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
                                  ),
                                ],
                              )
                            : Container(),
                        Row(
                          children: [
                            Text(
                              "Level: ",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteMedium12
                                  : AppStyles.tsBlackMedium12,
                            ),
                            Text(
                              "${isStudent ? controller.userCourseOverview.value.level ?? "" : controller.courseOverview.value.level ?? ''}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Course Category: ',
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteMedium12
                                    : AppStyles.tsBlackMedium12),
                            Text(
                              "${isStudent ? controller.userCourseOverview.value.category ?? '' : controller.courseOverview.value.category ?? ''}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Type: ",
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteMedium12
                                    : AppStyles.tsBlackMedium12),
                            Text(
                              "${isStudent ? controller.userCourseOverview.value.type ?? '' : controller.courseOverview.value.type ?? ''}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Course Type: ',
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteMedium12
                                    : AppStyles.tsBlackMedium12),
                            Text(
                              "${isStudent ? controller.userCourseOverview.value.courseType : controller.courseOverview.value.courseType}",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Course duration:',
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteMedium12
                                    : AppStyles.tsBlackMedium12),
                            Text(
                              " ${formatDuration(isStudent ? controller.userCourseOverview.value.courseDurationInMinutes ?? 0 : controller.courseOverview.value.courseDurationInMinutes ?? 0)} ",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            ),
                          ],
                        ),
                        if (isStudent
                            ? controller.userCourseOverview.value.courseType ==
                                "Live"
                            : controller.courseOverview.value.courseType ==
                                "Live") ...{
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Registration Starts: ',
                                      style: Get.isDarkMode
                                          ? AppStyles.tsWhiteMedium12
                                          : AppStyles.tsBlackMedium12),
                                  Text(
                                    "${FormatHelper.formatDateTimeToIST(isStudent ? controller.userCourseOverview.value.registrationStartTime : controller.courseOverview.value.registrationStartTime)}",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Registration End: ",
                                      style: Get.isDarkMode
                                          ? AppStyles.tsWhiteMedium12
                                          : AppStyles.tsBlackMedium12),
                                  Text(
                                    "${FormatHelper.formatDateTimeToIST(isStudent ? controller.userCourseOverview.value.registrationEndTime : controller.courseOverview.value.registrationEndTime)}",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Course Starts: ',
                                      style: Get.isDarkMode
                                          ? AppStyles.tsWhiteMedium12
                                          : AppStyles.tsBlackMedium12),
                                  Text(
                                    "${FormatHelper.formatDateTimeToIST(isStudent ? controller.userCourseOverview.value.courseStartTime : controller.courseOverview.value.courseStartTime)}",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Course End: ",
                                      style: Get.isDarkMode
                                          ? AppStyles.tsWhiteMedium12
                                          : AppStyles.tsBlackMedium12),
                                  Text(
                                    "${FormatHelper.formatDateTimeToIST(isStudent ? controller.userCourseOverview.value.courseEndTime : controller.courseOverview.value.courseEndTime)}",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
                                  ),
                                ],
                              ),
                            ],
                          )
                        },
                        isStudent == false
                            ? Row(
                                children: [
                                  Text('Course Price: ',
                                      style: Get.isDarkMode
                                          ? AppStyles.tsWhiteMedium12
                                          : AppStyles.tsBlackMedium12),
                                  Text(
                                    "${FormatHelper.formatNumbers(isStudent ? controller.userCourseOverview.value.coursePrice ?? 0 : controller.courseOverview.value.coursePrice ?? 0, decimal: 0)}",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
                                  ),
                                ],
                              )
                            : Container(),
                        isStudent == false
                            ? Row(
                                children: [
                                  Text(
                                    'Discounted Price:  ',
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteMedium12
                                        : AppStyles.tsBlackMedium12,
                                  ),
                                  Text(
                                    "${FormatHelper.formatNumbers(isStudent ? controller.userCourseOverview.value.discountedPrice ?? 0 : controller.courseOverview.value.discountedPrice ?? 0, decimal: 0)}",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
                                  ),
                                ],
                              )
                            : Container(),
                        isStudent == false
                            ? Row(
                                children: [
                                  Text(
                                    'Commission:  ',
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteMedium12
                                        : AppStyles.tsBlackMedium12,
                                  ),
                                  Text(
                                    "${controller.courseOverview.value.commissionPercentage ?? 0}%",
                                    style: Get.isDarkMode
                                        ? AppStyles.tsWhiteRegular14
                                        : AppStyles.tsBlackRegular14,
                                  ),
                                ],
                              )
                            : Container(),
                        Row(
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Course Overview: ",
                                      style: Get.isDarkMode
                                          ? AppStyles.tsWhiteMedium12
                                          : AppStyles.tsBlackMedium12,
                                    ),
                                    TextSpan(
                                      text: isStudent
                                          ? controller.userCourseOverview.value
                                              .courseOverview
                                          : controller.courseOverview.value
                                              .courseOverview,
                                      style: Get.isDarkMode
                                          ? AppStyles.tsWhiteRegular14
                                          : AppStyles.tsBlackRegular14,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isStudent
                      ? (controller.userCourseOverview.value.courseBenefits
                                  ?.length ??
                              0) >
                          0
                      : (controller.courseOverview.value.courseBenefits
                                  ?.length ??
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
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 6),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0204,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 6),
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

                                                      if ((value.about
                                                                  ?.length ??
                                                              0) >
                                                          100) // Add condition to display "Show more" button
                                                        Column(
                                                          children: [
                                                            Text(
                                                              showFullContentForInstructor
                                                                  ? value.about ??
                                                                      ''
                                                                  : '${value.about?.substring(0, 100)}...', // Display truncated or full text
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.0204,
                                                            ),
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
                                                      if ((value.about
                                                                  ?.length ??
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                                ),
                                              )
                                            } else ...{
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                    value.image ?? '',
                                                    fit: BoxFit.fill,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.148,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.148, errorBuilder:
                                                        (context, exception,
                                                            stackTrace) {
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
                                                  Text(
                                                    "${value.about}",
                                                    style: Get.isDarkMode
                                                        ? AppStyles
                                                            .tsWhiteRegular14
                                                        : AppStyles
                                                            .tsBlackRegular14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                        "Course topics:-",
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
                            (controller.userCourseOverview.value.courseContent
                                    ?.length ??
                                0);
                        i++)
                      CourseTopicsAndSubTopicsWidget(
                          i,
                          controller
                              .userCourseOverview.value.courseContent?[i]),
                  } else ...{
                    for (int i = 0;
                        i <
                            (controller.courseOverview.value.courseContent
                                    ?.length ??
                                0);
                        i++)
                      CourseTopicsAndSubTopicsWidget(
                          i, controller.courseOverview.value.courseContent?[i]),
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
                          color: Get.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                        ),
                        "p": Style(
                          backgroundColor: Get.isDarkMode
                              ? AppColors.darkCardBackgroundColor
                              : AppColors.lightCardBackgroundColor,
                          color: Get.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                        ),
                        "div": Style(
                          backgroundColor: Get.isDarkMode
                              ? AppColors.darkCardBackgroundColor
                              : AppColors.lightCardBackgroundColor,
                          color: Get.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                        ),
                        "span": Style(
                          backgroundColor: Get.isDarkMode
                              ? AppColors.darkCardBackgroundColor
                              : AppColors.lightCardBackgroundColor,
                          color: Get.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
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
                          color: Get.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                        ),
                        "strong": Style(
                          backgroundColor: Get.isDarkMode
                              ? AppColors.darkCardBackgroundColor
                              : AppColors.lightCardBackgroundColor,
                          color: Get.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
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
          if (isStudent) ...{
            SafeArea(
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      num price;
                      if ((controller.userCourseOverview.value.coursePrice ??
                              0) !=
                          (controller
                                  .userCourseOverview.value.discountedPrice ??
                              0)) {
                        price = (controller
                                .userCourseOverview.value.discountedPrice ??
                            0);
                      } else {
                        price =
                            (controller.userCourseOverview.value.coursePrice ??
                                0);
                      }

                      BottomSheetHelper.openBottomSheet(
                        context: context,
                        child: PaymentBottomSheet(
                          isGstInclude: true,
                          productType: ProductType.course,
                          productId:
                              controller.userCourseOverview.value.sId ?? '',
                          buyItemPrice: price,
                          onPaymentSuccess: () {},
                          onSubmit: () {
                            Get.back();
                            var walletController = Get.find<WalletController>();
                            var data = {
                              "bonusRedemption":
                                  walletController.isHeroCashAdded.value
                                      ? walletController.heroCashAmount.value
                                      : 0,
                              "coupon": walletController
                                  .couponCodeTextController.text,
                              "courseFee": (walletController
                                      .subscriptionAmount.value +
                                  (walletController.subscriptionAmount.value *
                                      (AppStorage.getReadSetting()
                                              .courseGstPercentage ??
                                          0) /
                                      100)),
                              "courseId":
                                  controller.userCourseOverview.value.sId ?? '',
                              "courseName": controller
                                      .userCourseOverview.value.courseName ??
                                  '',
                            };
                            controller.purchaseCourseApi(data);
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightGreen,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Button border radius
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Buy @ "),
                        if (controller.userCourseOverview.value.coursePrice !=
                            controller
                                .userCourseOverview.value.discountedPrice) ...{
                          Text(
                            "${FormatHelper.formatNumbers(controller.userCourseOverview.value.coursePrice ?? 0, decimal: 0)}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white,
                                decorationThickness: 3),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                              "${FormatHelper.formatNumbers(controller.userCourseOverview.value.discountedPrice ?? 0, decimal: 0)}")
                        } else ...{
                          Text(
                              "${FormatHelper.formatNumbers(controller.userCourseOverview.value.coursePrice ?? 0, decimal: 0)}")
                        }
                      ],
                    )),
              ),
            )
          } else ...{
            controller.courseOverview.value.status == "Sent To Creator"
                ? SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.getInfluncerApprovalDetails(
                                  controller.courseOverview.value.sId ?? '');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightGreen,
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 24), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Button border radius
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Approve"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0204,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.suggestionTextController.clear();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Get.isDarkMode
                                        ? AppColors.darkCardBackgroundColor
                                        : AppColors.lightCardBackgroundColor,
                                    title: Text('Suggest Change'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? AppColors.black.shade200
                                                : AppColors.grey.shade200,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: TextField(
                                            controller: controller
                                                .suggestionTextController,
                                            textInputAction:
                                                TextInputAction.newline,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              hintText: 'Enter Suggestions',
                                              border: InputBorder.none,
                                            ),
                                          ),

                                          // Allow multiple lines for feedback
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: AppColors.lightGreen),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.patchsuggestchangeDetails(
                                              controller.courseOverview.value
                                                      .sId ??
                                                  '',
                                              context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.lightGreen,
                                          onPrimary: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 8), // Button padding
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8), // Button border radius
                                          ),
                                        ),
                                        child: Text('Send'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightGreen,
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 24), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Button border radius
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Suggestion"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox()
          }
        ],
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

String formatDuration(int minutes) {
  if (minutes >= 60) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '$hours hr : $remainingMinutes min';
  } else {
    return '$minutes min';
  }
}
