import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../splash_index.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppLogoWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 56,
                    vertical: 24,
                  ),
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.netural,
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(
                () => Text(
                  controller.appVersion,
                  style: AppStyles.tsGreyRegular14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
