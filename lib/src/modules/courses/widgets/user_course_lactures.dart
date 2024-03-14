import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class UserCoursesLactures extends StatelessWidget {
  final UserMyCoursesData? data;
  UserCoursesLactures(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: data?.topics?.length,
        itemBuilder: (context, index) {
          var item = data?.topics?[index];

          return Container(
            margin: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Section ${index + 1} -  ${item?.topic ?? ''}",
                      style: AppStyles.tsSecondaryMedium14
                          .copyWith(color: AppColors.lightGreen),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0306,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item!.subtopics!
                      .asMap()
                      .entries
                      .map((entry) => GestureDetector(
                            onTap: () {
                              // Get.to(() =>
                              //     CourseVideoView(widget.data, entry.value));
                            },
                            child: Container(
                              // padding: EdgeInsets.all(10),
                              // margin: EdgeInsets.only(
                              //     bottom: MediaQuery.of(context).size.width *
                              //         0.0204),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${entry.key + 1} ",
                                    style:
                                        Theme.of(context).textTheme.tsRegular14,
                                    textAlign: TextAlign.start,
                                  ),
                                  // Image.network(
                                  //   entry.value.videoKey ?? '',
                                  //   width: 50,
                                  //   height: 50,
                                  //   fit: BoxFit.cover,
                                  //   errorBuilder:
                                  //       (context, exception, stackTrace) {
                                  //     return Image.asset(
                                  //       AppImages.lightAppLogo,
                                  //       height: 50,
                                  //       width: 50,
                                  //     );
                                  //   },
                                  // ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.0306,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${entry.value.topic}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .tsRegular18,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                )
              ],
            ),
          );
        });
  }
}
