import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

class AppController extends GetxController {
  void getAppThemeStatus(BuildContext context) {
    bool isDarkMode = AppStorage.getDarkModeStatus();
    log(isDarkMode.toString());
    Get.changeTheme(
      isDarkMode ? AppTheme.darkThemeData(context) : AppTheme.lightThemeData(context),
    );
  }

  void toggleThemeMode(BuildContext context, bool value) {
    AppStorage.setDarkModeStatus(value);
    getAppThemeStatus(context);
  }
}
