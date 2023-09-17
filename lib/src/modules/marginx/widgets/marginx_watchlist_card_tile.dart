import 'package:flutter/material.dart';

import '../../../core/core.dart';

class MarginXWatchListCardTile extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isRightAlign;
  final Color? valueColor;

  const MarginXWatchListCardTile({
    super.key,
    required this.label,
    this.value,
    this.isRightAlign = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '-',
          style: AppStyles.tsGreyMedium12,
        ),
        SizedBox(height: 2),
        Text(
          value ?? '-',
          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                color: valueColor,
              ),
        ),
      ],
    );
  }
}
