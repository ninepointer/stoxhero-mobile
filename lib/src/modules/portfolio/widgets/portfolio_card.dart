import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class PortfolioCard extends StatelessWidget {
  final String? portfolioName;
  final String? portfolioValue;
  final num? cashBalance;
  final num? investedAmount;
  final String? portfolioType;
  final String? portfolioAccount;
  const PortfolioCard({
    super.key,
    this.portfolioName,
    this.portfolioValue,
    this.cashBalance,
    this.investedAmount,
    this.portfolioType,
    this.portfolioAccount,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 8),
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              portfolioName ?? '',
              style: Theme.of(context).textTheme.tsMedium16,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Portfolio Value',
                        style: AppStyles.tsGreyRegular16,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${FormatHelper.formatNumbers(portfolioValue)}',
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
                      cashBalance,
                      isNegative: true,
                    ),
                    valueColor: AppColors.danger,
                  ),
                  PortfolioCardTile(
                    isRightAlign: true,
                    label: 'Available Margin',
                    value: FormatHelper.formatNumbers(
                      investedAmount,
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
                    value: portfolioType,
                  ),
                  PortfolioCardTile(
                    isRightAlign: true,
                    label: 'Portfolio Account',
                    value: portfolioAccount,
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
