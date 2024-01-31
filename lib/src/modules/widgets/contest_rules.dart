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
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "TestZone Details:",
            style: Get.isDarkMode
                ? Theme.of(context).textTheme.tsWhiteMedium14
                : Theme.of(context).textTheme.tsBlackMedium14,
          ),
          TextSpan(
            text:
                ' TestZone begins on ${FormatHelper.formatDateTimeToIST(startTime)} and ends on ${FormatHelper.formatDateTimeToIST(endTime)}. The entry fee is ${entryFee == 0 ? 'Free' : FormatHelper.formatNumbers(entryFee)}.',
            style: Get.isDarkMode
                ? Theme.of(context).textTheme.tsWhiteRegular14
                : Theme.of(context).textTheme.tsBlackRegular14,
          ),
        ])),
        SizedBox(height: 8),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Payout Criteria:',
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteMedium14
                  : Theme.of(context).textTheme.tsBlackMedium14,
            ),
            TextSpan(
              text: ' Payouts are based on individual performance (Net P&L).',
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteRegular14
                  : Theme.of(context).textTheme.tsBlackRegular14,
            ),
          ]),
        ),
        if (payoutType != 'Reward') ...[
          SizedBox(height: 8),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Payout Limit:",
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteMedium14
                  : Theme.of(context).textTheme.tsBlackMedium14,
            ),
            TextSpan(
              text:
                  ' Receive $payoutPercentage% of your Net P&L(Only positive net P&Ls), up to a maximum of ${controller.getPaidCapAmount(
                entryFee == 0 ? portfolio ?? 0 : entryFee ?? 0,
                payoutCapPercentage ?? 0,
              )}.',
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteRegular14
                  : Theme.of(context).textTheme.tsBlackRegular14,
            ),
          ]))
        ],
        if (payoutType != 'Reward') ...[
          SizedBox(height: 8),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Tax Deduction:",
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteMedium14
                  : Theme.of(context).textTheme.tsBlackMedium14,
            ),
            TextSpan(
              text:
                  ' A ${controller.readSetting.value.tdsPercentage}% TDS will be applied to your final winning amount.',
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteRegular14
                  : Theme.of(context).textTheme.tsBlackRegular14,
            ),
          ])),
        ],
        SizedBox(height: 8),
        if (payoutType != 'Reward') ...[
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Payout Processing:",
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteMedium14
                  : Theme.of(context).textTheme.tsBlackMedium14,
            ),
            TextSpan(
              text:
                  ' Payouts are calculated and processed after the TestZone ends on ${FormatHelper.formatDateTimeToIST(endTime)}, (based on cumulative Net P&L) / (daily based on daily P&L) post 03:20.',
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteRegular14
                  : Theme.of(context).textTheme.tsBlackRegular14,
            ),
          ])),
        ],
        if (payoutType == 'Reward') ...[
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Reward Delivery: ",
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteMedium14
                  : Theme.of(context).textTheme.tsBlackMedium14,
            ),
            TextSpan(
              text:
                  'After the completion of the testzone, our team will get in touch and get your reward delivered to your address',
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteRegular14
                  : Theme.of(context).textTheme.tsBlackRegular14,
            ),
          ])),
        ],
        if (payoutType != 'Reward') ...[
          SizedBox(height: 8),
        ],
        if (payoutType != 'Reward') ...[
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Daily Participation: ",
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteMedium14
                  : Theme.of(context).textTheme.tsBlackMedium14,
            ),
            TextSpan(
              text:
                  'For TestZones spanning multiple days, daily trading is required for payout eligibility.',
              style: Get.isDarkMode
                  ? Theme.of(context).textTheme.tsWhiteRegular14
                  : Theme.of(context).textTheme.tsBlackRegular14,
            ),
          ])),
        ],
        SizedBox(height: 12),
      ],
    );
  }
}
