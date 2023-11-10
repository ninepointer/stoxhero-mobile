import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../core.dart';

class CommonRankCard extends GetView<ContestController> {
  final String rank;
  final String name;
  final String netPnL;
  final String reward;
  const CommonRankCard({
    Key? key,
    required this.rank,
    required this.name,
    required this.netPnL,
    required this.reward,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      hasBorder: false,
      margin: EdgeInsets.symmetric(horizontal: 8),
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(.25),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '#$rank',
                style: AppStyles.tsSecondarySemiBold14,
              ),
            ),
            SizedBox(width: 8),
            Text(
              name,
              style: Theme.of(context).textTheme.tsMedium14,
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Net P&L (Profit & Loss)',
                    style: Theme.of(context).textTheme.tsGreyMedium12,
                  ),
                  Text(
                    FormatHelper.formatNumbers(netPnL),
                    style: Theme.of(context).textTheme.tsMedium12.copyWith(
                          color: controller.getValueColor(netPnL),
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Reward',
                    style: Theme.of(context).textTheme.tsGreyMedium12,
                  ),
                  Text(
                    controller.liveContest.value.payoutType == 'Reward'
                        ? FormatHelper.formatNumbers(reward)
                        : FormatHelper.formatNumbers(reward),
                    style: Theme.of(context).textTheme.tsMedium12.copyWith(
                          color: controller.getValueColor(reward),
                        ),
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
