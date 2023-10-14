import 'package:flutter/material.dart';
import '../../app/app.dart';

class CommonChip extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;
  final Color? color;
  const CommonChip({Key? key, this.onTap, this.label, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Align(
          child: Text(
            label ?? '-',
            style: AppStyles.tsWhiteMedium14,
          ),
        ),
      ),
    );
  }
}
