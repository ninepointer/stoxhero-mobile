import 'dart:developer';

import 'package:get/get.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() => Get.put(HomeController());
}

class HomeController extends BaseController<DashboardRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final userDashboard = DashboardTradeSummary().obs;
  final userDashboardReturnSummary = DashboardReturnSummary().obs;
  final dashboardCarouselList = <DashboardCarousel>[].obs;

  String selectedTradeType = 'virtual';
  String selectedTimeFrame = 'this month';
  List<String> tradeTypes = ['virtual', 'contest', 'tenx'];
  List<String> timeFrames = ['this month', 'last month', 'lifetime'];

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
    Get.find<TenxTradingController>().loadUserDetails();
    Get.find<TenxTradingController>().getTenxTradingActiveSubs();
  }

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getDashboardReturnSummary();
    await getDashboardCarousel();
    await getDashboard(selectedTradeType, selectedTimeFrame);
  }

  Future getDashboardReturnSummary() async {
    isLoading(true);
    try {
      final RepoResponse<DashboardReturnSummaryResponse> response =
          await repository.getDashboardReturnSummary();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          userDashboardReturnSummary(response.data?.data);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('return ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getDashboard(String? tradeType, String? timeFame) async {
    isLoading(true);
    try {
      final RepoResponse<DashboardTradeSummaryResponse> response =
          await repository.getDashboard(tradeType, timeFame);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          userDashboard(response.data?.data);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('trade ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getDashboardCarousel() async {
    isLoading(true);
    try {
      final RepoResponse<DashboardCarouselResponse> response =
          await repository.getDashboardCarousel();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          dashboardCarouselList(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('car ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }
}
