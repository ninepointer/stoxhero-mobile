import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

bool isStudent =
    AppStorage.getUserDetails().role?.roleName == "Influencer" ? true : false;

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
    if (isStudent) {
      controller.getUserAllCourses();
      controller.getUserMyCoursesDetails();
    } else {
      controller.getInfluencerAwaitingapprovalCourseDetails();
    }
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
        leading: IconButton(
            onPressed: () {
              Get.to(() => HomeView());
            },
            icon: Icon(Icons.arrow_back)),
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
                    if (isStudent)
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
                                        Image.asset(
                                      AppImages.love,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width *
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
                    if (isStudent)
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0306,
                      ),
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
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      BatchAllCoursesView(
                                          controller.userAllCourses),
                                      MyLibraryView(controller.userMyCourses)
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
                                      controller.currentPage(0);
                                      controller.itemsPerPage(0);
                                      controller
                                          .getInfluencerAwaitingapprovalCourseDetails();
                                    } else if (index == 1) {
                                      controller.currentPage(0);
                                      controller.itemsPerPage(0);
                                      controller
                                          .getInfluencerPendingadminapprovalCourseDetails();
                                    } else if (index == 2) {
                                      controller.currentPage(0);
                                      controller.itemsPerPage(0);
                                      controller
                                          .getInfluencerUnpublishCourseDetails();
                                    } else {
                                      controller.currentPage(0);
                                      controller.itemsPerPage(0);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
