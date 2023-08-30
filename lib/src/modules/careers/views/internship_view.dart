import 'package:flutter/material.dart';

import '../../../core/core.dart';

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
      body: Container(
        child: Column(
          children: [
            CommonCard(
              onTap: () => setState(() => isExpanded = !isExpanded),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'What is stoxHero Internship Program ?',
                      style: AppStyles.tsSecondaryRegular16,
                    ),
                    Icon(
                      isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                    ),
                  ],
                ),
                if (isExpanded)
                  Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Welcome to the transformative StoxHero Derivatives Trader Internship! Our program cultivates future trading experts through immersive learning, equipping you for a rewarding derivatives career. Excel with us and earn a prestigious StoxHero internship certificate.',
                        style: AppStyles.tsWhiteRegular14,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
