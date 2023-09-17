import 'package:flutter/material.dart';

import '../core.dart';

class CommonOutlinedButton extends StatelessWidget {
  final String? label;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  const CommonOutlinedButton({
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
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 2,
            color: AppColors.primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label ?? 'Label',
          style: AppStyles.tsPrimaryRegular16,
        ),
        onPressed: onPressed ?? null,
      ),
    );
  }
}
