import 'package:flutter/material.dart';

import '../../../core/core.dart';

class PortfolioCardTile extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isRightAlign;

  const PortfolioCardTile({
    super.key,
    this.label,
    this.value,
    this.isRightAlign = false,
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
          value ?? '-',
          style: AppStyles.tsWhiteRegular16,
        ),
      ],
    );
  }
}
