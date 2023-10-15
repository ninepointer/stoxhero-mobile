import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenxTradingCardHeader extends StatelessWidget {
  final String label;
  final Color color;

  const TenxTradingCardHeader({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: color.withOpacity(0.1),
      ),
      child: Text(
        label,
        style: AppStyles.tsSecondaryMedium14.copyWith(
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
