import 'dart:developer';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SplashController());
}

class SplashController extends GetxController {
  final _appVersion = ''.obs;
  String get appVersion => _appVersion.value;

  @override
  void onInit() {
    _startOnBoarding();
    super.onInit();
  }

  void _startOnBoarding() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String build = packageInfo.buildNumber;

    _appVersion('v $version+$build');
    bool isNewUser = AppStorage.getNewUserStatus();
    print("isNewUser $isNewUser");
    if (isNewUser) {
      await Future.delayed(Duration(seconds: 3));
      AppStorage.setNewUserStatus(false);
      Get.offAllNamed(AppRoutes.onBoarding);
    } else {
      String? token = AppStorage.getToken();
      await Future.delayed(Duration(seconds: 1));
      await Get.find<AuthController>().getUserDetails();
      try {
        // if (token == null || token.isEmpty) {
        //   Get.offAllNamed(AppRoutes.signin);
        // } else {
        //   await Get.find<AuthController>().getUserDetails();
        // }
      } catch (e) {
        log(e.toString());
        SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
      }
    }
  }
}
