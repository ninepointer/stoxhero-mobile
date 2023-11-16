import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import '../../../app/app.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late HomeController controller;
  late ContestController contestController;
  late CollegeContestController collegeContestController;
  late List<String> monthsList;

  String? selectedValue2 = '';

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeController>();
    contestController = Get.find<ContestController>();
    collegeContestController = Get.find<CollegeContestController>();
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
    if (label == 'last month') name = DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - 1));
    if (label == 'lifetime') name = 'Lifetime';
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final userDashboard = controller.userDashboard.value;

    return Scaffold(
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.loadData,
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
                                        contest: contest,
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
                                      width: MediaQuery.of(context).size.width,
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
                                      width: MediaQuery.of(context).size.width,
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
                  //                   contest: contest,
                  //                 ),
                  //               );
                  //             }).toList(),
                  //           ),
                  //         ),
                  //       ),
                  contestController.liveContestList.isEmpty
                      ? Container()
                      : CommonTile(
                          label: 'Live Contests',
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
                                  width: MediaQuery.of(context).size.width,
                                  child: LiveContestCard(
                                    userId: userId,
                                    contest: contest,
                                    margin: EdgeInsets.all(8).copyWith(bottom: 0),
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
                            label: 'Upcoming Contests',
                            showSeeAllButton: true,
                            onPressed: () {
                              contestController.loadData();
                              contestController.selectedTabBarIndex(1);
                              Get.to(() => ContestListView());
                            },
                            margin: EdgeInsets.only(bottom: 0, top: 8),
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
                                          width: MediaQuery.of(context).size.width,
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
                  SizedBox(height: 8),
                  CommonTile(
                    label: 'Return Summary',
                    margin: EdgeInsets.only(bottom: 8, top: 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: customCard(
                                label: 'Virtual Trading',
                                percent: controller.userDashboardReturnSummary.value.virtualData?.npnl == null
                                    ? '0'
                                    : '${(controller.userDashboardReturnSummary.value.virtualData!.npnl! / 10000).toStringAsFixed(2)} %',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: customCard(
                                label: 'Contest Trading',
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
                  CommonTile(label: 'Performance'),
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
                                      label: 'Total \nContests',
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
                                      label: 'Contests Participated',
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
                                label: 'Portfolio',
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
                        SizedBox(height: 100),
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
                    style: Theme.of(context).textTheme.tsRegular12,
                  ),
                  SizedBox(height: 4),
                  Text(
                    percent,
                    style: Theme.of(context).textTheme.tsMedium14.copyWith(
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
