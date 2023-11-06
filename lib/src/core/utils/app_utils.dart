import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

class AppUtils {}

class LoadingUtils {
  static var isLoading = false;

  static void showLoader() {
    if (!isLoading) {
      // Get.dialog(
      //   barrierDismissible: false,
      //   PopScope(
      //     canPop: false,
      //     child: Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   ),
      // );
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

extension EncodingExtensions on String {
  String get toBase64 => base64.encode(toUtf8);
  List<int> get toUtf8 => utf8.encode(this);
  String get toSha256 => sha256.convert(toUtf8).toString();
}
