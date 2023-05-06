import 'package:get/get.dart';

class SigninBinding implements Bindings {
  @override
  void dependencies() => Get.put(SigninController());
}

class SigninController extends GetxController {}
