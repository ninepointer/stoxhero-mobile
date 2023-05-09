import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../core/core.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() => Get.put(ProfileController());
}

class ProfileController extends GetxController {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final userNameTextController = TextEditingController();
  final positionTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final pincodeTextController = TextEditingController();
  final stateTextController = TextEditingController();
  final countryTextController = TextEditingController();

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  String formatDate(String? value) {
    if (value != null) {
      DateTime dateTime = DateTime.parse(value);
      String formattedString = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedString;
    } else {
      return '';
    }
  }

  void loadProfileDetails() {
    userNameTextController.text = userDetails.value.employeeid ?? '';
    positionTextController.text = userDetails.value.designation ?? '';
    firstNameTextController.text = userDetails.value.firstName ?? '';
    lastNameTextController.text = userDetails.value.lastModified ?? '';
    emailTextController.text = userDetails.value.email ?? '';
    mobileTextController.text = userDetails.value.mobile ?? '';
    dobTextController.text = formatDate(userDetails.value.dob);
    genderTextController.text = userDetails.value.gender ?? '';
    addressTextController.text = userDetails.value.address ?? '';
    cityTextController.text = userDetails.value.city ?? '';
    pincodeTextController.text = userDetails.value.location ?? '';
    stateTextController.text = userDetails.value.state ?? '';
    countryTextController.text = userDetails.value.country ?? '';
  }

  String getUserFullName() {
    String firstName = userDetailsData.firstName ?? '';
    String lastName = userDetailsData.lastName ?? '';
    String fullName = '$firstName $lastName';
    return fullName.capitalize!;
  }
}
