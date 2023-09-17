import 'package:flutter/material.dart';

import '../../../core/core.dart';

class OrderCardTile extends StatelessWidget {
  final String? label;
  final String? value;
  final Color? valueColor;
  final bool isRightAlign;

  const OrderCardTile({
    super.key,
    this.label,
    this.value,
    this.valueColor,
    this.isRightAlign = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '-',
          style: AppStyles.tsGreyMedium14,
        ),
        SizedBox(height: 4),
        Text(
          value ?? '-',
          style: Theme.of(context).textTheme.tsMedium16.copyWith(
                color: valueColor,
              ),
        ),
      ],
    );
  }
}
