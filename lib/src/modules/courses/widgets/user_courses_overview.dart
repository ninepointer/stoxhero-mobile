import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:flutter_share/flutter_share.dart';

class UserCoursesOverView extends GetView<CourseController> {
  final UserMyCoursesData? data;

  UserCoursesOverView(this.data);

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Course share',
        text: 'Share this course',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, index) {
          return Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.0204),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0306,
                vertical: MediaQuery.of(context).size.width * 0.0306),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.getUserCourseOverviewDetails(data?.sId ?? '');
                    Get.to(() => MyCoursesOverViewDetailsView());
                  },
                  child: Row(
                    children: [
                      Icon(Icons.info),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0408,
                      ),
                      Text(
                        "About this Course",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular18
                            : AppStyles.tsBlackRegular18,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0408,
                ),
                GestureDetector(
                  onTap: () async {
                    share();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0408,
                      ),
                      Text(
                        "Share this Course",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular18
                            : AppStyles.tsBlackRegular18,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0408,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => UserResourcesView(data));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.rate_review),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0408,
                      ),
                      Text(
                        "Course Resources",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular18
                            : AppStyles.tsBlackRegular18,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0408,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(
                          () => AlertDialog(
                            title: Text("Rate this Course"),
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
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: AppColors.lightGreen),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (AppStorage.getCourseUserStarRating() ==
                                              0 &&
                                          AppStorage.getCourseSidForStarRating()
                                              .isEmpty ||
                                      AppStorage.getCourseSidForStarRating() !=
                                          data?.sId) {
                                    Map<String, dynamic> ratingData = {
                                      "rating": controller.currentRating.value
                                    };

                                    controller.courseRatingApi(
                                        ratingData, data?.sId, () {
                                      AppStorage.setCourseUserStarRating(1);
                                      AppStorage.setCourseSidForStarRating(
                                          data?.sId);
                                      Navigator.of(context).pop();
                                    });
                                  } else {
                                    SnackbarHelper.showSnackbar(
                                        "You have already rated this course.");
                                  }
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
                                child: Text('Rate'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.reviews),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0408,
                      ),
                      Text(
                        "Rate this Course",
                        style: Get.isDarkMode
                            ? AppStyles.tsWhiteRegular18
                            : AppStyles.tsBlackRegular18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
