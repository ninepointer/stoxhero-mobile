import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class BatchAllCoursesView extends GetView<CourseController> {
  final ScrollController _scrollController = ScrollController();
  final List<InfluencerCourseData>? courseData;
  final List<InfluencerCourseData>? workshopData;

  BatchAllCoursesView(this.courseData, {this.workshopData});

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

        return RefreshIndicator(
          onRefresh: () {
            controller.getUserAllCourses();
            return Future.value();
          },
          child: ListView(
            controller: _scrollController,
            children: [
              if ((workshopData == null || workshopData!.isEmpty) &&
                  (courseData == null || courseData!.isEmpty))
                NoDataFound(),
              if (workshopData != null && workshopData!.isNotEmpty) ...[
                // Display Workshop title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Workshops",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Display list of workshops
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: workshopData!.length,
                  itemBuilder: (context, index) {
                    return isStudent
                        ? GestureDetector(
                            onTap: () async {
                              await controller.getUserCourseOverviewDetails(
                                  workshopData![index].sId ?? '');

                              Get.to(
                                  () => BatchDetailsView(workshopData![index]));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8, top: 8),
                              child:
                                  WorkshopBatchNameWidget(workshopData![index]),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(bottom: 8, top: 8),
                            child:
                                WorkshopBatchNameWidget(workshopData![index]),
                          );
                  },
                ),
              ],
              // Display Course Title title
              courseData!.length != 0 &&
                      workshopData != null &&
                      workshopData!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Courses",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container(),
              // Display list of courses

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: courseData!.length,
                itemBuilder: (context, index) {
                  var courseDetails = courseData![index];
                  return isStudent
                      ? GestureDetector(
                          onTap: () async {
                            await controller.getUserCourseOverviewDetails(
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
            ],
          ),
        );
      },
    );
  }
}
