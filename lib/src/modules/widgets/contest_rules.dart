import 'package:flutter/material.dart';

import '../../app/app.dart';

class ContestRules extends GetView<ContestController> {
  final String? startTime;
  final String? endTime;
  final num? entryFee;
  final num? payoutPercentage;
  final num? payoutCapPercentage;
  final num? portfolio;
  final String? payoutType;
  const ContestRules({
    Key? key,
    this.startTime,
    this.endTime,
    this.entryFee,
    this.payoutPercentage,
    this.payoutCapPercentage,
    this.portfolio,
    this.payoutType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'TestZone Details: TestZone begins on ${FormatHelper.formatDateTimeToIST(startTime)} and ends on ${FormatHelper.formatDateTimeToIST(endTime)} The entry fee is ${entryFee == 0 ? 'Free' : FormatHelper.formatNumbers(entryFee)}.',
          style: Theme.of(context).textTheme.tsMedium14,
        ),
        SizedBox(height: 8),
        Text(
          'Payout Criteria: Payouts are based on individual performance (Net P&L).',
          style: Theme.of(context).textTheme.tsMedium14,
        ),
        if (payoutType != 'Reward') ...[
          SizedBox(height: 8),
          Text(
            'Payout Limit: Receive $payoutPercentage% of your Net P&L(Only positive net P&Ls), up to a maximum of ${controller.getPaidCapAmount(
              entryFee == 0 ? portfolio ?? 0 : entryFee ?? 0,
              payoutCapPercentage ?? 0,
            )}.',
            style: Theme.of(context).textTheme.tsMedium14,
          ),
        ],
        SizedBox(height: 8),
        Text(
          'Tax Deduction: A ${controller.readSetting.value.tdsPercentage}% TDS will be applied to your final winning amount.',
          style: Theme.of(context).textTheme.tsMedium14,
        ),
        SizedBox(height: 8),
        Text(
          'Payout Processing: Payouts are calculated and processed after the contest ends on ${FormatHelper.formatDateTimeToIST(endTime)}, (based on cumulative Net P&L) / (daily based on daily P&L) post 03:20.',
          style: Theme.of(context).textTheme.tsMedium14,
        ),
        SizedBox(height: 8),
        Text(
          'Daily Participation: For TestZones spanning multiple days, daily trading is required for payout eligibility.',
          style: Theme.of(context).textTheme.tsMedium14,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
