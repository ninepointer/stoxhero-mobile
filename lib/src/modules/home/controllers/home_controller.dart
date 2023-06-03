import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() => Get.put(HomeController());
}

class HomeController extends GetxController {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
    Get.find<TenxTradingController>().getTenxTradingActiveSubs();
  }
}
