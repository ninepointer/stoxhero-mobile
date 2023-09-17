import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

import '../../../base/base.dart';

class CareerBinding implements Bindings {
  @override
  void dependencies() => Get.put(CareerController());
}

class CareerController extends BaseController<CareerRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final careerList = <CareerList>[].obs;

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
  String? selectedValue3;

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
  final List<String> dropdownItems3 = [];

  Future getCareerList(String? type) async {
    isLoading(true);
    try {
      final RepoResponse<CareerResponse> response = await repository.getCareerList(type);
      if (response.data != null) {
        careerList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Career: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }
}
