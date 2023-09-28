import 'package:flutter/material.dart';
import '../../../app/app.dart';

class VirtualPortfolioDetailsCard extends StatelessWidget {
  final String? label;
  final dynamic value;
  final Color? valueColor;
  const VirtualPortfolioDetailsCard({
    super.key,
    this.label,
    this.value,
    this.valueColor,
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
