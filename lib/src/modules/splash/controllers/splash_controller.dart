import 'dart:developer';

import 'package:get/get.dart';
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
    await Future.delayed(Duration(seconds: 3));
    try {
      if (isNewUser) {
        Get.offAllNamed(AppRoutes.onBoarding);
        AppStorage.setNewUserStatus(false);
      } else {
        String? token = AppStorage.getToken();
        await Future.delayed(Duration(seconds: 1));
        if (useTestToken) {
          await Get.find<AuthController>().getUserDetails();
          log('Test: ${AppStorage.getUserDetails().toJson()}');
          log('Get: ${AppStorage.getToken()}');
        } else {
          if (token == null || token.isEmpty) {
            Get.offAllNamed(AppRoutes.signin);
          } else {
            await Get.find<AuthController>().getUserDetails();
          }
        }
      }
    }
    // try {
    //   if (isNewUser) {
    //     Get.offAllNamed(AppRoutes.onBoarding);
    //     AppStorage.setNewUserStatus(false);
    //   } else {
    //     // await Get.find<AuthController>().getUserDetails();
    //     String? token = AppStorage.getToken();
    //     await Future.delayed(Duration(seconds: 1));
    //     if (token == null || token.isEmpty) {
    //       Get.offAllNamed(AppRoutes.signin);
    //     } else {
    //       await Get.find<AuthController>().getUserDetails();
    //     }
    //   }
    // }
    catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }
}
