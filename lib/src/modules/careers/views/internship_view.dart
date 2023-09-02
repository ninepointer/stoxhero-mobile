import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/careers/views/career_form.dart';

import '../../../core/core.dart';
import '../careers_index.dart';

class InternshipView extends StatefulWidget {
  const InternshipView({Key? key}) : super(key: key);

  @override
  State<InternshipView> createState() => _InternshipViewState();
}

class _InternshipViewState extends State<InternshipView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonCard(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              onTap: () => setState(() => isExpanded = !isExpanded),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'What is stoxHero Internship Program ?',
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                    Icon(
                      isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                if (isExpanded) bulletPoint(),
              ],
            ),
            InfoCard(
              label: 'Campus Head',
              isInternship: true,
              onPressed: () => Get.to(
                () => CareerForm(),
              ),
            ),
            InfoCard(
              label: 'Campus Head',
              isInternship: true,
              onPressed: () => Get.to(
                () => CareerForm(),
              ),
            ),
            InfoCard(
              label: 'Campus Head',
              isInternship: true,
              onPressed: () => Get.to(
                () => CareerForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bulletPoint() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          'Welcome to the transformative StoxHero Derivatives Trader Internship! Our program cultivates future trading experts through immersive learning, equipping you for a rewarding derivatives career. Excel with us and earn a prestigious StoxHero internship certificate.',
          style: Theme.of(context).textTheme.tsRegular16,
        ),
        SizedBox(height: 12),
        Text(
          'Perks & Benefits of StoxHero Internship Program:',
          style: Theme.of(context).textTheme.tsMedium16,
        ),
        SizedBox(height: 12),
        Text(
          '1. Receive a stipend calculated at 0.5% of the net profit and loss (P&L) for the duration of your internship.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          '2. Upon completion, receive an internship certificate from StoxHero.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 12),
        Text(
          'Internship Completion Rules and Issuance of Internship Certificate:',
          style: Theme.of(context).textTheme.tsMedium16,
        ),
        SizedBox(height: 12),
        Text(
          '1. Accept and abide by the terms of usage, avoiding malpractices or manipulation.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          '2. Take trades on at least 80% of the trading days during the internship period.',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          '3. Refer a minimum of 15 users to the platform using your invite link.',
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
      ],
    );
  }
}
