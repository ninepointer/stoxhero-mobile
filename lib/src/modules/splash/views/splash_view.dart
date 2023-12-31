import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/main.dart';
import 'package:stoxhero/src/core/core.dart';

import '../splash_index.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppLogoWidget(),
                SizedBox(height: 16),
                Container(
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.grey.withOpacity(.25),
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(
                () => Column(
                  children: [
                    if (!isProd)
                      Text(
                        'DEV',
                        style: AppStyles.tsPrimaryMedium12,
                      ),
                    Text(
                      controller.appVersion,
                      style: AppStyles.tsGreyRegular14,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
