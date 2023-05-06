import 'package:flutter/material.dart';

import '../core.dart';

class CommonFilledButton extends StatelessWidget {
  final String? label;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;

  const CommonFilledButton({
    Key? key,
    this.label,
    this.height,
    this.width,
    this.margin,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 52,
      width: width ?? double.infinity,
      margin: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: AppColors.primary.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          label ?? 'Label',
          style: AppStyles.tsWhiteRegular16,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
