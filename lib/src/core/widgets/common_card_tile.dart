import 'package:flutter/material.dart';
import '../core.dart';

class CommonCardTile extends StatelessWidget {
  final String? label;
  final dynamic value;
  final Color? valueColor;
  final bool isRightAlign;
  final bool isValueNumber;

  const CommonCardTile({
    super.key,
    this.label,
    this.value,
    this.valueColor,
    this.isRightAlign = false,
    this.isValueNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '-',
          style: AppStyles.tsGreyRegular14,
        ),
        SizedBox(height: 4),
        Text(
          isValueNumber ? FormatHelper.formatNumbers(value) : value ?? '-',
          style: Theme.of(context).textTheme.tsMedium16.copyWith(
                color: valueColor,
              ),
        ),
      ],
    );
  }
}
