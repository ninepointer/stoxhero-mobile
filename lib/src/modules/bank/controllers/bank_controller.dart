import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/base_controller.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class BankBinding implements Bindings {
  @override
  void dependencies() => Get.put(BankController());
}

class BankController extends BaseController<ProfileRepository> {
  final userDetails = LoginDetailsResponse().obs;
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final isEditEnabled = false.obs;
  File? image;

  final upiIdTextController = TextEditingController();
  final googlePayNumberTextController = TextEditingController();
  final phonePeNumberTextController = TextEditingController();
  final paytmNumberTextController = TextEditingController();

  final nameAsPerBankAccountTextController = TextEditingController();
  final bankNameTextController = TextEditingController();
  final accountNumberTextController = TextEditingController();
  final ifscCodeTextController = TextEditingController();

  final aadhaarCardNumberTextController = TextEditingController();
  final panCardNumberTextController = TextEditingController();
  final drivingLicenseNumberTextController = TextEditingController();
  final passportCardNumberTextController = TextEditingController();

  void loadData() {
    loadBankDetails();
  }

  void loadBankDetails() {
    userDetails(AppStorage.getUserDetails());
    upiIdTextController.text = userDetails.value.upiId ?? '';
    googlePayNumberTextController.text = userDetails.value.googlePayNumber ?? '';
    phonePeNumberTextController.text = userDetails.value.phonePeNumber ?? '';
    paytmNumberTextController.text = userDetails.value.payTMNumber ?? '';
    nameAsPerBankAccountTextController.text = userDetails.value.nameAsPerBankAccount ?? '';
    bankNameTextController.text = userDetails.value.bankName ?? '';
    accountNumberTextController.text = userDetails.value.accountNumber ?? '';
    ifscCodeTextController.text = userDetails.value.ifscCode ?? '';
    aadhaarCardNumberTextController.text = userDetails.value.aadhaarNumber ?? '';
    panCardNumberTextController.text = userDetails.value.panNumber ?? '';
    passportCardNumberTextController.text = userDetails.value.passportNumber ?? '';
    drivingLicenseNumberTextController.text = userDetails.value.drivingLicenseNumber ?? '';
  }

  Future saveUserBankDetails() async {
    isLoading(true);
    Map<String, dynamic> data = {
      'upiId': upiIdTextController.text,
      'googlePay_number': googlePayNumberTextController.text,
      'phonePe_number': phonePeNumberTextController.text,
      'paytm_number': paytmNumberTextController.text,
      'bankName': bankNameTextController.text,
      'nameAsPerBankAccount': nameAsPerBankAccountTextController.text,
      'accountNumber': accountNumberTextController.text,
      'ifscCode': ifscCodeTextController.text,
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
      log('Save: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }

    isLoading(false);
  }

  Future saveUserKYCDetails() async {
    isLoading(true);
    Map<String, dynamic> data = {
      'aadhaarNumber': aadhaarCardNumberTextController.text,
      'panNumber': panCardNumberTextController.text,
      'passportNumber': passportCardNumberTextController.text,
      'drivingLicenseNumber': drivingLicenseNumberTextController.text,
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
      log('Save: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }

    isLoading(false);
  }
}
