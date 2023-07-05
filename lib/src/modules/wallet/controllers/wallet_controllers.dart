import 'dart:developer';

import 'package:get/get.dart';
import 'package:stoxhero/src/base/base.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../core/core.dart';

class WalletBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => WalletController());
}

class WalletController extends BaseController<WalletRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final totalCashAmount = RxNum(0);

  final walletTransactionsList = <WalletTransaction>[].obs;

  void loadData() async {
    getWalletTransactionsList();
  }

  Future getWalletTransactionsList() async {
    isLoading(true);
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
    isLoading(false);
  }
}
