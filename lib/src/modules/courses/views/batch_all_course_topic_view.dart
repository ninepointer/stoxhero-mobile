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
  late CourseController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CourseController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("${widget.data?.courseName ?? ''}"),
          leading: IconButton(
            onPressed: () {
              (AppStorage.getCourseUserStarRating() == 0 &&
                          AppStorage.getCourseSidForStarRating().isEmpty ||
                      AppStorage.getCourseSidForStarRating() !=
                          widget.data?.sId)
                  ? showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(
                          () => AlertDialog(
                            title: Text("Rate this video"),
                            content: Row(
                              children: List.generate(
                                5,
                                (index) {
                                  return IconButton(
                                    icon: Icon(
                                      index < controller.currentRating.value
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                    ),
                                    onPressed: () {
                                      controller.currentRating(index + 1);
                                    },
                                  );
                                },
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: AppColors.lightGreen),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Map<String, dynamic> data = {
                                    "rating": controller.currentRating.value
                                  };
                                  controller.courseRatingApi(
                                      data, widget.data?.sId, () {
                                    AppStorage.setCourseUserStarRating(1);
                                    AppStorage.setCourseSidForStarRating(
                                        widget.data?.sId);
                                    Navigator.of(context).pop();
                                  });
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
                          ),
                        );
                      },
                    )
                  : Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          )),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
