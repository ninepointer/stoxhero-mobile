import 'package:flutter/material.dart';
import '../../app/app.dart';

class TradingMarginNpnlCard extends StatelessWidget {
  final String? label;
  final dynamic value;
  final Color? valueColor;
  const TradingMarginNpnlCard({
    Key? key,
    this.label,
    this.value,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.zero,
      children: [
        Text(
          label ?? '',
          style: AppStyles.tsSecondaryMedium14,
        ),
        Text(
          FormatHelper.formatNumbers(
            value,
          ),
          style: Theme.of(context).textTheme.tsMedium12.copyWith(
                color: (value is num && value < 0) ? AppColors.danger : AppColors.success,
              ),
        ),
      ],
    );
  }
}
