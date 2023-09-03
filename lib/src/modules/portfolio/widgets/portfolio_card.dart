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
    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              portfolio.portfolioName ?? '',
              style: AppStyles.tsSecondaryMedium16,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Divider(thickness: 1, height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(.25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.account_balance,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Portfolio Value',
                        style: AppStyles.tsGreyRegular16,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${FormatHelper.formatNumbers(portfolio.portfolioValue)}',
                        style: AppStyles.tsPrimaryMedium20.copyWith(
                          color: AppColors.info,
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
                    label: 'Opening Balance',
                    value: FormatHelper.formatNumbers(
                      portfolio.investedAmount,
                      isNegative: true,
                    ),
                    valueColor: AppColors.danger,
                  ),
                  PortfolioCardTile(
                    isRightAlign: true,
                    label: 'Available Margin',
                    value: FormatHelper.formatNumbers(
                      portfolio.cashBalance,
                    ),
                    valueColor: AppColors.success,
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
                    valueColor: AppColors.primary,
                  ),
                  PortfolioCardTile(
                    isRightAlign: true,
                    label: 'Cash Balance',
                    value: portfolio.portfolioAccount,
                    valueColor: AppColors.info,
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
