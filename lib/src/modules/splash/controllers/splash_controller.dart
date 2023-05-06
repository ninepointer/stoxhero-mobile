import 'package:get/get.dart';

import '../../../core/core.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() => Get.put(SplashController());
}

class SplashController extends GetxController {
  @override
  void onInit() {
    _startOnBoarding();
    super.onInit();
  }

  void _startOnBoarding() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.signin);
  }
}
