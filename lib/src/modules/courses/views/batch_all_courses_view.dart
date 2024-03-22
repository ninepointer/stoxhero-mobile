import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class BatchAllCoursesView extends GetView<CourseController> {
  final ScrollController _scrollController = ScrollController();
  final List<InfluencerCourseData>? data;
  final List<InfluencerCourseData>? workshop;

  BatchAllCoursesView(this.data, {this.workshop});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        _scrollController.addListener(() {
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent) {
            controller.loadMoreOrders();
          }
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show workshops here
            if (workshop?.isNotEmpty == true) ...[
              Text("Workshops"),
              // Add your workshop widgets here
            ],
            // Show text indicating courses
            Text("Courses"),
            // List of courses
            if (data?.isNotEmpty == true) ...[
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    var courseDetails = data![index];
                    return isStudent
                        ? GestureDetector(
                            onTap: () {
                              controller.getUserCourseOverviewDetails(
                                  courseDetails.sId ?? '');
                              Get.to(() => BatchDetailsView(courseDetails));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8, top: 8),
                              child: CourseBatchNameWidget(courseDetails),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(bottom: 8, top: 8),
                            child: CourseBatchNameWidget(courseDetails),
                          );
                  },
                ),
              ),
            ] else
              // Show a message if there are no courses
              NoDataFound(),
          ],
        );
      },
    );
  }
}
