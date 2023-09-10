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
            SizedBox(height: 24),
            Container(
              child: CarouselSlider.builder(
                itemCount: controller.dashboardCarouselList.length,
                itemBuilder: (context, int index, realIndex) {
                  // var urlImage = controller.dashboardCarouselList[index];
                  log('Image: ${controller.dashboardCarouselList[index]}');
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
            customCard(label: 'Virtual Trading', percent: ''),
            customCard(label: 'Contest Trading', percent: ''),
            customCard(label: 'TenX Trading', percent: '0.0%'),
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
            SizedBox(height: 8),
            Column(
              children: [
                customCard(label: 'Market Days ', percent: '${dashboard?.totalMarketDays}'),
                customCard(label: 'Trading Days ', percent: '${dashboard?.totalTradingDays}'),
                customCard(label: 'Profit & Loss ', percent: '${dashboard?.profitDays}'),
                customCard(label: 'Portfolio ', percent: '${dashboard?.portfolio}'),
                customCard(label: 'Max Profit', percent: '${dashboard?.maxProfit}'),
                customCard(label: 'Max Loss', percent: '${dashboard?.maxLoss}'),
                customCard(label: 'Wins ', percent: '${dashboard?.maxProfitDay}'),
                customCard(label: 'Loss ', percent: '${dashboard?.maxLossDay}'),
                customCard(label: 'Avg. Profit ', percent: '${dashboard?.averageProfit}'),
                customCard(label: 'Avg. Loss ', percent: '${dashboard?.averageLoss}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customCard({
    required String label,
    required String percent,
  }) {
    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.tsRegular16,
                  ),
                  Text(
                    percent,
                    style: Theme.of(context).textTheme.tsMedium16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
