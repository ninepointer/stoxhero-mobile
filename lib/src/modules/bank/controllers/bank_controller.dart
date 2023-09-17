import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/base_controller.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class BankBinding implements Bindings {
  @override
  void dependencies() => Get.put(BankController());
}

class BankController extends BaseController {
  final userDetails = LoginDetailsResponse().obs;
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final isEditEnabled = false.obs;

  final upiIdTextController = TextEditingController();
  final googlePayNumberTextController = TextEditingController();
  final phonePeNumberTextController = TextEditingController();
  final paytmNumberTextController = TextEditingController();
  final nameAsPerBankAccountTextController = TextEditingController();
  final bankNameTextController = TextEditingController();
  final accountNumberTextController = TextEditingController();
  final ifscCodeTextController = TextEditingController();

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
  }

  Future saveUserBankDetails() async {
    isLoading(true);

    // Map<String, dynamic> data = {
    //   'upiId': upiIdTextController.text,
    //   'googlePay_number': googlePayNumberTextController.text,
    //   'phonePe_number': phonePeNumberTextController.text,
    //   'paytm_number': paytmNumberTextController.text,
    //   'nameAsPerBankAccount': nameAsPerBankAccountTextController.text,
    //   'accountNumber': accountNumberTextController.text,
    //   'ifscCode': ifscCodeTextController.text,
    // };
  }
}
