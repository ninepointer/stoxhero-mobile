import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class CommonInternshipInfo extends GetView<InternshipController> {
  const CommonInternshipInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          'Welcome to the transformative StoxHero Derivatives Trader Internship! Our program cultivates future trading experts through immersive learning, equipping you for a rewarding derivatives career. Excel with us and earn a prestigious StoxHero internship certificate.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 12),
        Text(
          'Perks & Benefits of StoxHero Internship Program:',
          style: Theme.of(context).textTheme.tsMedium14,
        ),
        SizedBox(height: 12),
        Text(
          '1. Receive a stipend calculated at ${controller.internshipBatchDetails.value.payoutPercentage}% of the net profit and loss (P&L) for the duration of your internship on a virtual margin money of ${FormatHelper.formatNumbers(controller.internshipBatchDetails.value.portfolio?.portfolioValue)}.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          '2. Upon completion, receive an internship certificate from StoxHero.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        // SizedBox(height: 8),
        // Text(
        //   "3. Upon successful completion of the internship with at least ${controller.internshipBatchDetails.value.attendancePercentage}% attendance, you will receive a participation bonus of ${"5000"} HeroCash",
        //   style: Theme.of(context).textTheme.tsRegular14,
        // ),
        SizedBox(height: 12),
        Text(
          'Internship Completion Rules and Issuance of Internship Certificate:',
          style: Theme.of(context).textTheme.tsMedium14,
        ),
        SizedBox(height: 12),
        Text(
          '1. Accept and abide by the terms of usage, avoiding malpractices or manipulation.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          '2. Take trades on at least ${controller.internshipBatchDetails.value.attendancePercentage}% of the trading days during the internship period.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          '3. Refer a minimum of ${controller.internshipBatchDetails.value.referralCount} users to the platform using your invite link.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          '4. Treat the internship as an educational experience.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          '5. Limited to taking intraday option trades and required to close all positions before 3:20 PM daily.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          '6. Traders will be eligible for stipend if they have an ${controller.internshipBatchDetails.value.attendancePercentage}% attendance during the internship period, minimum ${controller.internshipBatchDetails.value.referralCount} referrals and a positive net P&L.  .',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
      ],
    );
  }
}
