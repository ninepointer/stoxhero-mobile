import 'package:flutter/material.dart';
import '../../app/app.dart';

class CommonMarginNPNLCard extends StatelessWidget {
  final String? label;
  final dynamic value;
  final Color? valueColor;
  const CommonMarginNPNLCard({
    Key? key,
    this.label,
    this.value,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.zero,
      children: [
        Text(
          label ?? '',
          style: AppStyles.tsSecondaryMedium16,
        ),
        SizedBox(height: 4),
        Text(
          FormatHelper.formatNumbers(
            value,
          ),
          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                color: (value is num && value < 0) ? AppColors.danger : AppColors.success,
              ),
        ),
      ],
    );
  }
}
