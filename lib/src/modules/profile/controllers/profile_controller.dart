import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stoxhero/src/base/base.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../core/core.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() => Get.put(ProfileController());
}

class ProfileController extends BaseController<ProfileRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final isEditEnabled = false.obs;

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

  void loadData() {
    loadProfileDetails();
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
    userDetails(AppStorage.getUserDetails());
    userNameTextController.text = userDetails.value.employeeid ?? '';
    positionTextController.text = userDetails.value.designation ?? '';
    firstNameTextController.text = userDetails.value.firstName ?? '';
    lastNameTextController.text = userDetails.value.lastName ?? '';
    emailTextController.text = userDetails.value.email ?? '';
    mobileTextController.text = userDetails.value.mobile ?? '';
    dobTextController.text = formatDate(userDetails.value.dob);
    genderTextController.text = userDetails.value.gender ?? '';
    addressTextController.text = userDetails.value.address ?? '';
    cityTextController.text = userDetails.value.city ?? '';
    pincodeTextController.text = userDetails.value.pincode ?? '';
    stateTextController.text = userDetails.value.state ?? '';
    countryTextController.text = userDetails.value.country ?? '';
  }

  String getUserFullName() {
    String firstName = userDetailsData.firstName ?? '';
    String lastName = userDetailsData.lastName ?? '';
    String fullName = '$firstName $lastName';
    return fullName.capitalize!;
  }

  Future saveUserProfileDetails() async {
    isLoading(true);

    Map<String, dynamic> data = {
      "first_name": firstNameTextController.text,
      "last_name": lastNameTextController.text,
      "email": emailTextController.text,
      "mobile": mobileTextController.text,
      "gender": genderTextController.text,
      "dob": dobTextController.text,
      "address": addressTextController.text,
      "city": cityTextController.text,
      "pincode": pincodeTextController.text,
      "state": stateTextController.text,
      "country": countryTextController.text,
    };

    try {
      final RepoResponse<GenericResponse> response = await repository.updateUserDetails(data);
      if (response.data != null) {
        await AppStorage.setUserDetails(
          LoginDetailsResponse.fromJson(response.data?.data),
        );
        log('AppStorage.getUserDetails : ${AppStorage.getUserDetails().toJson()}');
        SnackbarHelper.showSnackbar(response.data?.message);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }

    isLoading(false);
  }
}
