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
          visible: !controller.isLoading.value,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTile(label: 'Virtual Trading Portfolio'),
                PortfolioCard(
                  portfolioName: controller.virtualPortfolio.value.portfolioName,
                  portfolioValue: controller.virtualPortfolio.value.totalFund.toString(),
                  cashBalance: controller.virtualPortfolio.value.openingBalance,
                  investedAmount: controller.virtualPortfolio.value.openingBalance,
                  portfolioType: 'Virtual Trading',
                  portfolioAccount: 'Free',
                ),
                CommonTile(label: 'TenX Trading Portfolio'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.myTenxPortfolioList.length,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var portfolio = controller.myTenxPortfolioList[index];
                    return PortfolioCard(
                      portfolioName: portfolio.portfolioName,
                      portfolioAccount: portfolio.portfolioAccount,
                      portfolioType: portfolio.portfolioType,
                      portfolioValue: portfolio.portfolioValue.toString(),
                      cashBalance: portfolio.cashBalance,
                      investedAmount: portfolio.investedAmount,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
