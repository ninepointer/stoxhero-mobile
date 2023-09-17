import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late HomeController controller;
  late ContestController contestController;

  String? selectedValue1;
  String? selectedValue2;

  List<String> dropdownItems1 = ['Virtual Trading', 'Contest Trading', 'TenX Trading'];
  List<String> dropdownItems2 = ['Aug 23', 'July 23', 'Lifetime'];

  @override
  void initState() {
    controller = Get.find<HomeController>();
    contestController = Get.find<ContestController>();
    super.initState();
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
                Row(
                  children: [
                    CommonStockInfo(
                      label: 'Nifty 50',
                      stockPrice: '₹19,454',
                      stockLTP: '₹183.15',
                      stockChange: '(+34.42%)',
                    ),
                    CommonStockInfo(
                      label: 'Bank Nifty',
                      stockPrice: '₹19,454',
                      stockLTP: '₹183.15',
                      stockChange: '(+34.42%)',
                    ),
                    CommonStockInfo(
                      label: 'Finnifty',
                      stockPrice: '₹19,454',
                      stockLTP: '₹183.15',
                      stockChange: '(+34.42%)',
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  child: CarouselSlider.builder(
                    itemCount: controller.dashboardCarouselList.length,
                    itemBuilder: (context, int index, realIndex) {
                      return Container(
                        color: AppColors.white,
                        child: Image.network(
                          "${controller.dashboardCarouselList[index].carouselImage}",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 180,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 6),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                CommonTile(
                  label: 'Upcoming Contest',
                  showSeeAllButton: true,
                  onPressed: () {
                    Get.to(() => ContestListView());
                  },
                  margin: EdgeInsets.zero,
                ),
                contestController.upComingContestList.isEmpty
                    ? NoDataFound(label: 'No Upcoming Contest')
                    : SizedBox(
                        height: contestController.upComingContestList.length >= 1
                            ? 350
                            : contestController.upComingContestList.length * 150,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: contestController.upComingContestList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return UpComingContestCard(
                              upComingContest: contestController.upComingContestList[index],
                            );
                          },
                        ),
                      ),
                SizedBox(height: 12),
                CommonTile(
                  label: 'Live Contest',
                  showSeeAllButton: true,
                  onPressed: () => Get.to(() => ContestListView()),
                ),
                contestController.liveContestList.isEmpty
                    ? NoDataFound(label: 'No Live Contest')
                    : SizedBox(
                        height: contestController.liveContestList.length >= 1
                            ? 350
                            : contestController.liveContestList.length * 150,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: contestController.liveContestList.length,
                          itemBuilder: (context, index) {
                            return LiveContestCard(
                              liveContest: contestController.liveContestList[index],
                            );
                          },
                        ),
                      ),
                SizedBox(height: 12),
                CommonTile(label: 'Return Summary'),
                summaryCard(
                  label: 'Virtual Trading',
                  percent: '${FormatHelper.formatNumbers(
                    controller.userDashboardReturnSummary.value.tenxReturn,
                    showSymbol: false,
                  )} %',
                ),
                summaryCard(
                  label: 'Contest Trading',
                  percent: '${FormatHelper.formatNumbers(
                    controller.userDashboardReturnSummary.value.contestReturn,
                    showSymbol: false,
                  )} %',
                ),
                summaryCard(
                  label: 'TenX Trading',
                  percent: '${FormatHelper.formatNumbers(
                    controller.userDashboardReturnSummary.value.tenxReturn,
                    showSymbol: false,
                  )} %',
                ),
                CommonTile(label: 'Performance'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonDropdown(
                          color: Theme.of(context).cardColor,
                          hint: 'Trading',
                          value: selectedValue1,
                          dropdownItems: dropdownItems1,
                          onChanged: (String? value) => setState(() {
                            selectedValue1 = value!;
                          }),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: CommonDropdown(
                          color: Theme.of(context).cardColor,
                          hint: 'Date',
                          value: selectedValue2,
                          dropdownItems: dropdownItems2,
                          onChanged: (String? value) => setState(
                            () => selectedValue2 = value!,
                          ),
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
                            child: customCard(
                              label: 'Market Days',
                              percent: userDashboard.totalMarketDays != null
                                  ? FormatHelper.formatNumbers(
                                      userDashboard.totalMarketDays,
                                      decimal: 0,
                                      showSymbol: false,
                                    )
                                  : 'null',
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: customCard(
                              label: 'Trading Days',
                              percent: userDashboard.totalTradingDays != null
                                  ? FormatHelper.formatNumbers(
                                      userDashboard.totalTradingDays,
                                      decimal: 0,
                                      showSymbol: false,
                                    )
                                  : 'null',
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
                                  : 'null',
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
                                  : 'null',
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
                                  : 'null',
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
                                  : 'null',
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
                                  : 'null',
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
                                  : 'null',
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
                                  : 'null',
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
                                  : 'null',
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
                                  : 'null',
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
                                  : 'null',
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
                    style: Theme.of(context).textTheme.tsRegular16,
                  ),
                  SizedBox(height: 4),
                  Text(
                    percent,
                    style: Theme.of(context).textTheme.tsMedium16.copyWith(
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

  Widget summaryCard({
    required String label,
    required String percent,
  }) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8).copyWith(right: 4),
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.tsGreyRegular12,
                  ),
                  SizedBox(height: 2),
                  Text(
                    percent,
                    style: Theme.of(context)
                        .textTheme
                        .tsMedium16
                        .copyWith(color: percent.startsWith('-') ? AppColors.danger : AppColors.success),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}
