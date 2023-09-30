import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class ContestPortfolioDetailsCard extends StatelessWidget {
  final String? label;
  final dynamic value;

  const ContestPortfolioDetailsCard({
    super.key,
    this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonCard(
          hasBorder: false,
          margin: EdgeInsets.symmetric(horizontal: 8),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label ?? '-',
                      style: Theme.of(context).textTheme.tsRegular14,
                    ),
                  ],
                ),
                Text(
                  FormatHelper.formatNumbers(
                    value,
                    decimal: 0,
                  ),
                  style: AppStyles.tsPrimarySemiBold16.copyWith(
                    color: AppColors.success,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
