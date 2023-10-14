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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 8),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Theme.of(context).cardColor,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppStyles.tsSecondaryMedium14,
              ),
              if (showSeeAllButton)
                GestureDetector(
                  onTap: onPressed,
                  child: Text(
                    seeAllLabel ?? 'See All',
                    style: AppStyles.tsSecondaryMedium14.copyWith(
                      color: sellAllColor,
                    ),
                  ),
                )
              else if (showIconButton)
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onPressed,
                  icon: Icon(icon),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
