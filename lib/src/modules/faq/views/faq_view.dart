import 'package:flutter/material.dart';
import '../../../core/core.dart';

class FaqView extends StatefulWidget {
  const FaqView({Key? key}) : super(key: key);

  @override
  State<FaqView> createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {
  List<bool> isExpandedList = List.generate(6, (index) => false);
  int expandedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Image.asset(
                AppImages.faq,
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'How does this work ?',
              style: AppStyles.tsGreyMedium20,
            ),
            SizedBox(height: 12),
            buildExpandableCard(0, 'About Stoxhero', ''),
            buildExpandableCard(1, 'Login & Registration', ''),
            buildExpandableCard(2, 'Portfolios', ''),
            buildExpandableCard(3, 'StoxHero Battles', ''),
            buildExpandableCard(4, 'Points & Ranking System', ''),
            buildExpandableCard(5, 'StoxHero Account', ''),
            SizedBox(height: 24),
            Text(
              'For any additional queries,\n drop us an email: team@stoxhero.com',
              textAlign: TextAlign.center,
              style: AppStyles.tsGreyMedium18,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpandableCard(int index, String title, String content) {
    return CommonCard(
      onTap: () {
        setState(() {
          if (expandedIndex == index) {
            expandedIndex = -1; 
          } else {
            expandedIndex = index;
          }
        });
      },
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppStyles.tsSecondaryRegular16,
            ),
            Icon(
              expandedIndex == index ? Icons.expand_less_rounded : Icons.expand_more_rounded,
            ),
          ],
        ),
        if (expandedIndex == index)
          Column(
            children: [
              SizedBox(height: 16),
              Text(
                content,
                style: AppStyles.tsWhiteRegular14,
              ),
            ],
          ),
      ],
    );
  }
}
