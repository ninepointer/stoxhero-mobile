import 'package:flutter/material.dart';

import '../../../core/core.dart';

class TenxInfoCard extends StatefulWidget {
  const TenxInfoCard({Key? key}) : super(key: key);

  @override
  _TenxInfoCardState createState() => _TenxInfoCardState();
}

class _TenxInfoCardState extends State<TenxInfoCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: 16),
      onTap: () => setState(() => isExpanded = !isExpanded),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'What is TenX Trading / TenX ट्रेडिंग क्या है?',
              style: AppStyles.tsSecondaryRegular14,
            ),
            Icon(
              isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
              color: AppColors.grey,
            ),
          ],
        ),
        if (isExpanded)
          Column(
            children: [
              SizedBox(height: 16),
              Text(
                AppData.tenxInfoEnglish,
                style: Theme.of(context).textTheme.tsRegular14,
              ),
              SizedBox(height: 16),
              Text(
                AppData.tenxInfoHindi,
                style: Theme.of(context).textTheme.tsRegular14,
              ),
            ],
          ),
      ],
    );
  }
}
