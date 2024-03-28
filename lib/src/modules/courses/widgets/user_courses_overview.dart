import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:flutter_share/flutter_share.dart';

class UserCoursesOverView extends GetView<CourseController> {
  final UserMyCoursesData? data;
  final FlickManager flickManager;
  UserCoursesOverView(this.data, this.flickManager);

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Course share',
        text: 'To learn about the Share Market, you must visit this course.',
        linkUrl: 'https://stoxhero.com/coursefulldata?id=${data?.sId}',
        chooserTitle: 'Example Chooser Title');
  }

  void _navigateToScreenAndPauseVideo() {
    flickManager.flickControlManager?.pause(); // Pause the video
    // Navigate to the desired screen
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
                  onTap: () async {
                    _navigateToScreenAndPauseVideo();
                    await controller
                        .getUserCourseOverviewDetails(data?.sId ?? '');
                    Get.to(() => MyCoursesOverViewDetailsView());
                  },
                  child: Row(
                    children: [
                      Icon(Icons.info),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0408,
                      ),
                      (controller.userCourseOverview.value.type == 'Workshop' ||
                              controller.courseOverview.value.type ==
                                  'Workshop')
                          ? Text(
                              "About this Workshop",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular18
                                  : AppStyles.tsBlackRegular18,
                            )
                          : Text(
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
                    _navigateToScreenAndPauseVideo();
                    share();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0408,
                      ),
                      (controller.userCourseOverview.value.type == 'Workshop' ||
                              controller.courseOverview.value.type ==
                                  'Workshop')
                          ? Text(
                              "Share this Workshop",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular18
                                  : AppStyles.tsBlackRegular18,
                            )
                          : Text(
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
                    _navigateToScreenAndPauseVideo();
                    Get.to(() => UserResourcesView(data));
                    //SnackbarHelper.showSnackbar("In Working");
                  },
                  child: Row(
                    children: [
                      Icon(Icons.rate_review),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.0408,
                      ),
                      (controller.userCourseOverview.value.type == 'Workshop' ||
                              controller.courseOverview.value.type ==
                                  'Workshop')
                          ? Text(
                              "Workshop Resources",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular18
                                  : AppStyles.tsBlackRegular18,
                            )
                          : Text(
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
                    _navigateToScreenAndPauseVideo();
                    showDialog(
                      context: context,
                      builder: (context) {
                        String courseId = data?.sId ?? '';
                        int initialRating =
                            AppStorage.getCourseUserStarRating(courseId);

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: (controller
                                              .userCourseOverview.value.type ==
                                          'Workshop' ||
                                      controller.courseOverview.value.type ==
                                          'Workshop')
                                  ? Text("Rate this Workshop")
                                  : Text("Rate this Course"),
                              content: Row(
                                children: List.generate(
                                  5,
                                  (index) {
                                    return IconButton(
                                      icon: Icon(
                                        index < initialRating
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          initialRating = index + 1;
                                          controller.currentRating.value =
                                              initialRating;
                                        });
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
                                    style:
                                        TextStyle(color: AppColors.lightGreen),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Map<String, dynamic> ratingData = {
                                      "rating": controller.currentRating.value
                                    };

                                    controller.courseRatingApi(
                                        ratingData, courseId, () {
                                      AppStorage.setCourseUserStarRating(
                                          courseId, initialRating);
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
                                  child: Text('Rate'),
                                ),
                              ],
                            );
                          },
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
                      (controller.userCourseOverview.value.type == 'Workshop' ||
                              controller.courseOverview.value.type ==
                                  'Workshop')
                          ? Text(
                              "Rate this Workshop",
                              style: Get.isDarkMode
                                  ? AppStyles.tsWhiteRegular18
                                  : AppStyles.tsBlackRegular18,
                            )
                          : Text(
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
