import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../home_index.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget buildInfoCard() {
    return Expanded(
      child: Card(
        elevation: 0,
        margin: EdgeInsets.only(top: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.netural.shade400,
                    ),
                    child: Icon(
                      Icons.trending_up_rounded,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NIFTY 50',
                        style: AppStyles.tsGreyMedium10,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '₹ 12,500.90',
                        style: AppStyles.tsWhiteSemiBold14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Today',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Spacer(),
                  Text(
                    '₹ 125.87',
                    style: AppStyles.tsWhiteMedium12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '(+ 0.25%)',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            AppLogoWidget(
              logoSize: 32,
              hasLabel: false,
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: AppStyles.tsGreyRegular12,
                ),
                Text(
                  'Jhon Doe',
                  style: AppStyles.tsWhiteMedium16,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.person),
            onPressed: () => Get.toNamed(AppRoutes.profile),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  buildInfoCard(),
                  SizedBox(width: 8),
                  buildInfoCard(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  buildInfoCard(),
                  SizedBox(width: 8),
                  buildInfoCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
