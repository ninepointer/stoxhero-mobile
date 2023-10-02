import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/base/base.dart';
import 'package:stoxhero/src/data/data.dart';
import 'package:stoxhero/src/data/models/request/withdrawal_request.dart';

import '../../../core/core.dart';

class WalletBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => WalletController());
}

class WalletController extends BaseController<WalletRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;
  final token = ''.obs;

  final totalCashAmount = RxNum(0);
  final walletTransactionsList = <WalletTransaction>[].obs;
  final amountTextController = TextEditingController();
  final amount = 0.obs;

  void onConfirm() {
    print('Confirmed');
    withdrawals();
    Get.back();
  }

  void onCancel() {
    print('Cancelled');
    Get.back();
  }

  void loadData() async {
    getWalletTransactionsList();
  }

  Future getWalletTransactionsList() async {
    isLoading(true);
    try {
      final RepoResponse<WalletTransactionsListResponse> response =
          await repository.getWalletTransactionsList();
      if (response.data != null) {
        totalCashAmount(0);
        walletTransactionsList((response.data?.data?.transactions ?? []));
        walletTransactionsList.forEach((element) {
          totalCashAmount.value += element.amount ?? 0;
        });
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future withdrawals() async {
    isLoading(true);
    WithdrawalRequest data = WithdrawalRequest(
      amount: int.tryParse(amountTextController.text) ?? 0,
    );

    try {
      final RepoResponse<GenericResponse> response = await repository.withdrawals(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {}
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
