import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class UserCoursesOverView extends GetView<CourseController> {
  final UserMyCoursesData? data;

  UserCoursesOverView(this.data);

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
                Row(
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
                Row(
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
              ],
            ),
          );
        });
  }
}
