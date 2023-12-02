import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

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
  Uri? initialUri;
  Uri? latestUri;
  Object? err;
  bool _initialUriIsHandled = false;

  @override
  void initState() {
    super.initState();
    _handleInitialUri();
    _handleIncomingLinks();
    _initializeReferrerDetails();
    _initializePushNotification();
  }

  Future _initializePushNotification() async {
    await NotificationServices.initializeNotificationService(context);
  }

  Future _initializeReferrerDetails() async {
    // try {
    //   String referrerData;
    //   ReferrerDetails referrerDetails = await AndroidPlayInstallReferrer.installReferrer;
    //   referrerData = referrerDetails.toString();
    //   print('ReferrerDetails : $referrerData');
    // } catch (e) {
    //   print('Error : $e');
    // }
  }

  Future _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        // _linkRouting(uri);
        if (!mounted) return;
        setState(() => initialUri = uri);
      } catch (e) {
        print('UniLinks Error : $e');
      }
    }
  }

  void _handleIncomingLinks() {
    StreamSubscription? sub;
    sub = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      print('UniLinks Incoming : $uri');
      _linkRouting(uri);
    }, onError: (Object e) {
      if (!mounted) return;
      print('UniLinks Error : $err');
    });
  }

  void _linkRouting(Uri? uri) {
    print('DeepLinking : ${uri?.path ?? ''}');
    if (uri != null) {
      final homeController = Get.find<HomeController>();
      if (uri.path.contains('/virtual')) homeController.selectedIndex(1);
      if (uri.path.contains('/tenx')) homeController.selectedIndex(2);
      if (uri.path.contains('/marginx')) homeController.selectedIndex(3);
      if (uri.path.contains('/testzone')) homeController.selectedIndex(4);
    }
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
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
