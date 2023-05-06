import 'package:get/get.dart';

class OtpBinding implements Bindings {
  @override
  void dependencies() => Get.put(OtpController());
}

class OtpController extends GetxController {}
