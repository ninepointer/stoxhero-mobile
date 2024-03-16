import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class BatchAllCoursesView extends GetView<CourseController> {
  final ScrollController _scrollController = ScrollController();
  final List<InfluencerCourseData>? data;
  BatchAllCoursesView(this.data);

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

        return data?.length != 0
            ? ListView.builder(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  if (index < (data?.length ?? 0)) {
                    var courseDetails = data?[index];
                    return isStudent
                        ? GestureDetector(
                            onTap: () {
                              controller.getUserCourseOverviewDetails(
                                  courseDetails?.sId ?? '');
                              Get.to(() => BatchDetailsView(courseDetails));
                            },
                            child: Container(
                                margin: EdgeInsets.only(bottom: 8, top: 8),
                                child: CourseBatchNameWidget(courseDetails)),
                          )
                        : Container(
                            margin: EdgeInsets.only(bottom: 8, top: 8),
                            child: CourseBatchNameWidget(courseDetails));
                  } else if (!controller.isLoadingMore.value &&
                      (data?.length ?? 0) > 4 &&
                      controller.itemsPerPage.value > 0) {
                    return Container(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                })
            : NoDataFound();
      },
    );
  }
}
