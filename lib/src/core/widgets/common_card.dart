import 'package:flutter/material.dart';

import '../core.dart';

class CommonCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function()? onTap;

  const CommonCard({
    super.key,
    required this.children,
    this.padding,
    this.margin,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: margin ??
            EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.netural.shade400,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
          padding: padding ?? EdgeInsets.all(12),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}
