import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class TenxPositionDetailsCard extends StatelessWidget {
  final String? label;
  final dynamic value;
  final bool isNum;

  const TenxPositionDetailsCard({
    super.key,
    this.label,
    this.value,
    this.isNum = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CommonCard(
        margin: EdgeInsets.zero,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label ?? '-',
                style: AppStyles.tsWhiteRegular12,
              ),
              Text(
                FormatHelper.formatNumbers(
                  value,
                  showSymbol: !isNum,
                  decimal: isNum ? 0 : 2,
                ),
                style: AppStyles.tsWhiteMedium14.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
