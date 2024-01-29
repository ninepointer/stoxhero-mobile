import 'package:flutter/material.dart';

import '../core.dart';

class CommonCardTile extends StatelessWidget {
  final String? label;
  final dynamic value;
  final Color? valueColor;
  final bool isRightAlign;
  final bool isValueNumber;
  final IconData? icon;
  final bool hasIconTrailing;
  final bool isCenterAlign;
  const CommonCardTile({
    super.key,
    this.label,
    this.value,
    this.valueColor,
    this.isRightAlign = false,
    this.isCenterAlign = false,
    this.isValueNumber = false,
    this.icon,
    this.hasIconTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasIconTrailing)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.grey.shade50,
            ),
          ),
        Column(
          crossAxisAlignment: isRightAlign
              ? CrossAxisAlignment.end
              : isCenterAlign
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
          children: [
            Text(
              label ?? '-',
              style: AppStyles.tsGreyRegular12,
            ),
            SizedBox(height: 2),
            Text(
              isValueNumber ? FormatHelper.formatNumbers(value) : value ?? '-',
              style: Theme.of(context).textTheme.tsRegular12.copyWith(
                    color: valueColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
