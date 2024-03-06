import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

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
  final walletDetails = WalletDetails().obs;
  final amountTextController = TextEditingController();
  final readSetting = ReadSettingResponse().obs;
  final amount = 0.obs;

  final selectedTabBarIndex = 0.obs;
  final selectedSecondTabBarIndex = 0.obs;

  final addMoneyAmountTextController = TextEditingController();

  final couponCodeTextController = TextEditingController();
  final isCouponCodeAdded = false.obs;
  final couponCodeSuccessText = "".obs;
  final actualSubscriptionAmount = 0.0.obs;
  final subscriptionAmount = 0.0.obs;
  final heroCashAmount = 0.0.obs;
  final amountAfterCouponAdded = 0.0.obs;

  final paymentGroupValue = 'wallet'.obs;
  final selectedPaymentValue = 'wallet'.obs;
  final isHeroCashAdded = false.obs;

  void changeTabBarIndex(int val) => selectedTabBarIndex.value = val;

  void changeSecondTabBarIndex(int val) =>
      selectedSecondTabBarIndex.value = val;

  void onConfirm() {
    if (amountTextController.text.isEmpty) {
      SnackbarHelper.showSnackbar('Enter valid amount!');
    } else {
      withdrawals();
      Get.back();
      amountTextController.clear();
    }
  }

  void onCancel() {
    Get.back();
    amountTextController.clear();
  }

  Future loadData() async {
    getWalletTransactionsList();
    getMyWithdrawalsTransactionsList();
    getReadSetting();
  }

  String getUserFullName() {
    String firstName = walletDetails.value.userId?.firstName ?? '';
    String lastName = walletDetails.value.userId?.lastName ?? '';
    String fullName = '$firstName $lastName';
    return fullName.capitalize!;
  }

  num calculateBonus(List<WalletTransaction> transactions) {
    num bonus = 0;

    for (var transaction in transactions) {
      if (transaction.transactionType == 'Bonus') {
        bonus += transaction.amount ?? 0;
      }
    }

    return bonus;
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
      case ProductType.course:
        productType = 'Course';
        break;
      default:
    }
    return productType;
  }

  void removeCouponCode(num heroCash) {
    couponCodeSuccessText("");
    isCouponCodeAdded(false);
    subscriptionAmount(isHeroCashAdded.value
        ? actualSubscriptionAmount.value - calculateHeroCash
        : actualSubscriptionAmount.value);
    couponCodeTextController.clear();
  }

  void addHeroCash(num heroCash, {bool? isSecondTimeClick = false}) {
    if (isCouponCodeAdded.value) {
      subscriptionAmount(amountAfterCouponAdded.value - heroCash);
    } else {
      subscriptionAmount(subscriptionAmount.value - heroCash);
    }
  }

  void removeHeroCash(num heroCash) {
    heroCashAmount(0.0);
    subscriptionAmount(subscriptionAmount.value + heroCash);
  }

  num get calculateHeroCash {
    return isCouponCodeAdded.value
        ? math.min(
            (amountAfterCouponAdded.value) *
                ((readSetting.value.maxBonusRedemptionPercentage ?? 0) / 100),
            (calculateBonus(walletTransactionsList) /
                (readSetting.value.bonusToUnitCashRatio ?? 1)),
          )
        : math.min(
            (actualSubscriptionAmount.value) *
                ((readSetting.value.maxBonusRedemptionPercentage ?? 0) / 100),
            (calculateBonus(walletTransactionsList) /
                (readSetting.value.bonusToUnitCashRatio ?? 1)));
  }

  void calculateDiscount({
    String? couponCode,
    String? discountType,
    String? rewardType,
    num? discount,
    num? maxDiscount = 1000,
    num? planAmount,
    num? heroCashAmount,
  }) {
    if (rewardType == 'Discount') {
      if (discountType == 'Flat') {
        subscriptionAmount(
            (planAmount! - discount! - heroCashAmount!).toDouble());
      } else if (discountType == 'Percentage') {
        double maxDiscountAmount = (planAmount! * (discount! / 100)).toDouble();
        if (maxDiscountAmount.isGreaterThan(maxDiscount!)) {
          subscriptionAmount(
              (planAmount - maxDiscount - heroCashAmount!).toDouble());
        } else {
          subscriptionAmount(planAmount -
                  (planAmount * (discount / 100)) -
                  heroCashAmount!)
              .clamp(0, maxDiscount)
              .toDouble();
        }
      }
    } else {
      if (discountType == 'Flat') {
        subscriptionAmount(
            (planAmount! - discount! - heroCashAmount!).toDouble());
      } else if (discountType == 'Percentage') {
        double maxDiscountAmount = (planAmount! * (discount! / 100)).toDouble();
        if (maxDiscountAmount.isGreaterThan(maxDiscount!)) {
          subscriptionAmount(
              (planAmount - maxDiscount - heroCashAmount!).toDouble());
        } else {
          subscriptionAmount(planAmount -
                  (planAmount * (discount / 100)) -
                  heroCashAmount!)
              .clamp(0, maxDiscount)
              .toDouble();
        }
      }
    }

    if (rewardType == 'Discount') {
      couponCodeSuccessText(
          "Applied $couponCode - ($discount% off upto ${FormatHelper.formatNumbers(maxDiscount, decimal: 0)})");
    } else {
      couponCodeSuccessText(
          "Applied $couponCode - ($discount% cashback  upto ${FormatHelper.formatNumbers(maxDiscount, decimal: 0)})");
    }
    amountAfterCouponAdded(subscriptionAmount.value);
  }

  Future getWalletTransactionsList() async {
    isRecentLoading(true);
    try {
      final RepoResponse<WalletTransactionsListResponse> response =
          await repository.getWalletTransactionsList();
      if (response.data != null) {
        totalCashAmount(0);
        walletTransactionsList((response.data?.data?.transactions ?? []));
        walletTransactionsList.forEach((element) {
          if (element.transactionType == 'Cash') {
            totalCashAmount.value += element.amount ?? 0;
          }
        });
        walletDetails(response.data?.data);
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
      final RepoResponse<MyWithdrawalsListResponse> response =
          await repository.getMyWithdrawalsTransactionsList();
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
      final RepoResponse<GenericResponse> response =
          await repository.withdrawals(
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

  Future verifyCouponCode(
      BuildContext context, ProductType productType, num amount) async {
    isCouponCodeAdded(false);
    if (amount == 0) {
      amount = num.parse(addMoneyAmountTextController.text);
    }
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
    } else if (productType == ProductType.wallet) {
      product = '651bdbc8da68770e8f1b8e09';
    }

    print("productType$product");
    var data = VerifyCouponCodeRequest(
      code: couponCodeTextController.text.trim(),
      product: product,
      orderValue: amount,
      paymentMode: selectedPaymentValue.value == "wallet"
          ? "wallet"
          : selectedPaymentValue.value == "gateway"
              ? "bank"
              : "addition",
      platform: Platform.isAndroid ? 'Android' : 'iOS',
    );

    try {
      final RepoResponse<VerifyCouponCodeResponse> response =
          await repository.verifyCouponCode(data.toJson());
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
            heroCashAmount: isHeroCashAdded.value ? calculateHeroCash : 0);
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
      final RepoResponse<GenericResponse> response =
          await repository.makePayment(
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
      final RepoResponse<CheckPaymentStatusResponse> response =
          await repository.checkPaymentStatus(
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

  Future getReadSetting() async {
    isRecentLoading(true);
    try {
      final RepoResponse<ReadSettingResponse> response =
          await repository.readSetting();
      readSetting(response.data);
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isRecentLoading(false);
  }
}
