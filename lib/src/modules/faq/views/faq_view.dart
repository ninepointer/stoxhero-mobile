import 'package:flutter/material.dart';
import '../../../core/core.dart';
import '../../modules.dart';

class FaqView extends StatefulWidget {
  const FaqView({Key? key}) : super(key: key);

  @override
  State<FaqView> createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {
  int expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ\'s'),
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
              style: Theme.of(context).textTheme.tsMedium18,
            ),
            SizedBox(height: 12),
            for (int i = 0; i < faqItems.length; i++) buildExpandableCard(i, faqItems[i]),
            SizedBox(height: 24),
            Text(
              'For any additional queries,\n drop us an email: team@stoxhero.com',
              textAlign: TextAlign.center,
              style: AppStyles.tsGreyRegular16,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpandableCard(int index, FaqItem item) {
    return CommonCard(
      onTap: () {
        setState(() {
          expandedIndex = expandedIndex == index ? -1 : index;
        });
      },
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.title,
              style: AppStyles.tsSecondaryRegular16,
            ),
            Icon(
              expandedIndex == index ? Icons.expand_less_rounded : Icons.expand_more_rounded,
              color: AppColors.grey,
            ),
          ],
        ),
        if (expandedIndex == index)
          Column(
            children: [
              SizedBox(height: 16),
              Text(
                item.content,
                style: Theme.of(context).textTheme.tsRegular14,
              ),
            ],
          ),
      ],
    );
  }
}
