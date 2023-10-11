import 'dart:developer';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
    await checkForUpdate();
    _startOnBoarding();
    super.onInit();
  }

  Future checkForUpdate() async {
    await getAppVersion();
    print('App version : $_appVersion');
    print('Store version : $_storeAppVersion');
    if (_storeAppVersion.value.isNotEmpty) {
      if (_appVersion.value != _storeAppVersion.value) {
        print('Need App Update!');
        await Get.dialog(
          AlertDialog(
            contentPadding: EdgeInsets.all(16),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.update_rounded,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Update Available',
                  style: Theme.of(Get.context!).textTheme.tsPrimaryMedium18,
                ),
                SizedBox(height: 8),
                Text(
                  'Kindly update the StoxHero app to the latest version to continue!',
                  style: Theme.of(Get.context!).textTheme.tsRegular16,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CommonOutlinedButton(
                        width: double.infinity,
                        height: 40,
                        label: 'Cancel',
                        onPressed: Get.back,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CommonFilledButton(
                        width: double.infinity,
                        height: 40,
                        label: 'Update',
                        onPressed: openAppPage,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  void openAppPage() {
    final appId = Platform.isAndroid ? 'com.stoxhero.app' : 'com.stoxhero.app';
    final url = Uri.parse(
      Platform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id$appId",
    );
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String version = packageInfo.version;
      String build = packageInfo.buildNumber;

      _appVersion('$version+$build');

      final response = await Get.find<AuthController>().repository.getAppVersion();
      if (response.data != null) {
        _storeAppVersion(response.data?.data ?? '');
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
          log('Test: ${AppStorage.getUserDetails().toJson()}');
          log('Get: ${AppStorage.getToken()}');
          FirebaseAnalytics.instance.logEvent(name: 'user_login', parameters: {
            'id': AppStorage.getUserDetails().sId,
            'email': AppStorage.getUserDetails().email,
          });
        } else {
          if (token == null || token.isEmpty) {
            Get.offAllNamed(AppRoutes.signin);
          } else {
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
