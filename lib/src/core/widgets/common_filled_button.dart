import 'package:flutter/material.dart';

import '../../app/app.dart';

class CommonFilledButton extends StatelessWidget {
  final String? label;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? labelColor;
  final OutlinedBorder? shape;
  const CommonFilledButton({
    Key? key,
    this.label,
    this.height,
    this.margin,
    this.width,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.labelColor,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 52,
      width: width ?? double.infinity,
      margin: margin ?? EdgeInsets.zero,
      child: MaterialButton(
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        // color: backgroundColor ?? Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
        color: backgroundColor ?? AppColors.primary,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
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
                      color: labelColor ?? AppColors.white,
                      fontSize: height == null
                          ? 16
                          : (height! < 36)
                              ? 14
                              : 16,
                    ),
              ),
        onPressed: isLoading ? () {} : onPressed,
      ),
    );
  }
}
