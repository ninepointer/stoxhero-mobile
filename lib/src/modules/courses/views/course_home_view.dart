import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

bool isStudent = false;

class CoursesHomeView extends StatefulWidget {
  const CoursesHomeView({super.key});

  @override
  State<CoursesHomeView> createState() => _CoursesHomeViewState();
}

class _CoursesHomeViewState extends State<CoursesHomeView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late CourseController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CourseController>();
    //controller.loadData();
    tabController = isStudent
        ? TabController(length: 2, vsync: this)
        : TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Get.to(() => HomeView());
        //       },
        //       icon: Icon(Icons.arrow_back)),
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.value();
        },
        child: Visibility(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0306,
                vertical: MediaQuery.of(context).size.width * 0.0306),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.309,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider.builder(
                          itemCount: 1,
                          itemBuilder: (context, int index, _) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.width * 0.309,
                                decoration: BoxDecoration(
                                  color: AppColors.grey.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child:
                                      //  Image.network(
                                      //   "${controller.dashboardCarouselList[index].carouselImage}",
                                      //   fit: BoxFit.fill,
                                      //   height:
                                      //       MediaQuery.of(context).size.width * 0.382,
                                      //   width: MediaQuery.of(context).size.width,
                                      // ),
                                      Image.asset(
                                    AppImages.love,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width *
                                        0.309,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            viewportFraction: 1,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayInterval: const Duration(seconds: 6),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "10 Courses",
                    //       style: AppStyles.tsBlackMedium12,
                    //     ),
                    //     Icon(Icons.sort)
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width * 0.0306,
                    // ),
                    if (isStudent) ...{
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              Container(
                                child: TabBar(
                                  controller: tabController,
                                  indicatorColor: AppColors.lightGreen,
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'Courses',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsRegular16,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'My Library',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsRegular16,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 12,
                              // ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      BatchAllCoursesView(
                                          controller.publishInflunceCourseList),
                                      // Center(
                                      //     child: Text(
                                      //         "You haven\'t bought any courses yet. "),
                                      //         ),
                                      MyLibraryView()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    } else ...{
                      Expanded(
                        child: DefaultTabController(
                          length: 4,
                          child: Column(
                            children: [
                              Container(
                                child: TabBar(
                                  onTap: (index) {
                                    if (index == 0) {
                                      controller
                                          .getInfluencerAwaitingapprovalCourseDetails();
                                    } else if (index == 1) {
                                      controller
                                          .getInfluencerPendingadminapprovalCourseDetails();
                                    } else if (index == 2) {
                                      controller
                                          .getInfluencerUnpublishCourseDetails();
                                    } else {
                                      controller
                                          .getInfluencerPublishCourseDetails();
                                    }
                                  },
                                  padding: EdgeInsets.all(8),
                                  isScrollable: true,
                                  controller: tabController,
                                  indicatorColor: Get.isDarkMode
                                      ? AppColors.black
                                      : AppColors.white,
                                  labelColor: AppColors.white,
                                  unselectedLabelColor: Get.isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  indicator: BoxDecoration(
                                    color: AppColors.lightGreen,
                                    borderRadius: BorderRadius.circular(
                                        40), // Border radius
                                  ),
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'Awaiting\nApproval',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsRegular16,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Pending Admin\nApproval',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsRegular16,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Live\nCourses',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsRegular16,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Completed\nCourses',
                                        style: Theme.of(context)
                                            .textTheme
                                            .tsRegular16,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 12,
                              // ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      BatchAllCoursesView(controller
                                          .awaitingapprovalInflunceCourseList),
                                      BatchAllCoursesView(controller
                                          .pendingadminapprovalInflunceCourseList),
                                      BatchAllCoursesView(controller
                                          .unPublishInflunceCourseList),
                                      BatchAllCoursesView(
                                          controller.publishInflunceCourseList),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    }
                  ],
                ),

                // for instructor only
                // if (isStudent == false) ...{
                //   Positioned(
                //     right: 0,
                //     bottom: 0,
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: FloatingActionButton(
                //         onPressed: () {
                //           Get.to(() => CreateNewBatchView());
                //         },
                //         child: Icon(
                //           Icons.add,
                //           color: AppColors.white,
                //         ),
                //         backgroundColor: AppColors.lightGreen,
                //       ),
                //     ),
                //   )
                //}
              ],
            ),
          ),
        ),
      ),
    );
  }
}
