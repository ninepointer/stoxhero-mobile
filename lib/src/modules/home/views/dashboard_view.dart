import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:stoxhero/src/modules/story/view/story_view.dart';
import '../../../app/app.dart';
import '../../../modules/contest/views/competed_contest_champion_Leaderboard.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late HomeController controller;
  late ContestController contestController;
  late CollegeContestController collegeContestController;
  late ContestProfileController contestProfileController;
  late CourseController courseController;
  late ReferralsController referralsController;
  late List<String> monthsList;

  String? selectedValue2 = '';

  @override
  void initState() {
    super.initState();

    controller = Get.find<HomeController>();
    contestProfileController = Get.find<ContestProfileController>();
    contestController = Get.find<ContestController>();
    collegeContestController = Get.find<CollegeContestController>();
    contestProfileController = Get.find<ContestProfileController>();
    courseController = Get.find<CourseController>();
    contestProfileController.loadData();
    contestController.getPaidContestChampionList();
    courseController.getUserAllCourses();
    courseController.getInfluencerPublishCourseDetails();

    referralsController = Get.find<ReferralsController>();
    referralsController.loadData();
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMMM yyyy').format(now);
    String previousMonth =
        DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - 1));
    String penultimateMonth =
        DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - 2));
    String nextMonth =
        DateFormat('MMMM yyyy').format(DateTime(now.year, now.month + 1));

    monthsList = [
      penultimateMonth,
      previousMonth,
      currentMonth,
      nextMonth,
    ];
    selectedValue2 = currentMonth;

    // Future.delayed(Duration(seconds: 2), () {
    //   if (controller.firstTimeshowStatus) {
    //     Get.to(StoryView());
    //   }
    //   controller.firstTimeshow.value = false;
    // });
  }

  String getProductMonth(String? label) {
    String name = '';
    DateTime now = DateTime.now();
    if (label == 'this month') name = DateFormat('MMMM yyyy').format(now);
    if (label == 'last month')
      name = DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - 1));
    if (label == 'previous to last month')
      name = DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - 2));
    if (label == 'lifetime') name = 'Lifetime';
    return name;
  }

  DashboardTradeSummary get userDashboard => controller.userDashboard.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            controller.loadData();
            contestProfileController.loadData();
            contestController.loadData();
            return Future.value();
          },
          child: Visibility(
            visible: !controller.isLoadingStatus,
            replacement: DashboardShimmer(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.0306,
                    vertical: MediaQuery.of(context).size.width * 0.0306),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.stockIndexDetailsList.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   width: 4,
                          // ),
                          for (var item
                              in controller.stockIndexDetailsList) ...[
                            TradingStockCard(
                              label: controller
                                  .getStockIndexName(item.instrumentToken ?? 0),
                              stockPrice: FormatHelper.formatNumbers(
                                item.lastPrice,
                              ),
                              stockColor: controller.getValueColor(
                                // item.lastPrice! - (item.ohlc?.close ?? 0),
                                (item.lastPrice! * item.change!) / 100,
                              ),
                              stockLTP: FormatHelper.formatNumbers(
                                // item.lastPrice! - (item.ohlc?.close ?? 0),
                                (item.lastPrice! * item.change!) / 100,
                              ),
                              stockChange:
                                  '(${item.change?.toStringAsFixed(2)}%)',
                              stockLTPColor: controller.getValueColor(
                                // item.lastPrice! - (item.ohlc?.close ?? 0),
                                (item.lastPrice! * item.change!) / 100,
                              ),
                            ),
                            if (item != controller.stockIndexDetailsList.last)
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0306,
                              ),
                          ]
                        ],
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.5739,
                      width: MediaQuery.of(context).size.width,
                      // padding: EdgeInsets.symmetric(horizontal: 12),
                      child: CarouselSlider.builder(
                        itemCount: controller.dashboardCarouselList.length,
                        itemBuilder: (context, int index, _) {
                          return GestureDetector(
                            onTap: () => controller.navigateToCarousel(
                              controller.dashboardCarouselList[index]
                                      .linkToCarousel ??
                                  '',
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 0.382,
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "${controller.dashboardCarouselList[index].carouselImage}",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.width * 0.382,
                                  width: MediaQuery.of(context).size.width,
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
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    if (courseController.userAllWorkshops.isNotEmpty)
                      CommonTile(
                        label: 'Upcoming Workshops',
                        showSeeAllButton: false,
                        isValue: false,
                        seeAllLabel: 'View All',
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    isStudent
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Obx(
                              () => Row(
                                children: courseController.userAllWorkshops
                                    .where((contest) => (DateTime.now()
                                                .isBefore(DateTime.parse(contest
                                                        ?.registrationEndTime ??
                                                    '')) ==
                                            true ||
                                        (contest?.isPaid ?? false) == true))
                                    .map((contest) {
                                  return Container(
                                      margin: courseController
                                                  .userAllWorkshops.length ==
                                              1
                                          ? EdgeInsets.zero
                                          : EdgeInsets.only(
                                              left: 0, right: 16, top: 0),
                                      width: courseController
                                                  .userAllWorkshops.length ==
                                              1
                                          ? MediaQuery.of(context).size.width -
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.0637

                                          /// 0.1603
                                          : MediaQuery.of(context).size.width -
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1603,
                                      child: WorkshopCard(
                                        courseData: contest,
                                      ));
                                }).toList(),
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Obx(
                              () => Row(
                                children: courseController
                                    .publishInflunceWorkshopList
                                    .map((contest) {
                                  return Container(
                                      margin: courseController
                                                  .publishInflunceWorkshopList
                                                  .length ==
                                              1
                                          ? EdgeInsets.zero
                                          : EdgeInsets.only(
                                              left: 0, right: 16, top: 0),
                                      width: courseController
                                                  .publishInflunceWorkshopList
                                                  .length ==
                                              1
                                          ? MediaQuery.of(context).size.width -
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.0637

                                          /// 0.1603
                                          : MediaQuery.of(context).size.width -
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1603,
                                      child: WorkshopCard(
                                        courseData: contest,
                                      ));
                                }).toList(),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    if ((contestProfileController.startOfWeek.value != "" &&
                            contestProfileController.endOfWeek.value != "") ||
                        contestProfileController.weeklyTopPerformer.isNotEmpty)
                      CommonTile(
                        label: 'Weekly TestZone Leaderboard',
                        showSeeAllButton: true,
                        isValue: true,
                        seeAllLabel: 'View All',
                        value: '${[
                          '${FormatHelper.formatDateMonth(contestProfileController.startOfWeek.toString())} - ${FormatHelper.formatDateMonth(contestProfileController.endOfWeek.toString())}'
                        ]}',
                        onPressed: () {
                          contestProfileController.weeklyTopPerformer();
                          contestProfileController
                              .getWeeklyTopPerformerFullList();
                          Get.to(() => ContestTopPerformerCard());
                        },
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                        () => Container(
                          child: Row(
                            children: contestProfileController
                                .weeklyTopPerformer
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              return ContestPortfolioWeekCard(
                                index: index + 1,
                                performer: entry.value,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    contestController.liveFeaturedContest.isEmpty &&
                            contestController.upcomingFeaturedContest.isEmpty
                        ? Container()
                        : CommonTile(
                            label: 'Featured TestZones',
                            showSeeAllButton: true,
                            onPressed: () {
                              contestController.loadData();
                              contestController.liveFeaturedContest.isEmpty
                                  ? contestController.selectedTabBarIndex(1)
                                  : contestController.selectedTabBarIndex(0);
                              Get.to(() => ContestListView());
                            },
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          contestController.featuredCollegeContest.isEmpty
                              ? Container()
                              : Obx(
                                  () => Row(
                                    children: contestController
                                        .featuredCollegeContest
                                        .map((contest) {
                                      String userId =
                                          controller.userDetailsData.sId ?? '';
                                      return Container(
                                        width: contestController
                                                    .featuredCollegeContest
                                                    .length ==
                                                1
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.0637
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1403,
                                        child: CollegeContestCard(
                                          userId: userId,
                                          featuredCollegeContest: contest,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                          contestController.liveFeaturedContest.isEmpty
                              ? Container()
                              : Obx(
                                  () => Row(
                                    children: contestController
                                        .liveFeaturedContest
                                        .map((contest) {
                                      String userId =
                                          controller.userDetailsData.sId ?? '';
                                      return Container(
                                        width: contestController
                                                    .liveFeaturedContest
                                                    .length ==
                                                1
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.0637
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1403,
                                        child: LiveFeaturedCard(
                                          userId: userId,
                                          liveFeatured: contest,
                                          contestController: contestController,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                          if (contestController.liveFeaturedContest.isEmpty &&
                              contestController
                                  .upcomingFeaturedContest.isNotEmpty)
                            Obx(
                              () => Row(
                                children: contestController
                                    .upcomingFeaturedContest
                                    .map((contest) {
                                  String userId =
                                      controller.userDetailsData.sId ?? '';
                                  return Container(
                                    width: contestController
                                                .upcomingFeaturedContest
                                                .length ==
                                            1
                                        ? MediaQuery.of(context).size.width -
                                            MediaQuery.of(context).size.width *
                                                0.0637
                                        : MediaQuery.of(context).size.width -
                                            MediaQuery.of(context).size.width *
                                                0.1403,
                                    child: UpcomingFeaturedCard(
                                      userId: userId,
                                      upcomingFeatured: contest,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    contestController.liveContestList.isEmpty
                        ? Container()
                        : CommonTile(
                            label: 'Open TestZones',
                            showSeeAllButton: true,
                            onPressed: () {
                              contestController.loadData();
                              contestController.selectedTabBarIndex(0);
                              Get.to(() => ContestListView());
                            },
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                          ),
                    contestController.liveContestList.isEmpty
                        ? Container()
                        : SizedBox(
                            height: MediaQuery.of(context).size.width * 0.0306,
                          ),
                    contestController.liveContestList.isEmpty
                        ? Container()
                        : Obx(
                            () => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: contestController.liveContestList
                                    .map((contest) {
                                  String userId =
                                      controller.userDetailsData.sId ?? '';
                                  return Container(
                                    width: contestController
                                                .liveContestList.length ==
                                            1
                                        ? MediaQuery.of(context).size.width -
                                            MediaQuery.of(context).size.width *
                                                0.0637
                                        : MediaQuery.of(context).size.width -
                                            MediaQuery.of(context).size.width *
                                                0.1403,
                                    child: LiveContestCard(
                                      userId: userId,
                                      contest: contest,
                                      margin: contestController
                                                  .liveContestList.length ==
                                              1
                                          ? EdgeInsets.zero
                                          : EdgeInsets.only(right: 16),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                    if (contestController.liveContestList.isEmpty)
                      contestController.upComingContestList.isEmpty
                          ? Container()
                          : CommonTile(
                              label: 'Upcoming TestZones',
                              showSeeAllButton: true,
                              onPressed: () {
                                contestController.loadData();
                                contestController.selectedTabBarIndex(1);
                                Get.to(() => ContestListView());
                              },
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                            ),
                    if (contestController.liveContestList.isEmpty)
                      contestController.upComingContestList.isEmpty
                          ? Container()
                          : SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.0306,
                            ),
                    if (contestController.liveContestList.isEmpty)
                      contestController.upComingContestList.isEmpty
                          ? Container()
                          : Obx(
                              () => SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: contestController
                                      .upComingContestList
                                      .map((contest) {
                                    bool isVisible = contestController
                                        .isUpcomingContestVisible(contest);
                                    String userId =
                                        controller.userDetailsData.sId ?? '';
                                    return isVisible
                                        ? SizedBox()
                                        : Container(
                                            width: contestController
                                                        .upComingContestList
                                                        .length ==
                                                    1
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.0637
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.13200,
                                            child: UpComingContestCard(
                                              userId: userId,
                                              contest: contest,
                                              margin: contestController
                                                          .upComingContestList
                                                          .length ==
                                                      1
                                                  ? EdgeInsets.zero
                                                  : EdgeInsets.only(right: 16),
                                            ),
                                          );
                                  }).toList(),
                                ),
                              ),
                            ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    CommonTile(
                      label: 'Try TenX Subscription',
                      showSeeAllButton: true,
                      seeAllLabel: '',
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectedIndex(2);
                        Get.find<TenxTradingController>().loadData();
                      },
                      child: CommonCard(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        hasBorder: true,
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      AppImages.testZoneShareBackground,
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Color(0xFFFFF5E1).withOpacity(0.5),
                                      BlendMode.srcOver,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.all(14),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppImages.dartAppName,
                                          height: 20,
                                          width: 80,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "Introducing",
                                          style: AppStyles.tsBlackMedium18
                                              .copyWith(color: AppColors.white),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "TenX Subscription",
                                          style: AppStyles.tsBlackMedium18
                                              .copyWith(color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Subscribe Now",
                                              style: AppStyles.tsBlackRegular14
                                                  .copyWith(
                                                      color: AppColors.white),
                                            ),
                                            Icon(
                                              Icons.arrow_circle_right,
                                              color: Colors.green,
                                              size: 20.0,
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 0, // Adjust the position as needed
                                  right: 15, // Adjust the position as needed
                                  child: Container(
                                    height: 130,
                                    width: 150,
                                    child: Image.asset(
                                      AppImages.tenxLogo,
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    CommonTile(
                      label: 'Meet Our Champions',
                      showSeeAllButton: true,
                      seeAllLabel: 'Join TestZone',
                      onPressed: () {
                        contestController.loadData();
                        contestController.selectedTabBarIndex(0);
                        Get.to(() => ContestListView());
                      },
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                        () => Container(
                          child: Row(
                            children: contestController.contestChampionList
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              return CompletedContestChampionLeaderBoard(
                                index: index + 1,
                                contestdata: entry.value,
                                cardWidth: contestController
                                            .contestChampionList.length ==
                                        1
                                    ? MediaQuery.of(context).size.width -
                                        MediaQuery.of(context).size.width *
                                            0.0637
                                    : MediaQuery.of(context).size.width -
                                        MediaQuery.of(context).size.width *
                                            0.1403,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    CommonTile(
                      label: 'Return Summary',
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: customCard(
                                label: 'F&O',
                                percent: controller.userDashboardReturnSummary
                                            .value.virtualData?.npnl ==
                                        null
                                    ? '0'
                                    : '${(controller.userDashboardReturnSummary.value.virtualData!.npnl! / 10000).toStringAsFixed(2)} %',
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0306,
                            ),
                            Expanded(
                              child: customCard(
                                label: 'TestZones Trading',
                                percent: controller.userDashboardReturnSummary
                                            .value.contestReturn ==
                                        null
                                    ? '0'
                                    : '${(controller.userDashboardReturnSummary.value.contestReturn! * 100).toStringAsFixed(2)} %',
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
                              child: customCard(
                                label: 'TenX Trading',
                                percent: controller.userDashboardReturnSummary
                                            .value.tenxReturn ==
                                        null
                                    ? '0'
                                    : '${(controller.userDashboardReturnSummary.value.tenxReturn! * 100).toStringAsFixed(2)} %',
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0306,
                            ),
                            Expanded(
                              child: customCard(
                                label: 'Trading',
                                percent: '0%',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    CommonTile(
                      label: 'Performance',
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonDropdown(
                              useSeptValue: true,
                              getValue: controller.getProductName,
                              color: Theme.of(context).cardColor,
                              hint: 'Trading',
                              value: controller.selectedTradeType,
                              dropdownItems: controller.tradeTypes,
                              onChanged: (String? value) {
                                setState(
                                  () {
                                    controller.selectedTradeType = value ?? '';

                                    controller.getDashboard(
                                        controller.selectedTradeType,
                                        controller.selectedTimeFrame);
                                  },
                                );
                              }),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0306,
                        ),
                        Expanded(
                          child: CommonDropdown(
                            useSeptValue: true,
                            getValue: getProductMonth,
                            color: Theme.of(context).cardColor,
                            hint: 'Date',
                            value: controller.selectedTimeFrame,
                            dropdownItems: controller.timeFrames,
                            onChanged: (String? value) {
                              setState(
                                () {
                                  controller.selectedTimeFrame = value ?? '';

                                  controller.getDashboard(
                                      controller.selectedTradeType,
                                      controller.selectedTimeFrame);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Obx(
                      () {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: controller.selectedTradeType ==
                                              'virtual' ||
                                          controller.selectedTradeType == 'tenx'
                                      ? customCard(
                                          label: 'Market Days',
                                          percent: userDashboard
                                                      .totalMarketDays !=
                                                  null
                                              ? FormatHelper.formatNumbers(
                                                  userDashboard.totalMarketDays,
                                                  decimal: 0,
                                                  showSymbol: false,
                                                )
                                              : '0',
                                        )
                                      : customCard(
                                          label: 'Total TestZones',
                                          percent: userDashboard
                                                      .totalContests !=
                                                  null
                                              ? FormatHelper.formatNumbers(
                                                  userDashboard.totalContests,
                                                  decimal: 0,
                                                  showSymbol: false,
                                                )
                                              : '0',
                                        ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0306,
                                ),
                                Expanded(
                                  child: controller.selectedTradeType ==
                                              'virtual' ||
                                          controller.selectedTradeType == 'tenx'
                                      ? customCard(
                                          label: 'Trading Days',
                                          percent:
                                              userDashboard.totalTradingDays !=
                                                      null
                                                  ? FormatHelper.formatNumbers(
                                                      userDashboard
                                                          .totalTradingDays,
                                                      decimal: 0,
                                                      showSymbol: false,
                                                    )
                                                  : '0',
                                        )
                                      : customCard(
                                          label: 'TestZones Participated',
                                          percent: userDashboard
                                                      .participatedContests !=
                                                  null
                                              ? FormatHelper.formatNumbers(
                                                  userDashboard
                                                      .participatedContests,
                                                  decimal: 0,
                                                  showSymbol: false,
                                                )
                                              : '0',
                                          valueColor: AppColors.danger,
                                        ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.0204,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(
                                    label: 'Profit Days',
                                    percent: userDashboard.profitDays != null
                                        ? FormatHelper.formatNumbers(
                                            userDashboard.profitDays,
                                            decimal: 0,
                                            showSymbol: false,
                                          )
                                        : '0',
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0306,
                                ),
                                Expanded(
                                  child: customCard(
                                    label: 'Loss Days',
                                    percent: userDashboard.lossDays != null
                                        ? FormatHelper.formatNumbers(
                                            userDashboard.lossDays,
                                            decimal: 0,
                                            showSymbol: false,
                                          )
                                        : '0',
                                    valueColor: AppColors.danger,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.0204,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(
                                    label: 'Profit & Loss',
                                    percent: userDashboard.totalNPNL != null
                                        ? FormatHelper.formatNumbers(
                                            userDashboard.totalNPNL,
                                            decimal: 0,
                                          )
                                        : '0',
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0306,
                                ),
                                Expanded(
                                  child: customCard(
                                    label: 'Virtual Margin Money',
                                    percent: userDashboard.portfolio != null
                                        ? FormatHelper.formatNumbers(
                                            userDashboard.portfolio,
                                            decimal: 0,
                                          )
                                        : '0',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.0204,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(
                                    label: 'Max Profit',
                                    percent: userDashboard.maxProfit != null
                                        ? FormatHelper.formatNumbers(
                                            userDashboard.maxProfit,
                                            decimal: 0,
                                          )
                                        : '0',
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0306,
                                ),
                                Expanded(
                                  child: customCard(
                                    label: 'Max Loss',
                                    percent: userDashboard.maxLoss != null
                                        ? FormatHelper.formatNumbers(
                                            userDashboard.maxLoss,
                                            decimal: 0,
                                          )
                                        : '0',
                                    valueColor: AppColors.danger,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.0204,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(
                                    label: 'Avg. Profit',
                                    percent: userDashboard.averageProfit != null
                                        ? FormatHelper.formatNumbers(
                                            userDashboard.averageProfit,
                                            decimal: 0,
                                          )
                                        : '0',
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0306,
                                ),
                                Expanded(
                                  child: customCard(
                                    label: 'Avg. Loss',
                                    percent: userDashboard.averageLoss != null
                                        ? FormatHelper.formatNumbers(
                                            userDashboard.averageLoss,
                                            decimal: 0,
                                          )
                                        : '0',
                                    valueColor: AppColors.danger,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.0204,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: customCard(
                                    label: 'Max Wins Streak',
                                    percent:
                                        userDashboard.maxProfitStreak != null
                                            ? FormatHelper.formatNumbers(
                                                userDashboard.maxProfitStreak,
                                                decimal: 0,
                                                showSymbol: false,
                                              )
                                            : '0',
                                    valueColor: AppColors.success,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0306,
                                ),
                                Expanded(
                                  child: customCard(
                                    label: 'Max Loss Streak',
                                    percent: userDashboard.maxLossStreak != null
                                        ? FormatHelper.formatNumbers(
                                            userDashboard.maxLossStreak,
                                            decimal: 0,
                                            showSymbol: false,
                                          )
                                        : '0',
                                    valueColor: AppColors.danger,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.0306,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Refer & Win',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Rubik")),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.0102,
                                  ),
                                  Text('Bring your friends on StoxHero',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Rubik",
                                        color: Colors.grey,
                                      )),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.0306,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReferralsView()),
                                      );
                                    },
                                    child: Text(
                                      'Refer & Earn ${FormatHelper.formatNumbers(referralsController.activeReferrals.value?.rewardPerReferral, decimal: 0)}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors
                                          .lightGreen, // Background color
                                      foregroundColor:
                                          Colors.white, // Text color
                                      elevation: 8.0, // Elevation (shadow)
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Border radius
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 12.0), // Padding
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.153,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customCard({
    required String label,
    required String percent,
    Color? valueColor,
  }) {
    return CommonCard(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: EdgeInsets.zero,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.trending_up_rounded,
                color: AppColors.secondary,
                size: 16,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.tsRegular10,
                  ),
                  SizedBox(height: 4),
                  Text(
                    percent,
                    style: Theme.of(context).textTheme.tsMedium12.copyWith(
                          color: valueColor ??
                              (percent.startsWith('-')
                                  ? AppColors.danger
                                  : AppColors.success),
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WorkshopCard extends StatefulWidget {
  final InfluencerCourseData? courseData;

  const WorkshopCard({this.courseData});

  @override
  _WorkshopCardState createState() => _WorkshopCardState();
}

class _WorkshopCardState extends State<WorkshopCard> {
  late CourseController controller;
  late DateTime startTimeDateTime;
  late Duration remainingTime;
  late Timer timer;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CourseController>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateRemainingTime();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateRemainingTime() {
    DateTime currentTime = DateTime.now();
    startTimeDateTime =
        DateTime.parse(widget.courseData?.courseStartTime ?? '');

    setState(() {
      remainingTime = startTimeDateTime.isAfter(currentTime)
          ? startTimeDateTime.difference(currentTime)
          : Duration.zero;
      isVisible = remainingTime == Duration.zero;
    });

    timer = Timer.periodic(
      Duration(seconds: 1),
      (_) {
        if (mounted) {
          setState(
            () {
              remainingTime = startTimeDateTime.isAfter(DateTime.now())
                  ? startTimeDateTime.difference(DateTime.now())
                  : Duration.zero;
              // if (remainingTime == Duration.zero) {
              //   controller.getUserAllCourses();
              //    controller.getInfluencerPublishCourseDetails();
              // }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: CommonCard(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        borderRadius: 16,
        hasBorder: true,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.0714,
              right: MediaQuery.of(context).size.width * 0.0102,
              top: MediaQuery.of(context).size.width * 0.0510,
              bottom: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // height: MediaQuery.of(context).size.width * 0.100,

                  padding: EdgeInsets.only(
                      right: controller.userAllWorkshops.length == 1 ||
                              controller.publishInflunceCourseList.length == 1
                          ? MediaQuery.of(context).size.width * 0.100
                          : 0),

                  child: Text(
                    "${widget.courseData?.courseName ?? ''}",
                    style: Get.isDarkMode
                        ? AppStyles.tsWhiteMedium14
                        : AppStyles.tsBlackMedium14,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0102),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${FormatHelper.formatDateTimeToIST(widget.courseData?.courseStartTime ?? '')}",
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteRegular14
                                    : AppStyles.tsGreyRegular14,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${(widget.courseData?.maxEnrolments ?? 0) - (widget.courseData?.userEnrolled ?? 0)} ",
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteRegular14
                                    : AppStyles.tsGreyRegular14,
                              ),
                              Text(
                                "Seats Left,",
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteMedium12
                                    : AppStyles.tsGreyMedium12,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0102,
                              ),
                              Text(
                                "${widget.courseData?.courseLanguages ?? ''}",
                                style: Get.isDarkMode
                                    ? AppStyles.tsWhiteRegular14
                                    : AppStyles.tsGreyRegular14,
                              )
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.47,
                            child: DateTime.now().isBefore(DateTime.parse(
                                    widget.courseData?.courseStartTime ?? ''))
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${remainingTime.inDays}D ${remainingTime.inHours.remainder(24)}H ${remainingTime.inMinutes.remainder(60)}M ${remainingTime.inSeconds.remainder(60)}S',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                : (widget.courseData?.isPaid == true
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Happening Now, Please Join",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "Happening Now, Please Register",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                          ),

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.0306),
                          if (widget.courseData?.isPaid == false) ...{
                            GestureDetector(
                              onTap: () {
                                controller.getUserCourseOverviewDetails(
                                    widget.courseData?.sId ?? '');
                                Get.to(
                                    () => BatchDetailsView(widget.courseData));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Register Now",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: 1.5,
                                        color: AppColors.lightGreen),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.0102,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right,
                                    color: AppColors.lightGreen,
                                    size: 20.0,
                                  )
                                ],
                              ),
                            ),
                          } else ...{
                            if (DateTime.now().isAfter(DateTime.parse(
                                widget.courseData?.courseStartTime ?? ''))) ...{
                              GestureDetector(
                                onTap: () async {
                                  final googleMeetUrl =
                                      '${widget.courseData?.meetLink ?? ''}';

                                  // Check if the URL can be launched
                                  if (await canLaunch(googleMeetUrl)) {
                                    // Launch the URL
                                    await launch(googleMeetUrl);
                                  } else {
                                    // Handle error if URL cannot be launched
                                    SnackbarHelper.showSnackbar(
                                        'Could not launch Google Meet');
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Join Now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: 1.5,
                                          color: AppColors.lightGreen),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.0102,
                                    ),
                                    Icon(
                                      Icons.arrow_circle_right,
                                      color: AppColors.lightGreen,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                              ),
                            } else if (DateTime.now().isAfter(DateTime.parse(
                                widget.courseData?.courseEndTime ?? ''))) ...{
                              GestureDetector(
                                onTap: () async {
                                  SnackbarHelper.showSnackbar(
                                      'The workshop has ended. The recorded content will be made available soon');
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Join Now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: 1.5,
                                          color: AppColors.lightGreen),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.0102,
                                    ),
                                    Icon(
                                      Icons.arrow_circle_right,
                                      color: AppColors.lightGreen,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                              ),
                            } else ...{
                              GestureDetector(
                                onTap: () {
                                  SnackbarHelper.showSnackbar(
                                      "Workshop will start on ${FormatHelper.formatDateTimeOnlyToIST(widget.courseData?.courseStartTime ?? "")}");
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Join Now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: 1.5,
                                          color: AppColors.lightGreen),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.0102,
                                    ),
                                    Icon(
                                      Icons.arrow_circle_right,
                                      color: AppColors.lightGreen,
                                      size: 20.0,
                                    )
                                  ],
                                ),
                              ),
                            }
                          },
                          // SizedBox(
                          //     height:
                          //         MediaQuery.of(context).size.width * 0.0510),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: controller.userAllWorkshops.length == 1 ||
                                controller.publishInflunceCourseList.length == 1
                            ? MediaQuery.of(context).size.width * 0.060
                            : 0),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.286,
                          height: MediaQuery.of(context).size.width * 0.266,
                          // padding: EdgeInsets.only(
                          //     right:
                          //         MediaQuery.of(context).size.width * 0.0102),
                          child: ClipRRect(
                            clipBehavior: Clip.none,
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                            child: widget.courseData?.instructorImage == null
                                ? Image.asset(
                                    AppImages.workshopInst,
                                    width: MediaQuery.of(context).size.width *
                                        0.286,
                                    height: MediaQuery.of(context).size.width *
                                        0.256,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    '${widget.courseData?.instructorImage ?? ''}',
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width *
                                        0.286,
                                    height: MediaQuery.of(context).size.width *
                                        0.256,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
