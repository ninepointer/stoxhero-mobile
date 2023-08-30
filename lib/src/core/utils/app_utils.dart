import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {}

class LoadingUtils {
  static var isLoading = false;

  static void showLoader() {
    if (!isLoading) {
      Get.dialog(
        barrierDismissible: false,
        PopScope(
          canPop: false,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
      isLoading = true;
    }
  }

  static void hideLoader() {
    if (isLoading) {
      Get.close(1);
      isLoading = false;
    }
  }
}
