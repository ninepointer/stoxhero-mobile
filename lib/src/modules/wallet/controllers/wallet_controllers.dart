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
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;
  final token = ''.obs;
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final isRecentLoading = false.obs;
  bool get isRecentLoadingStatus => isRecentLoading.value;

  final isSuccessLoading = false.obs;
  bool get isSuccessLoadingStatus => isSuccessLoading.value;

  final totalCashAmount = RxNum(0);
  final walletTransactionsList = <WalletTransaction>[].obs;
  final withdrawalTransactionsList = <MyWithdrawalsList>[].obs;
  final amountTextController = TextEditingController();
  final amount = 0.obs;

  final selectedTabBarIndex = 0.obs;
  final selectedSecondTabBarIndex = 0.obs;

  void changeTabBarIndex(int val) => selectedTabBarIndex.value = val;
  void changeSecondTabBarIndex(int val) => selectedSecondTabBarIndex.value = val;

  void onConfirm() {
    if (amountTextController.text.isEmpty) {
      SnackbarHelper.showSnackbar('Enter valid amount!');
    } else {
      withdrawals();
      Get.back();
    }
  }

  void onCancel() => Get.back();

  void loadData() async {
    getWalletTransactionsList();
    getMyWithdrawalsTransactionsList();
  }

  Future getWalletTransactionsList() async {
    isRecentLoading(true);
    try {
      final RepoResponse<WalletTransactionsListResponse> response = await repository.getWalletTransactionsList();
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
    isRecentLoading(false);
  }

  Future getMyWithdrawalsTransactionsList() async {
    isSuccessLoading(true);
    try {
      final RepoResponse<MyWithdrawalsListResponse> response = await repository.getMyWithdrawalsTransactionsList();
      if (response.data != null) {
        withdrawalTransactionsList((response.data?.data ?? []));
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isSuccessLoading(false);
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
