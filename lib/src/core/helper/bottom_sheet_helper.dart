import 'package:flutter/material.dart';

class BottomSheetHelper {
  static openBottomSheet({
    required BuildContext context,
    required Widget? child,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return child ?? SizedBox();
      },
    );
  }
}
