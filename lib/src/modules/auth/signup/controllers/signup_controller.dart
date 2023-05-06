import 'package:get/get.dart';

class SignupBinding implements Bindings {
  @override
  void dependencies() => Get.put(SignupController());
}

class SignupController extends GetxController {}
