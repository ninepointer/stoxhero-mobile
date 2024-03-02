import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../app/app.dart';

class MyLibraryView extends StatefulWidget {
  final List<UserMyCoursesData>? data;
  const MyLibraryView(this.data);

  @override
  State<MyLibraryView> createState() => _MyLibraryViewState();
}

class _MyLibraryViewState extends State<MyLibraryView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.data?.length,
        itemBuilder: (context, index) {
          var data = widget.data?[index];

          return GestureDetector(
            onTap: () {
              // Get.to(() => CourseVideoView());
              Get.to(() => CourseAllTopicView(data));
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
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text("${data?.courseName}",
                    //         style: Get.isDarkMode
                    //             ? AppStyles.tsWhiteRegular16
                    //             : AppStyles.tsBlackRegular16),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width * 0.0204,
                    // ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     StarRatingWidget(
                    //       starCount: 5,
                    //       rating: 3.5,
                    //       color: AppColors.lightGreen,
                    //       size: 15.0,
                    //     ),
                    //     Row(
                    //       children: [
                    //         Icon(
                    //           Icons.people,
                    //           size: 15,
                    //         ),
                    //         SizedBox(
                    //           width: MediaQuery.of(context).size.width * 0.0102,
                    //         ),
                    //         Text(
                    //             "${FormatHelper.categoryFormatter(data?.userEnrolled)}"),
                    //         SizedBox(
                    //           width: MediaQuery.of(context).size.width * 0.0204,
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width * 0.0306,
                    // ),

                    // // for instructor

                    // if ((data?.instructorName?.length ?? 0) > 0) ...{
                    //   Row(
                    //     children: [
                    //       Text(
                    //         "Instructors - ",
                    //         style: Get.isDarkMode
                    //             ? AppStyles.tsWhiteMedium12
                    //             : AppStyles.tsBlackMedium12,
                    //       ),
                    //       Row(
                    //         children: data!.instructorName!
                    //             .asMap()
                    //             .entries
                    //             .map((entry) {
                    //           final index = entry.key;
                    //           final value = entry.value;
                    //           final isLast =
                    //               index == data!.instructorName!.length - 1;

                    //           return Text(
                    //             isLast ? value : '$value, ',
                    //             style: Get.isDarkMode
                    //                 ? AppStyles.tsWhiteMedium12
                    //                 : AppStyles.tsBlackMedium12,
                    //           );
                    //         }).toList(),
                    //       ),
                    //     ],
                    //   )
                    // },
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width * 0.0306,
                    // ),
                    // LinearPercentIndicator(
                    //   padding: EdgeInsets.zero,
                    //   lineHeight: MediaQuery.of(context).size.width * 0.0156,
                    //   percent: data?.coursePrgress ?? 0,
                    //   progressColor: AppColors.lightGreen,
                    //   backgroundColor: AppColors.grey.withOpacity(0.3),
                    //   barRadius: Radius.circular(10),
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (data?.courseImage == null) ...{
                          Image.asset(
                            AppImages.lightAppLogo,
                            height: 70,
                            width: 70,
                            //   fit: BoxFit.cover,
                          ),
                        } else ...{
                          Image.network(
                            data?.courseImage ?? '',
                            //  fit: BoxFit.fill,
                            height: 70,
                            width: 70,
                            errorBuilder: (context, exception, stackTrace) {
                              return Image.asset(
                                AppImages.lightAppLogo,
                                height: 70,
                                width: 70,
                                //   fit: BoxFit.cover,
                              );
                            },
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
                                  "${data?.courseName}",
                                  style: Get.isDarkMode
                                      ? AppStyles.tsWhiteRegular16
                                      : AppStyles.tsBlackRegular16,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.0204,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0102,
                                        ),
                                        Text(
                                            "${FormatHelper.categoryFormatter(data?.userEnrolled)}"),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                    if ((data?.instructorName?.length ?? 0) > 0) ...{
                      Row(
                        children: [
                          Text(
                            "Instructors - ",
                            style: Get.isDarkMode
                                ? AppStyles.tsWhiteMedium12
                                : AppStyles.tsBlackMedium12,
                          ),
                          Row(
                            children: data!.instructorName!
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key;
                              final value = entry.value;
                              final isLast =
                                  index == data!.instructorName!.length - 1;

                              return Text(
                                isLast ? value : '$value, ',
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteMedium12
                                    : AppStyles.tsBlackMedium12,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    },
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0204,
                    ),
                    LinearPercentIndicator(
                      padding: EdgeInsets.zero,
                      lineHeight: MediaQuery.of(context).size.width * 0.0156,
                      percent: data?.coursePrgress ?? 0,
                      progressColor: AppColors.lightGreen,
                      backgroundColor: AppColors.grey.withOpacity(0.3),
                      barRadius: Radius.circular(10),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
