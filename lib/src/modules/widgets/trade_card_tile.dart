import 'package:flutter/material.dart';

import '../../core/core.dart';

class TradeCardTile extends StatelessWidget {
  final String? label;
  final dynamic value;
  final Color? valueColor;
  final EdgeInsets? margin;
  final bool hasBottomMargin;
  final bool isRightAlign;

  const TradeCardTile({
    super.key,
    this.label,
    this.value,
    this.valueColor,
    this.margin,
    this.hasBottomMargin = true,
    this.isRightAlign = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: hasBottomMargin ? EdgeInsets.only(bottom: 4) : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            label ?? '-',
            style: AppStyles.tsGreyMedium12,
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.tsMedium12.copyWith(
                  color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                ),
          ),
        ],
      ),
    );
  }
}
