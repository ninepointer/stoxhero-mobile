import 'package:flutter/material.dart';

import '../core.dart';

class CommonFilledButton extends StatelessWidget {
  final String? label;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? bgColor;
  final OutlinedBorder? shape;
  const CommonFilledButton({
    Key? key,
    this.label,
    this.height,
    this.margin,
    this.width,
    this.onPressed,
    this.isLoading = false,
    this.bgColor,
    this.shape,
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
          backgroundColor: bgColor ?? AppColors.primary,
          shadowColor: AppColors.primary.shade500,
          enableFeedback: false,
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
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
                style: Theme.of(context).textTheme.tsWhiteRegular16.copyWith(
                      fontSize: height == null
                          ? 16
                          : (height! < 36)
                              ? 14
                              : 16,
                    ),
              ),
        onPressed: isLoading ? null : onPressed,
      ),
    );
  }
}
