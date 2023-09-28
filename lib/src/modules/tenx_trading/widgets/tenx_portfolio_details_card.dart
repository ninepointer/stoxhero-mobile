import 'package:flutter/material.dart';
import '../../../app/app.dart';

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
    return CommonCard(
      margin: EdgeInsets.all(8).copyWith(bottom: 0),
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
            SizedBox(width: 4),
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
    );
  }
}
