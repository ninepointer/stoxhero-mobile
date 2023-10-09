import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class MarginXPortfolioDetailsCard extends StatelessWidget {
  final String? label;
  final dynamic value;
  final Color? valueColor;
  final String? info;
  const MarginXPortfolioDetailsCard({
    super.key,
    this.label,
    this.value,
    this.valueColor,
    this.info,
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
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label ?? '-',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                      SizedBox(height: 2),
                      Text(
                        info ?? '-',
                        style: AppStyles.tsGreyRegular12,
                      ),
                    ],
                  ),
                ),
                Text(
                  FormatHelper.formatNumbers(
                    value,
                    decimal: 0,
                    isNegative: true,
                  ),
                  style: AppStyles.tsPrimarySemiBold16.copyWith(
                    color: valueColor ?? AppColors.success,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 4),
      ],
    );
  }
}
