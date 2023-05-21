import 'dart:developer';

import 'package:get/get.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class PortfolioBinding implements Bindings {
  @override
  void dependencies() => Get.put(PortfolioController());
}

class PortfolioController extends BaseController<PortfolioRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final portfoliList = <Portfolio>[].obs;

  void loadData() {
    getPortfolioList();
  }

  void getPortfolioList() async {
    isLoading(true);
    try {
      final RepoResponse<PortfolioResponse> response = await repository.getPortfolioList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          portfoliList(response.data?.data ?? []);
          Get.toNamed(AppRoutes.portfolio);
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
}
