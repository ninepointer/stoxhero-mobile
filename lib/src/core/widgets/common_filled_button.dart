import 'package:flutter/material.dart';

import '../core.dart';

class CommonFilledButton extends StatelessWidget {
  final String? label;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CommonFilledButton({
    Key? key,
    this.label,
    this.height,
    this.margin,
    this.width,
    this.onPressed,
    this.isLoading = false,
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
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Text(
                label ?? 'Label',
                style: AppStyles.tsWhiteRegular16,
              ),
        onPressed: isLoading ? null : onPressed,
      ),
    );
  }
}
