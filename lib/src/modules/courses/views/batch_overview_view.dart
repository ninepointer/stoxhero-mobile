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
  late VideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;
  late CourseController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CourseController>();

    _controller = VideoPlayerController.networkUrl(Uri.parse(
        '${isStudent ? controller.userCourseOverview.value.salesVideo : controller.courseOverview.value.salesVideo}'))
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _controller,
    );
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
                              rating: controller
                                      .userCourseOverview.value.averageRating
                                      ?.toDouble() ??
                                  0.0,
                              color: AppColors.lightGreen,
                              size: 15.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0102,
                            ),
                            Text(
                              "(${controller.userCourseOverview.value.averageRating?.toDouble() ?? 0.0})",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular14
                                  : AppStyles.tsBlackRegular14,
                            )
                          ],
                        ),
                        // Text(
                        //   "By - Rakesh Kumar",
                        //   style: AppStyles.tsBlackRegular14,
                        // ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "${isStudent ? controller.userCourseOverview.value.courseOverview : controller.courseOverview.value.courseOverview}",
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteRegular14
                                    : AppStyles.tsBlackRegular14,
                              ),
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
                              Text("Created by "),
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
                        Text(
                          "Language - ${isStudent ? controller.userCourseOverview.value.courseLanguages : controller.courseOverview.value.courseLanguages}",
                          style: Get.isDarkMode
                              ? AppStyles.tsWhiteRegular14
                              : AppStyles.tsBlackRegular14,
                        ),
                        Text(
                          "Course category - ${isStudent ? controller.userCourseOverview.value.category : controller.courseOverview.value.category}",
                          style: Get.isDarkMode
                              ? AppStyles.tsWhiteRegular14
                              : AppStyles.tsBlackRegular14,
                        ),
                        Text(
                          "Course duration - ${formatDuration(isStudent ? controller.userCourseOverview.value.courseDurationInMinutes ?? 0 : controller.courseOverview.value.courseDurationInMinutes ?? 0)} ",
                          style: Get.isDarkMode
                              ? AppStyles.tsWhiteRegular14
                              : AppStyles.tsBlackRegular14,
                        ),
                        isStudent == false
                            ? Text(
                                "Course Price - ${FormatHelper.formatNumbers(isStudent ? controller.userCourseOverview.value.coursePrice ?? 0 : controller.courseOverview.value.coursePrice ?? 0, decimal: 0)}",
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteRegular14
                                    : AppStyles.tsBlackRegular14,
                              )
                            : Container(),
                        isStudent == false
                            ? Text(
                                "Discounted Price -  ${FormatHelper.formatNumbers(isStudent ? controller.userCourseOverview.value.discountedPrice ?? 0 : controller.courseOverview.value.discountedPrice ?? 0, decimal: 0)}",
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
                          children: isStudent
                              ? controller
                                  .userCourseOverview.value.courseBenefits!
                                  .map((value) =>
                                      textItemWidget(value.benefits ?? ''))
                                  .toList()
                              : controller.courseOverview.value.courseBenefits!
                                  .map((value) =>
                                      textItemWidget(value.benefits ?? ''))
                                  .toList()),
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
                                                  height: 70,
                                                  width: 70,
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
                                                  height: 70,
                                                  width: 70,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context,
                                                      exception, stackTrace) {
                                                    return Image.asset(
                                                      AppImages.lightAppLogo,
                                                      height: 70,
                                                      width: 70,
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
                                                  Text("${value.about}"),
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
                                                    height: 70,
                                                    width: 70,
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
                                                    height: 70,
                                                    width: 70, errorBuilder:
                                                        (context, exception,
                                                            stackTrace) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.asset(
                                                      AppImages.lightAppLogo,
                                                      height: 70,
                                                      width: 70,
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
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.width * 0.0204,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Course overview:-",
                  //       style: Get.isDarkMode
                  //           ? AppStyles.tsWhiteMedium14
                  //           : AppStyles.tsBlackMedium14,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.width * 0.0204,
                  // ),
                  // Container(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  //     decoration: BoxDecoration(
                  //         color: Get.isDarkMode
                  //             ? AppColors.darkCardBackgroundColor
                  //             : AppColors.lightCardBackgroundColor),
                  //     child: Row(
                  //       children: [
                  //         Flexible(
                  //           child: Text(
                  //             "${isStudent ? controller.userCourseOverview.value.courseOverview : controller.courseOverview.value.courseOverview}",
                  //             style: Get.isDarkMode
                  //                 ? AppStyles.tsWhiteRegular14
                  //                 : AppStyles.tsBlackRegular14,
                  //           ),
                  //         )
                  //       ],
                  //     )),
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
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.0204,
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
                      print(
                          "ddddd ${controller.userCourseOverview.value.sId} ${controller.userCourseOverview.value.courseName}");

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
}

Widget textItemWidget(String str) {
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
          str,
          style: Get.isDarkMode
              ? AppStyles.tsWhiteRegular14
              : AppStyles.tsBlackRegular14,
        ),
      ),
    ],
  );
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
