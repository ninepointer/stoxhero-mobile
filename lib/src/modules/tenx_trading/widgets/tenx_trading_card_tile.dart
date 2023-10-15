import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenxTradingCardTile extends StatelessWidget {
  final String label;

  const TenxTradingCardTile({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ListTile(
        dense: true,
        minLeadingWidth: 0,
        visualDensity: VisualDensity.compact,
        leading: Icon(
          Icons.check_circle_rounded,
          size: 16,
          color: AppColors.grey.withOpacity(.5),
        ),
        title: Text(
          label,
          style: Theme.of(context).textTheme.tsRegular12,
        ),
      ),
    );
  }
}
