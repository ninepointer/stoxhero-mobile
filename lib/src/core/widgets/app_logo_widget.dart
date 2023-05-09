import 'package:flutter/material.dart';

import '../core.dart';

class AppLogoWidget extends StatelessWidget {
  final double? logoSize;
  final bool hasLabel;
  const AppLogoWidget({
    super.key,
    this.logoSize,
    this.hasLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: AppConstants.appName,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                AppImages.appLogo,
                height: logoSize ?? 150,
                width: logoSize ?? 150,
              ),
            ),
            if (hasLabel) SizedBox(height: 16),
            if (hasLabel)
              Text(
                AppConstants.appName,
                style: AppStyles.tsWhiteMedium20,
              )
          ],
        ),
      ),
    );
  }
}
