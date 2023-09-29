import 'package:flutter/material.dart';

class BottomSheetHelper {
  static openBottomSheet({
    required BuildContext context,
    required Widget? child,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return child ?? SizedBox();
      },
    );
  }
}
