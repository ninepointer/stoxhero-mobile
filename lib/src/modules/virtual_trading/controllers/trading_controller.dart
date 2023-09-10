import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class TradingBinding implements Bindings {
  @override
  void dependencies() => Get.put(TradingController());
}

class TradingController extends BaseController {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final searchTextController = TextEditingController();

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    // searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.tenxSearchSymbol);
  }

  void loadUserDetails() {
    userDetails.value = AppStorage.getUserDetails();
  }

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
  }
}
