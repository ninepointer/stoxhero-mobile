import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late HomeController controller;
  Dashboard? dashboard;
  String? selectedValue1;
  String? selectedValue2;

  List<String> dropdownItems1 = ['Virtual Trading', 'Contest Trading', 'TenX Trading'];
  List<String> dropdownItems2 = ['Aug 23', 'July 23', 'Lifetime'];

  @override
  void initState() {
    controller = Get.find<HomeController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            SizedBox(height: 16),
            Obx(
              () => Container(
                child: controller.dashboardCarouselList.isEmpty
                    ? NoDataFound()
                    : CarouselSlider.builder(
                        itemCount: controller.dashboardCarouselList.length,
                        itemBuilder: (context, int index, realIndex) {
                          // var urlImage = controller.dashboardCarouselList[index];
                          log('Image: ${controller.dashboardCarouselList[index]}');
                          return Container(
                            height: 180,
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Image.network(
                              "${controller.dashboardCarouselList[index].carouselImage}",
                              fit: BoxFit.contain,
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
            ),
            CommonTile(
              label: 'Upcoming Contest',
              showSeeAllButton: true,
              onPressed: () {
                Get.to(() => ContestListView());
              },
            ),
            UpComingContestCard(),
            SizedBox(height: 12),
            CommonTile(
              label: 'Ongoing Contest',
              showSeeAllButton: true,
              onPressed: () {
                Get.to(() => ContestListView());
              },
            ),
            LiveContestCard(),
            SizedBox(height: 12),
            CommonTile(label: 'Return Summary'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: customCard(
                          label: 'Virtual Trading',
                          percent: '-',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: customCard(
                          label: 'Contest Trading',
                          percent: '-',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customCard(
                          label: 'TenX Trading',
                          percent: '0.0%',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: customCard(
                          label: 'MarginX Trading',
                          percent: '0.0%',
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
                      color: Theme.of(context).cardColor,
                      hint: 'Trading',
                      value: selectedValue1,
                      dropdownItems: dropdownItems1,
                      onChanged: (String? value) => setState(
                        () => selectedValue1 = value!,
                      ),
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
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: customCard(
                          label: 'Market Days',
                          percent: '${dashboard?.totalMarketDays ?? '-'}',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: customCard(
                          label: 'Trading Days',
                          percent: '${dashboard?.totalTradingDays ?? '-'}',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customCard(
                          label: 'Profit & Loss',
                          percent: '${dashboard?.profitDays ?? '-'}',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: customCard(
                          label: 'Portfolio',
                          percent: '${dashboard?.portfolio ?? '-'}',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customCard(
                          label: 'Max Profit',
                          percent: '${dashboard?.maxProfit ?? '-'}',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: customCard(
                          label: 'Max Loss',
                          percent: '${dashboard?.maxLoss ?? '-'}',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customCard(
                          label: 'Wins',
                          percent: '${dashboard?.maxProfitDay ?? '-'}',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: customCard(
                          label: 'Loss',
                          percent: '${dashboard?.maxLossDay ?? '-'}',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customCard(
                          label: 'Avg. Profit',
                          percent: '${dashboard?.averageProfit ?? '-'}',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: customCard(
                          label: 'Avg. Loss',
                          percent: '${dashboard?.averageLoss ?? '-'}',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  Widget customCard({
    required String label,
    required String? percent,
  }) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8).copyWith(right: 4),
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
                    percent ?? '-',
                    style: Theme.of(context).textTheme.tsMedium18,
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
