import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

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
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    Get.isDarkMode
                        ? AppImages.lightAppName
                        : AppImages.dartAppName,
                    height: logoSize ?? 100,
                    width: logoSize ?? 250,
                  ),
                ),
              ),
              // if (hasLabel) SizedBox(height: 24),
              // if (hasLabel)
              //   Material(
              //     color: Colors.transparent,
              //     child: Text(
              //       AppConstants.appName,
              //       style: Theme.of(context).textTheme.tsMedium20,
              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
