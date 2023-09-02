import 'package:flutter/material.dart';

import '../core.dart';

class CommonCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool hasBorder;
  final Color? color;
  final Function()? onTap;

  const CommonCard({
    super.key,
    required this.children,
    this.padding,
    this.margin,
    this.hasBorder = true,
    this.onTap,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        margin: margin ??
            EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
        elevation: 0,
        shape: hasBorder
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.grey.withOpacity(.25),
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
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
