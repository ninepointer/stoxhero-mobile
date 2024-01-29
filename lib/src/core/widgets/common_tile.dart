import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

import '../core.dart';

class CommonTile extends StatelessWidget {
  final String label;
  final bool showSeeAllButton;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool showIconButton;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String? seeAllLabel;
  final Color? sellAllColor;
  final bool isLoading;
  final String? value;
  final bool isValue;
  const CommonTile({
    Key? key,
    this.label = 'Label',
    this.showSeeAllButton = false,
    this.onPressed,
    this.icon,
    this.showIconButton = false,
    this.margin,
    this.padding,
    this.seeAllLabel,
    this.sellAllColor,
    this.isLoading = false,
    this.isValue = false,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin ?? EdgeInsets.symmetric(vertical: 4),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        // color: Theme.of(context).cardColor,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: Get.isDarkMode
                              ? AppStyles.tsprimarywhiteMedium14
                              : AppStyles.tsprimaryGrayishBlackMedium14,
                        ),
                        if (isValue) ...[
                          SizedBox(height: 4),
                          Text(
                            value ?? '',
                            style: AppStyles.tsGreyMedium12,
                          ),
                        ],
                      ],
                    ),
                    if (isLoading) ...[
                      SizedBox(width: 8),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ],
                  ],
                ),
                if (showSeeAllButton)
                  Text(
                    seeAllLabel ?? 'See All',
                    style: Get.isDarkMode
                        ? AppStyles.tsprimarywhiteMedium14.copyWith(
                            color: AppColors.darkGreen,
                          )
                        : AppStyles.tsprimaryGrayishBlackMedium14.copyWith(
                            color: AppColors.lightGreen,
                          ),
                  )
                else if (showIconButton)
                  Icon(icon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
