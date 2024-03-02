import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stoxhero/src/app/app.dart';

class CourseAllTopicView extends StatefulWidget {
  final UserMyCoursesData? data;
  CourseAllTopicView(this.data);

  @override
  State<CourseAllTopicView> createState() => _CourseAllTopicViewState();
}

class _CourseAllTopicViewState extends State<CourseAllTopicView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.data?.courseName ?? ''}"),
      ),
      body: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.data?.topics?.length,
        itemBuilder: (context, index) {
          var data = widget.data?.topics?[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => CourseVideoView());
            },
            child: Container(
              width: double.infinity,
              color: Get.isDarkMode
                  ? AppColors.darkCardBackgroundColor
                  : AppColors.lightCardBackgroundColor,
              margin: EdgeInsets.only(bottom: 8, top: 8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          "${data?.topic ?? ''}",
                          style: Get.isDarkMode
                              ? AppStyles.tsWhiteRegular16
                              : AppStyles.tsBlackRegular16,
                        ),
                      ),
                    ),
                  ],
                ),

                // Row(
                //   children: [
                //     Expanded(
                //       child: Text(
                //         "By - Rakesh kumar, Rakesh kumar, Rakesh kumar",
                //         style: AppStyles.tsBlackRegular14
                //             .copyWith(color: AppColors.grey),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
