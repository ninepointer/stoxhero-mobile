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

  final walletTransactionsList = <WalletTransaction>[].obs;

  void loadData() async {
    getWalletTransactionsList();
  }

  Future getWalletTransactionsList() async {
    isLoading(true);
    try {
      final RepoResponse<WalletTransactionsListResponse> response = await repository.getWalletTransactionsList();
      if (response.data != null) {
        walletTransactionsList((response.data?.data?.transactions ?? []));
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
