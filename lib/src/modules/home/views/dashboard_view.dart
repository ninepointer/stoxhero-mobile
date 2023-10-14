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
  late List<String> monthsList;

  String? selectedValue2 = '';

  @override
  void initState() {
    controller = Get.find<HomeController>();
    contestController = Get.find<ContestController>();
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
    super.initState();
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
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
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
                          CommonStockInfo(
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
                      autoPlayInterval: const Duration(seconds: 6),
                    ),
                  ),
                ),
                CommonTile(
                  label: 'Live Contests',
                  showSeeAllButton: true,
                  onPressed: () => Get.to(() => ContestListView()),
                  margin: EdgeInsets.only(bottom: 0, top: 8),
                ),
                contestController.liveContestList.isEmpty
                    ? NoDataFound(label: 'No Live Contests')
                    : SizedBox(
                        height: contestController.liveContestList.length >= 1
                            ? 250
                            : contestController.liveContestList.length * 120,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: contestController.liveContestList.length,
                          itemBuilder: (context, index) {
                            return LiveContestCard(
                              contest: contestController.liveContestList[index],
                            );
                          },
                        ),
                      ),
                CommonTile(
                  label: 'Upcoming Contests',
                  showSeeAllButton: true,
                  onPressed: () => Get.to(() => ContestListView()),
                  margin: EdgeInsets.only(bottom: 0, top: 8),
                ),
                contestController.upComingContestList.isEmpty
                    ? NoDataFound(label: 'No Upcoming Contests')
                    : SizedBox(
                        height: contestController.upComingContestList.length >= 1
                            ? 250
                            : contestController.upComingContestList.length * 120,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: contestController.upComingContestList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return UpComingContestCard(
                              contest: contestController.upComingContestList[index],
                            );
                          },
                        ),
                      ),
                SizedBox(height: 12),
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
                              percent: '${FormatHelper.formatNumbers(
                                controller.userDashboardReturnSummary.value.tenxReturn,
                                showSymbol: false,
                              )} %',
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
                                controller.selectedTradeType = value!;
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
                                controller.selectedTimeFrame = value!;
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
                          SizedBox(width: 4),
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
                          SizedBox(width: 4),
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
                          SizedBox(width: 4),
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
                          SizedBox(width: 4),
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
                          SizedBox(width: 4),
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
                          SizedBox(width: 4),
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
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
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
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.trending_up_rounded,
                color: AppColors.secondary,
                size: 18,
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
