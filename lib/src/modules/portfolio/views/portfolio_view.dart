import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class PortfolioView extends GetView<PortfolioController> {
  const PortfolioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.netural.shade800,
                ),
                child: Text(
                  "Virtual Trading Porfolio",
                  style: AppStyles.tsPrimaryRegular18,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: controller.portfoliList.length,
                itemBuilder: (context, index) => PortfolioCard(
                  portfolio: controller.portfoliList[index],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.netural.shade800,
                ),
                child: Text(
                  "TenX Trading Porfolio's",
                  style: AppStyles.tsPrimaryRegular18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
