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
  late CourseController controller;

  void initState() {
    super.initState();
    controller = Get.find<CourseController>();
    controller.getUserMyCoursesDetails();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.data?.length,
        itemBuilder: (context, index) {
          var data = widget.data?[index];

          return GestureDetector(
            onTap: () {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (data?.courseImage == null) ...{
                          Image.asset(
                            AppImages.lightAppLogo,
                            height: MediaQuery.of(context).size.width * 0.250,
                            width: MediaQuery.of(context).size.width * 0.250,
                            fit: BoxFit.cover,
                          ),
                        } else ...{
                          Image.network(
                            data?.courseImage ?? '',
                            height: MediaQuery.of(context).size.width * 0.250,
                            width: MediaQuery.of(context).size.width * 0.250,
                            fit: BoxFit.cover,
                            errorBuilder: (context, exception, stackTrace) {
                              return Image.asset(
                                AppImages.lightAppName,
                                height:
                                    MediaQuery.of(context).size.width * 0.250,
                                width:
                                    MediaQuery.of(context).size.width * 0.250,
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
                                      ? AppStyles.tsWhiteMedium18
                                      : AppStyles.tsBlackMedium18,
                                ),
                              ),
                              if ((data?.instructorName?.length ?? 0) > 0) ...{
                                Row(
                                  children: [
                                    Text("By: "),
                                    Expanded(
                                      child: Wrap(
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
                                    ),
                                  ],
                                ),
                              },
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.0204,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        StarRatingWidget(
                                          starCount: 5,
                                          rating: (data?.rating?.toDouble() ??
                                                      0) >
                                                  0
                                              ? data?.rating?.toDouble() ?? 0
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
                                            "(${((data?.rating ?? 0) > 0) ? data?.rating ?? 0 : 4})")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "For ${data?.level ?? ''}",
                                          style: Get.isDarkMode
                                              ? AppStyles.tsWhiteRegular14
                                              : AppStyles.tsBlackRegular14,
                                        ),
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
                              width: MediaQuery.of(context).size.width * 0.0204,
                            ),
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: Get.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0204,
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
                              width: MediaQuery.of(context).size.width * 0.0102,
                            ),
                            if ((data?.coursePrice ?? 0) !=
                                (data?.discountedPrice ?? 0)) ...{
                              Text(
                                "${FormatHelper.formatNumbers(data?.coursePrice, decimal: 0)}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Get.isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    decorationThickness: 3),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0102,
                              ),
                              Text(
                                  "${FormatHelper.formatNumbers(data?.discountedPrice, decimal: 0)}"),
                            } else ...{
                              Text(
                                  "${FormatHelper.formatNumbers(data?.coursePrice, decimal: 0)}"),
                            },
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
                    LinearPercentIndicator(
                      padding: EdgeInsets.zero,
                      lineHeight: MediaQuery.of(context).size.width * 0.0156,
                      percent: (data?.coursePrgress?.toDouble() ?? 0.0),
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
