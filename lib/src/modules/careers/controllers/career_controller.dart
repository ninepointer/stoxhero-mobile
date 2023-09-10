import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/base.dart';

class CareerBinding implements Bindings {
  @override
  void dependencies() => Get.put(CareerController());
}

class CareerController extends BaseController {
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final dobTextController = TextEditingController();

  void showDateRangePicker(BuildContext context, {bool isStartDate = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      String date = DateFormat("dd-MM-yyyy").format(pickedDate);
      dobTextController.text = date;
    }
  }

  String? selectedValue1;
  String? selectedValue2;

  final List<String> dropdownItems1 = ['Yes', 'No'];
  final List<String> dropdownItems2 = [
    'LinkedIn',
    'Facebook',
    'Instagram',
    'Twitter',
    'Google',
    'Friend',
    'Others'
  ];
}
