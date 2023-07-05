import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class TenxPortfolioDetailsCard extends StatelessWidget {
  final String? label;
  final String? info;
  final dynamic value;

  const TenxPortfolioDetailsCard({
    super.key,
    this.label,
    this.info,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonCard(
          hasBorder: false,
          margin: EdgeInsets.zero,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label ?? '-',
                      style: AppStyles.tsWhiteRegular14,
                    ),
                    SizedBox(height: 2),
                    Text(
                      info ?? '-',
                      style: AppStyles.tsGreyRegular12,
                    ),
                  ],
                ),
                Spacer(),
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
        Divider(
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}
