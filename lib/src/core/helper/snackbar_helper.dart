import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

class SnackbarHelper {
  static showSnackbar(String? message, {Color? backgroundColor}) {
    if (message == null || message.isEmpty) {
      return;
    } else {
      return Get.showSnackbar(
        GetSnackBar(
          message: message,
          margin: EdgeInsets.all(16),
          borderRadius: 8,
          duration: Duration(seconds: 3),
          backgroundColor: backgroundColor ?? AppColors.black,
        ),
      );
    }
  }
}
