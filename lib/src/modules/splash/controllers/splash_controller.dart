import 'dart:developer';
import 'package:get/get.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../main.dart';
import '../../../core/core.dart';
import '../../modules.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SplashController());
}

class SplashController extends GetxController {
  final _appVersion = ''.obs;
  String get appVersion => 'v ${_appVersion.value}';

  final _storeAppVersion = ''.obs;

  @override
  void onInit() async {
    await getAppVersion();
    if (isProd) await checkForUpdate();
    _startOnBoarding();
    super.onInit();
  }

  Future checkForUpdate() async {
    print('App version : $_appVersion');
    print('Store version : $_storeAppVersion');

    List<String> playStoreVersion = _appVersion.split("+");
    List<String> currentVersion = _storeAppVersion.split("+");

    int mainVersion = playStoreVersion[0].compareTo(currentVersion[0]);

    if (mainVersion < 0) {
      await Get.dialog(UpdateAlertDialog());
    } else {
      int playStoreBuild = int.parse(playStoreVersion[1]);
      int currentBuild = int.parse(currentVersion[1]);
      if (playStoreBuild < currentBuild) {
        await Get.dialog(UpdateAlertDialog());
      }
    }
  }

  Future getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String version = packageInfo.version;
      String build = packageInfo.buildNumber;

      _appVersion('$version+$build');
      if (isProd) {
        final response = await Get.find<AuthController>().repository.getAppVersion();
        if (response.data != null) {
          _storeAppVersion(response.data?.data ?? '');
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _startOnBoarding() async {
    bool isNewUser = AppStorage.getNewUserStatus();
    await Future.delayed(Duration(seconds: 3));
    try {
      if (isNewUser) {
        FirebaseAnalytics.instance.logEvent(name: 'new_user_logged');
        Get.offAllNamed(AppRoutes.onBoarding);
        AppStorage.setNewUserStatus(false);
      } else {
        String? token = AppStorage.getToken();
        await Future.delayed(Duration(seconds: 1));
        if (useTestToken) {
          await Get.find<AuthController>().getUserDetails();
        } else {
          if (token == null || token.isEmpty) {
            Get.offAllNamed(AppRoutes.signin);
          } else {
            FirebaseAnalytics.instance.logEvent(name: 'user_login', parameters: {
              'id': AppStorage.getUserDetails().sId,
              'email': AppStorage.getUserDetails().email,
            });
            await Get.find<AuthController>().getUserDetails();
          }
        }
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }
}
