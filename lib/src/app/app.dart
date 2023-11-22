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

  StreamSubscription? sub;

  @override
  void initState() {
    super.initState();
    _handleInitialUri();
    _handleIncomingLinks();
    _initializePushNotification();
  }

  Future _initializePushNotification() async {
    await NotificationServices.initializeNotificationService(context);
  }

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri != null) {
          print('got initial uri: $uri');
          // if (uri.path.contains('/contest')) {
          //   Get.toNamed(AppRoutes.contest);
          // }
        }
        if (!mounted) return;
        setState(() => initialUri = uri);
      } catch (e) {
        print('error : $e');
      }
    }
  }

  void _handleIncomingLinks() {
    sub = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      print('got uri: $uri');
      latestUri = uri;
    }, onError: (Object e) {
      if (!mounted) return;
      print('got err: $err');
      latestUri = null;
    });
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
