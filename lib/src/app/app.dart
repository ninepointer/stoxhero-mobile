import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'app_binding.dart';
export 'app_controller.dart';

export '../app/app.dart';
export '../base/base.dart';
export '../core/core.dart';
export '../data/data.dart';
export '../modules/modules.dart';

export 'package:get/get.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _initializePushNotification();
  }

  Future _initializePushNotification() async {
    await NotificationServices.initializeNotificationService(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      title: AppConstants.appName,
      themeMode: ThemeService().theme,
      theme: AppTheme.lightThemeData(context),
      darkTheme: AppTheme.darkThemeData(context),
      initialBinding: AppBinding(),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
    );
  }
}
