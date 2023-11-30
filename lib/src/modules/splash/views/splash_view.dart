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
                SizedBox(height: 8),
                Container(
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.grey.withOpacity(.25),
                      color: AppColors.lightGreen,
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
                        style: Get.isDarkMode
                            ? AppStyles.tsGreyRegular14
                            : AppStyles.tsPrimaryMedium12
                                .copyWith(color: AppColors.lightGreen),
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
