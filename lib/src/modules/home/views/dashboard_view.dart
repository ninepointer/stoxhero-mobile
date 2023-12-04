import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../app/app.dart';
import '../../../modules/contest/views/competed_contest_champion_Leaderboard.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late HomeController controller;
  late ContestController contestController;
  late CollegeContestController collegeContestController;
  late ContestProfileController contestProfileController;
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
    contestProfileController.loadData();
    contestController.getPaidContestChampionList();

    referralsController = Get.find<ReferralsController>();
    referralsController.loadData();
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMMM yyyy').format(now);
    String previousMonth = DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - 1));
    String nextMonth = DateFormat('MMMM yyyy').format(DateTime(now.year, now.month + 1));

    monthsList = [
      previousMonth,
      currentMonth,
      nextMonth,
    ];
    selectedValue2 = currentMonth;
  }

  String getProductMonth(String? label) {
    String name = '';
    DateTime now = DateTime.now();
    if (label == 'this month') name = DateFormat('MMMM yyyy').format(now);
    if (label == 'last month')
      name = DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - 1));

    if (label == 'lifetime') name = 'Lifetime';
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final userDashboard = controller.userDashboard.value;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.stockIndexDetailsList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var item in controller.stockIndexDetailsList) ...[
                            TradingStockCard(
                              label: controller.getStockIndexName(item.instrumentToken ?? 0),
                              stockPrice: FormatHelper.formatNumbers(
                                item.lastPrice,
                              ),
                              stockColor: controller.getValueColor(
                                item.lastPrice! - (item.ohlc?.close ?? 0),
                              ),
                              stockLTP: FormatHelper.formatNumbers(
                                item.lastPrice! - (item.ohlc?.close ?? 0),
                              ),
                              stockChange: '(${item.change?.toStringAsFixed(2)}%)',
                              stockLTPColor: controller.getValueColor(
                                item.lastPrice! - (item.ohlc?.close ?? 0),
                              ),
                            ),
                            if (item != controller.stockIndexDetailsList.last) SizedBox(width: 4),
                          ]
                        ],
                      ),
                    ),
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: CarouselSlider.builder(
                      itemCount: controller.dashboardCarouselList.length,
                      itemBuilder: (context, int index, _) {
                        return GestureDetector(
                          onTap: () => controller.navigateToCarousel(
                            controller.dashboardCarouselList[index].linkToCarousel ?? '',
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "${controller.dashboardCarouselList[index].carouselImage}",
                                fit: BoxFit.fill,
                                width: double.infinity,
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
                  if (contestProfileController.startOfWeek.value != "" &&
                      contestProfileController.endOfWeek.value != "")
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
                        contestProfileController.getWeeklyTopPerformerFullList();
                        Get.to(() => ContestTopPerformerCard());
                      },
                      margin: EdgeInsets.only(bottom: 0, top: 8),
                    ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Container(
                        child: Row(
                          children: contestProfileController.weeklyTopPerformer.asMap().entries.map((entry) {
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

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        contestController.featuredCollegeContest.isEmpty
                            ? Container()
                            : Obx(
                                () => Row(
                                  children: contestController.featuredCollegeContest.map((contest) {
                                    String userId = controller.userDetailsData.sId ?? '';
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
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
                                  children: contestController.liveFeaturedContest.map((contest) {
                                    String userId = controller.userDetailsData.sId ?? '';
                                    return Container(
                                      width: MediaQuery.of(context).size.width - 30,
                                      child: LiveFeaturedCard(
                                        userId: userId,
                                        liveFeatured: contest,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                        contestController.upcomingFeaturedContest.isEmpty
                            ? Container()
                            : Obx(
                                () => Row(
                                  children: contestController.upcomingFeaturedContest.map((contest) {
                                    String userId = controller.userDetailsData.sId ?? '';
                                    return Container(
                                      width: MediaQuery.of(context).size.width - 25,
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

                  // collegeContestController.liveCollegeContestList.isEmpty
                  //     ? Container()
                  //     : Obx(
                  //         () => SingleChildScrollView(
                  //           scrollDirection: Axis.horizontal,
                  //           child: Row(
                  //             children: collegeContestController.liveCollegeContestList.map((contest) {
                  //               String userId = controller.userDetailsData.sId ?? '';
                  //               return Container(
                  //                 width: MediaQuery.of(context).size.width,
                  //                 child: CollegeContestCard(
                  //                   userId: userId,
                  //                   featuredCollegeContest: contest,
                  //                 ),
                  //               );
                  //             }).toList(),
                  //           ),
                  //         ),
                  //       ),
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
                          margin: EdgeInsets.only(bottom: 0, top: 8),
                        ),
                  contestController.liveContestList.isEmpty
                      ? Container()
                      : Obx(
                          () => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: contestController.liveContestList.map((contest) {
                                String userId = controller.userDetailsData.sId ?? '';
                                return Container(
                                  width: MediaQuery.of(context).size.width - 25,
                                  child: LiveContestCard(
                                    userId: userId,
                                    contest: contest,
                                    margin: EdgeInsets.all(8).copyWith(bottom: 0, left: 11),
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
                            margin: EdgeInsets.only(bottom: 0, top: 6),
                          ),
                  if (contestController.liveContestList.isEmpty)
                    contestController.upComingContestList.isEmpty
                        ? Container()
                        : Obx(
                            () => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: contestController.upComingContestList.map((contest) {
                                  bool isVisible = contestController.isUpcomingContestVisible(contest);
                                  String userId = controller.userDetailsData.sId ?? '';
                                  return isVisible
                                      ? SizedBox()
                                      : Container(
                                          width: MediaQuery.of(context).size.width - 20,
                                          child: UpComingContestCard(
                                            userId: userId,
                                            contest: contest,
                                            margin: EdgeInsets.all(8).copyWith(bottom: 0),
                                          ),
                                        );
                                }).toList(),
                              ),
                            ),
                          ),
                  SizedBox(
                    height: 10,
                  ),
                  CommonTile(
                    label: 'Meet Our Champions',
                    showSeeAllButton: true,
                    seeAllLabel: 'Join TestZone',
                    onPressed: () {
                      contestController.liveContestList();
                      contestController.loadData();
                      contestController.liveContest();
                      Get.to(() => ContestListView());
                    },
                    margin: EdgeInsets.only(bottom: 0, top: 6),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Container(
                        child: Row(
                          children: contestController.contestChampionList.asMap().entries.map((entry) {
                            int index = entry.key;
                            return CompletedContestChampionLeaderBoard(
                              index: index + 1,
                              contestdata: entry.value,
                              cardWidth: MediaQuery.of(context).size.width - 40,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Container(
                  //     margin: EdgeInsets.zero,
                  //     child: Row(
                  //       children: contestController.contestChampionList
                  //           .asMap()
                  //           .entries
                  //           .map((entry) {
                  //         int index = entry.key;
                  //         return CompletedContestChampionLeaderBoard(
                  //           index: index + 1,
                  //           contestdata: entry.value,
                  //           cardWidth: MediaQuery.of(context).size.width - 40,
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),

                  SizedBox(height: 10),
                  CommonTile(
                    label: 'Return Summary',
                    margin: EdgeInsets.only(bottom: 10, top: 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: customCard(
                                label: 'F&O',
                                percent: controller.userDashboardReturnSummary.value.virtualData?.npnl == null
                                    ? '0'
                                    : '${(controller.userDashboardReturnSummary.value.virtualData!.npnl! / 10000).toStringAsFixed(2)} %',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: customCard(
                                label: 'TestZones Trading',
                                percent: controller.userDashboardReturnSummary.value.contestReturn == null
                                    ? '0'
                                    : '${(controller.userDashboardReturnSummary.value.contestReturn! * 100).toStringAsFixed(2)} %',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: customCard(
                                label: 'TenX Trading',
                                percent: controller.userDashboardReturnSummary.value.tenxReturn == null
                                    ? '0'
                                    : '${(controller.userDashboardReturnSummary.value.tenxReturn! * 100).toStringAsFixed(2)} %',
                              ),
                            ),
                            SizedBox(width: 8),
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
                  ),

                  CommonTile(
                    label: 'Performance',
                    margin: EdgeInsets.symmetric(vertical: 8),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
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
                            },
                          ),
                        ),
                        SizedBox(width: 4),
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
                                  controller.getDashboard(controller.selectedTradeType, controller.selectedTimeFrame);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: controller.selectedTradeType == 'virtual'
                                  ? customCard(
                                      label: 'Market Days',
                                      percent: userDashboard.totalMarketDays != null
                                          ? FormatHelper.formatNumbers(
                                              userDashboard.totalMarketDays,
                                              decimal: 0,
                                              showSymbol: false,
                                            )
                                          : '0',
                                    )
                                  : customCard(
                                      label: 'Total TestZones',
                                      percent: userDashboard.totalContests != null
                                          ? FormatHelper.formatNumbers(
                                              userDashboard.totalContests,
                                              decimal: 0,
                                              showSymbol: false,
                                            )
                                          : '0',
                                    ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: controller.selectedTradeType == 'virtual'
                                  ? customCard(
                                      label: 'Trading Days',
                                      percent: userDashboard.totalTradingDays != null
                                          ? FormatHelper.formatNumbers(
                                              userDashboard.totalTradingDays,
                                              decimal: 0,
                                              showSymbol: false,
                                            )
                                          : '0',
                                    )
                                  : customCard(
                                      label: 'TestZones Participated',
                                      percent: userDashboard.participatedContests != null
                                          ? FormatHelper.formatNumbers(
                                              userDashboard.participatedContests,
                                              decimal: 0,
                                              showSymbol: false,
                                            )
                                          : '0',
                                      valueColor: AppColors.danger,
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
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
                            SizedBox(width: 8),
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
                        SizedBox(height: 8),
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
                            SizedBox(width: 8),
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
                        SizedBox(height: 8),
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
                            SizedBox(width: 8),
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
                        SizedBox(height: 8),
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
                            SizedBox(width: 8),
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
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: customCard(
                                label: 'Max Wins Streak',
                                percent: userDashboard.maxProfitStreak != null
                                    ? FormatHelper.formatNumbers(
                                        userDashboard.maxProfitStreak,
                                        decimal: 0,
                                        showSymbol: false,
                                      )
                                    : '0',
                                valueColor: AppColors.success,
                              ),
                            ),
                            SizedBox(width: 8),
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
                          height: 16,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Refer & Win',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, fontFamily: "Rubik")),
                              SizedBox(
                                height: 4,
                              ),
                              Text('Bring your friends on StoxHero',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Rubik",
                                    color: Colors.grey,
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ReferralsView()),
                                  );
                                },
                                child: Text(
                                  'Refer & Earn ${FormatHelper.formatNumbers(referralsController.activeReferrals.value?.rewardPerReferral, decimal: 0)}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.lightGreen, // Background color
                                  foregroundColor: Colors.white, // Text color
                                  elevation: 8.0, // Elevation (shadow)
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Border radius
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0), // Padding
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                ],
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
                          color: valueColor ?? (percent.startsWith('-') ? AppColors.danger : AppColors.success),
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
