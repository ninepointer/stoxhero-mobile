import 'package:flutter/material.dart';
import '../../app/app.dart';

class PortfolioDetailCardTile extends StatelessWidget {
  final String? label;
  final String? info;
  final dynamic value;
  final Color? valueColor;
  const PortfolioDetailCardTile({
    super.key,
    this.label,
    this.info,
    this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      hasBorder: false,
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
                color: valueColor ?? AppColors.success,
              ),
            )
          ],
        ),
      ],
    );
  }
}
