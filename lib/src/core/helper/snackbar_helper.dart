import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

class SnackbarHelper {
  static showSnackbar(String? message, {Color? backgroundColor}) {
    return Get.showSnackbar(
      GetSnackBar(
        message: message ?? "Message",
        duration: Duration(seconds: 3),
        backgroundColor: backgroundColor ?? AppColors.black,
      ),
    );
  }
}
