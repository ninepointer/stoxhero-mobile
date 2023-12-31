import 'package:flutter/material.dart';

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin ?? EdgeInsets.symmetric(vertical: 8),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Theme.of(context).cardColor,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: AppStyles.tsSecondaryMedium14,
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
                    style: AppStyles.tsSecondaryMedium14.copyWith(
                      color: sellAllColor,
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
