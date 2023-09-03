import 'package:flutter/material.dart';

import '../core.dart';

class CommonRankCard extends StatelessWidget {
  final String rank;
  final String name;
  final String netPnl;
  const CommonRankCard({
    Key? key,
    required this.rank,
    required this.name,
    required this.netPnl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: 8),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rank,
                    style: AppStyles.tsSecondarySemiBold16,
                  ),
                  SizedBox(height: 4),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Net P&L',
                    style: Theme.of(context).textTheme.tsGreyRegular12,
                  ),
                  SizedBox(height: 4),
                  Text(
                    netPnl,
                    style: Theme.of(context).textTheme.tsRegular14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
