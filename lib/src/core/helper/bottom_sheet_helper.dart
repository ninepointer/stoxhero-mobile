import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class BottomSheetHelper {
  static openBottomSheet({
    required BuildContext context,
    required Widget? child,
  }) {
    Get.closeAllSnackbars();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: child ?? SizedBox(),
        );
      },
    );
  }
}
