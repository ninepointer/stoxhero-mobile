import 'dart:developer';
import 'dart:io';

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

  final isCouponCodeLoading = false.obs;
  bool get isCouponCodeLoadingStatus => isCouponCodeLoading.value;

  final totalCashAmount = RxNum(0);
  final walletTransactionsList = <WalletTransaction>[].obs;
  final withdrawalTransactionsList = <MyWithdrawalsList>[].obs;
  final amountTextController = TextEditingController();
  final amount = 0.obs;

  final selectedTabBarIndex = 0.obs;
  final selectedSecondTabBarIndex = 0.obs;

  final addMoneyAmountTextController = TextEditingController();

  final couponCodeTextController = TextEditingController();
  final isCouponCodeAdded = false.obs;
  final couponCodeSuccessText = "".obs;
  final actualSubscriptionAmount = 0.0.obs;
  final subscriptionAmount = 0.0.obs;

  final paymentGroupValue = 'wallet'.obs;
  final selectedPaymentValue = 'wallet'.obs;

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

  Future loadData() async {
    getWalletTransactionsList();
    getMyWithdrawalsTransactionsList();
  }

  String getPaymentProductType(ProductType type) {
    String productType = '';
    switch (type) {
      case ProductType.tenx:
        productType = 'TenX';
        break;
      case ProductType.contest:
        productType = 'Contest';
        break;
      case ProductType.marginx:
        productType = 'MarginX';
        break;
      case ProductType.battle:
        productType = 'Battle';
        break;
      default:
    }
    return productType;
  }

  void removeCouponCode() {
    couponCodeSuccessText("");
    isCouponCodeAdded(false);
    subscriptionAmount(actualSubscriptionAmount.value);
    couponCodeTextController.clear();
  }

  void calculateDiscount({
    String? couponCode,
    String? discountType,
    String? rewardType,
    num? discount,
    num? maxDiscount = 1000,
    num? planAmount,
  }) {
    if (rewardType == 'Discount') {
      if (discountType == 'Flat') {
        subscriptionAmount((planAmount! - discount!).toDouble());
      } else if (discountType == 'Percentage') {
        double maxDiscountAmount = (planAmount! * (discount! / 100)).toDouble();
        if (maxDiscountAmount.isGreaterThan(maxDiscount!)) {
          subscriptionAmount((planAmount - maxDiscount).toDouble());
        } else {
          subscriptionAmount(planAmount - (planAmount * (discount / 100))).clamp(0, maxDiscount).toDouble();
        }
      }
    } else {
      if (discountType == 'Flat') {
        subscriptionAmount((planAmount! - discount!).toDouble());
      } else if (discountType == 'Percentage') {
        double maxDiscountAmount = (planAmount! * (discount! / 100)).toDouble();
        if (maxDiscountAmount.isGreaterThan(maxDiscount!)) {
          subscriptionAmount((planAmount - maxDiscount).toDouble());
        } else {
          subscriptionAmount(planAmount - (planAmount * (discount / 100))).clamp(0, maxDiscount).toDouble();
        }
      }
    }
    couponCodeSuccessText("Applied $couponCode - (₹$discount% off upto ₹$maxDiscount)");
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
        if (response.data?.status?.toLowerCase() == "success") {
          SnackbarHelper.showSnackbar(response.data?.message);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }

    isLoading(false);
  }

  Future verifyCouponCode(BuildContext context, ProductType productType, num amount) async {
    isCouponCodeAdded(false);
    if (couponCodeTextController.text.isEmpty) {
      SnackbarHelper.showSnackbar('Enter valid coupon code!');
      return;
    }
    FocusScope.of(context).unfocus();
    isCouponCodeLoading(true);

    String product = '';

    if (productType == ProductType.contest) {
      product = '6517d48d3aeb2bb27d650de5';
    } else if (productType == ProductType.tenx) {
      product = '6517d3803aeb2bb27d650de0';
    } else if (productType == ProductType.marginx) {
      product = '6517d40e3aeb2bb27d650de1';
    }

    var data = VerifyCouponCodeRequest(
      code: couponCodeTextController.text.trim(),
      product: product,
      orderValue: amount,
      paymentMode: 'wallet',
      platform: Platform.isAndroid ? 'Android' : 'iOS',
    );

    try {
      final RepoResponse<VerifyCouponCodeResponse> response = await repository.verifyCouponCode(data.toJson());
      if (response.data != null && response.data?.status == 'success') {
        var couponData = response.data?.data;
        isCouponCodeAdded(true);
        calculateDiscount(
          couponCode: couponCodeTextController.text.trim(),
          discountType: couponData?.discountType,
          rewardType: couponData?.rewardType,
          discount: couponData?.discount,
          maxDiscount: couponData?.maxDiscount,
          planAmount: amount,
        );
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isCouponCodeLoading(false);
  }

  Future<bool> initPaymentRequest(PaymentRequest data) async {
    try {
      final RepoResponse<GenericResponse> response = await repository.makePayment(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          return true;
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
      return false;
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    return false;
  }

  Future<bool> checkPaymentStatus(String id) async {
    try {
      final RepoResponse<CheckPaymentStatusResponse> response = await repository.checkPaymentStatus(
        id,
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          if (response.data?.data?.code == 'PAYMENT_SUCCESS')
            return true;
          else if (response.data?.data?.code == 'PAYMENT_ERROR') return false;
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
      return false;
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    return false;
  }
}
