import 'dart:developer';

import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';

class TenxTradingBinding implements Bindings {
  @override
  void dependencies() => Get.put(TenxTradingController());
}

class TenxTradingController extends GetxController {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final tenxActiveSub = <TenxActiveSubscription>[].obs;

  void getTenxTradingActiveSubs() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingActiveResponse> response =
          await Get.find<TenxTradingRepository>().getTenxActiveSubscriptions();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxActiveSub(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }
}
