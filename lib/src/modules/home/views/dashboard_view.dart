import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:stoxhero/src/core/widgets/common_stock_info.dart';

import '../../../core/core.dart';
import '../../contest/contest_index.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final urlImages = [
    'https://dmt-trade.s3.ap-south-1.amazonaws.com/carousels/Hiring%20Interns/photos/1691157992025Blue%20Yellow%20Simple%20Internship%20Program%20Recruitment%20Instagram%20Post.png',
    'https://dmt-trade.s3.ap-south-1.amazonaws.com/carousels/Virtual%20Trading/photos/1688140457985Carousel%203.png',
    'https://dmt-trade.s3.ap-south-1.amazonaws.com/carousels/Daily%20Trading%20Contest%20/photos/1688140620115Carousel%204.png',
    'https://dmt-trade.s3.ap-south-1.amazonaws.com/carousels/Hiring%20Interns/photos/1691157992025Blue%20Yellow%20Simple%20Internship%20Program%20Recruitment%20Instagram%20Post.png',
  ];
  String selectedValue1 = 'Virtual Trading';
  String selectedValue2 = 'Aug 23';

  List<String> dropdownItems1 = ['Virtual Trading', 'Contest Trading', 'TenX Trading'];
  List<String> dropdownItems2 = ['Aug 23', 'July 23', 'Lifetime'];

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
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];
                  return Container(
                    color: AppColors.white,
                    child: Image.network(
                      urlImage,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Contest',
                    style: Theme.of(context).textTheme.tsMedium16,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.find<ContestController>().loadData();
                      Get.to(
                        () => ContestListView(),
                      );
                    },
                    child: Text('See All'),
                  ),
                ],
              ),
            ),
            UpComingContestCard(),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ongoing Contest',
                    style: Theme.of(context).textTheme.tsMedium16,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See All'),
                  ),
                ],
              ),
            ),
            OnGoingContestCard(),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Return Summary',
                style: Theme.of(context).textTheme.tsMedium16,
              ),
            ),
            SizedBox(height: 12),
            customCard(label: 'Virtual Trading', percent: '0.0%'),
            customCard(label: 'Contest Trading', percent: '0.0%'),
            customCard(label: 'TenX Trading', percent: '0.0%'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Performance',
                style: Theme.of(context).textTheme.tsMedium16,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomDropdown(
                items: dropdownItems1,
                selectedValue: selectedValue1,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue1 = newValue!;
                  });
                },
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomDropdown(
                items: dropdownItems2,
                selectedValue: selectedValue2,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue2 = newValue!;
                  });
                },
              ),
            ),
            SizedBox(height: 12),
            Column(
              children: [
                customCard(label: 'Market Days ', percent: '4'),
                customCard(label: 'Trading Days ', percent: '4'),
                customCard(label: 'Profit & Loss ', percent: '4'),
                customCard(label: 'Portfolio ', percent: '4'),
                customCard(label: 'Max Profit', percent: '4'),
                customCard(label: 'Max Loss', percent: '4'),
                customCard(label: 'Wins ', percent: '4'),
                customCard(label: 'Loss ', percent: '4'),
                customCard(label: 'Avg. Profit ', percent: '4'),
                customCard(label: 'Avg. Loss ', percent: '4'),
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
      padding: EdgeInsets.zero,
      margin: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        ListTile(
          minLeadingWidth: 0,
          leading: Container(
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(.25),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              AppImages.contestReward,
              width: 30,
              height: 30,
            ),
          ),
          title: Text(
            label,
            style: Theme.of(context).textTheme.tsRegular16,
          ),
          trailing: Text(
            percent,
            style: Theme.of(context).textTheme.tsMedium16,
          ),
        ),
      ],
    );
  }

  Widget contestCard() {
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  // contestDetails?.contestName ?? '-',
                  'Tuesday Wars',
                  style: AppStyles.tsSecondaryMedium16,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Nifty',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Bank Nifty',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Day',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 1, height: 0),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No. of Seats left',
                          style: Theme.of(context).textTheme.tsRegular14,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '23',
                          style: Theme.of(context).textTheme.tsMedium16,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        AppImages.contestTrophy,
                        width: 40,
                      ),
                      Text(
                        'Reward',
                        style: Theme.of(context).textTheme.tsRegular14,
                      ),
                      Text(
                        '0.5% of the net P&L',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Remaining',
                          style: Theme.of(context).textTheme.tsRegular14,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '00:00:00',
                          style: Theme.of(context).textTheme.tsMedium16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date & Time',
                        style: Theme.of(context).textTheme.tsRegular14,
                      ),
                      SizedBox(height: 4),
                      // Text(
                      //   FormatHelper.formatDateTimeToIST(contestDetails?.contestStartTime),
                      //  style: Theme.of(context).textTheme.tsMedium16,
                      // ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'End Date & Time',
                        style: Theme.of(context).textTheme.tsRegular14,
                      ),
                      SizedBox(height: 4),
                      // Text(
                      //   FormatHelper.formatDateTimeToIST(contestDetails?.contestEndTime),
                      // style: Theme.of(context).textTheme.tsMedium16,

                      // ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entry Fees',
                        style: Theme.of(context).textTheme.tsRegular14,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Free',
                        style: Theme.of(context).textTheme.tsMedium16,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Portfolio',
                        style: Theme.of(context).textTheme.tsRegular14,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '₹ 5,00,000',
                        style: Theme.of(context).textTheme.tsMedium16,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Get Notified',
                      style: AppStyles.tsWhiteMedium12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                    ),
                    child: Text(
                      'Start Trading',
                      style: AppStyles.tsWhiteMedium12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Share',
                      style: AppStyles.tsWhiteMedium12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String selectedValue;
  final void Function(String?) onChanged;

  CustomDropdown({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey.withOpacity(.25),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selectedValue,
          onChanged: widget.onChanged,
          items: widget.items.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
