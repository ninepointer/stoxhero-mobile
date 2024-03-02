import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class BatchDetailsView extends StatefulWidget {
  const BatchDetailsView({super.key});

  @override
  State<BatchDetailsView> createState() => _BatchDetailsViewState();
}

class _BatchDetailsViewState extends State<BatchDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late CourseController controller;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    controller = Get.find<CourseController>();
    controller.selectedTabIndex.value = 0;
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
        title: Obx(() => isStudent
            ? Text("${controller.userCourseOverview.value.courseName}")
            : Text("${controller.courseOverview.value.courseName}")),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Future.value();
        },
        child: Visibility(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.0408,
                  vertical: MediaQuery.of(context).size.width * 0.0204),
              child: isStudent
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Get.isDarkMode
                              ? AppColors.darkScaffoldBackgroundColor
                              : AppColors.lightScaffoldBackgroundColor,
                          child: TabBar(
                            onTap: (index) {
                              controller.loadData();
                              controller.selectedTabIndex.value = index;
                            },
                            indicatorColor: AppColors.lightGreen,
                            controller: tabController,
                            padding: EdgeInsets.zero,
                            tabs: [
                              Tab(
                                child: Text(
                                  "OverView",
                                  style:
                                      Theme.of(context).textTheme.tsRegular14,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Live Classes",
                                  style:
                                      Theme.of(context).textTheme.tsRegular14,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                              controller: tabController,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                BatchOverViewDetailsView(),
                                BatchLiveClassesView()
                              ]),
                        ),
                      ],
                    )
                  : BatchOverViewDetailsView()),
        ),
      ),
    );
  }
}
