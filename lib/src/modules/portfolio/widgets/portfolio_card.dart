import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';

class PortfolioCard extends GetView<PortfolioController> {
  final Portfolio portfolio;

  const PortfolioCard({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.netural.shade400,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.netural.shade800,
                ),
                child: Text(
                  portfolio.portfolioName ?? '',
                  style: AppStyles.tsSecondaryMedium16,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.netural.shade400,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.account_balance),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Portofolio Value',
                              style: AppStyles.tsGreyRegular16,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${FormatHelper.formatNumbers(portfolio.portfolioValue)}',
                              style: AppStyles.tsPrimaryMedium20.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PortfolioCardTile(
                          label: 'Invested Amount',
                          value: FormatHelper.formatNumbers(
                            portfolio.investedAmount,
                            isNegative: true,
                          ),
                        ),
                        PortfolioCardTile(
                          isRightAlign: true,
                          label: 'Cash Balance',
                          value: FormatHelper.formatNumbers(portfolio.cashBalance),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PortfolioCardTile(
                          label: 'Portfolio Type',
                          value: portfolio.portfolioType,
                        ),
                        PortfolioCardTile(
                          isRightAlign: true,
                          label: 'Cash Balance',
                          value: portfolio.portfolioAccount,
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
    );
  }
}
