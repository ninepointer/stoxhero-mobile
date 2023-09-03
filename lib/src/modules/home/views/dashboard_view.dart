import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            CommonTile(label: 'Return Summary'),
            customCard(label: 'Virtual Trading', percent: '0.0%'),
            customCard(label: 'Contest Trading', percent: '0.0%'),
            customCard(label: 'TenX Trading', percent: '0.0%'),
            CommonTile(label: 'Performance'),
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
