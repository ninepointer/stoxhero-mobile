import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../core/core.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() => Get.put(HomeController());
}

class HomeController extends GetxController {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }
}
