import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class CourseAllTopicView extends StatefulWidget {
  const CourseAllTopicView({super.key});

  @override
  State<CourseAllTopicView> createState() => _CourseAllTopicViewState();
}

class _CourseAllTopicViewState extends State<CourseAllTopicView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("What is equity"),
      ),
      body: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => CourseVideoView());
            },
            child: Container(
              width: double.infinity,
              color: AppColors.white,
              margin: EdgeInsets.only(bottom: 8, top: 8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          child: Image.asset(
                            AppImages.contest,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0204,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "What is equity ?",
                                  style: AppStyles.tsBlackRegular16,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.0204,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    StarRatingWidget(
                                      starCount: 5,
                                      rating: 3.5,
                                      color: AppColors.lightGreen,
                                      size: 15.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0102,
                                        ),
                                        Text(
                                            "${FormatHelper.categoryFormatter(1000)}"),
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
                      children: [
                        Expanded(
                          child: Text(
                            "By - Rakesh kumar, Rakesh kumar, Rakesh kumar",
                            style: AppStyles.tsBlackRegular14
                                .copyWith(color: AppColors.grey),
                          ),
                        ),
                      ],
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
