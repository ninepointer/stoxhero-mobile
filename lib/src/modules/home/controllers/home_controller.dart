import 'package:flutter/material.dart';

import '../../../app/app.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() => Get.put(HomeController());
}

class HomeController extends BaseController<DashboardRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;

  bool get isLoadingStatus => isLoading.value;

  final isPerformanceLoading = false.obs;
  final selectedIndex = 0.obs;

  final firstTimeshow = true.obs;
  bool get firstTimeshowStatus => firstTimeshow.value;

  final userDashboard = DashboardTradeSummary().obs;
  final userDashboardReturnSummary = DashboardReturnSummary().obs;
  final dashboardCarouselList = <DashboardCarousel>[].obs;
  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;

  String selectedTradeType = 'virtual';
  String selectedTimeFrame = 'this month';
  List<String> tradeTypes = ['virtual', 'contest', 'tenx'];
  List<String> timeFrames = [
    'this month',
    'last month',
    'previous to last month',
    'lifetime'
  ];

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
    loadData();
    Get.find<ContestProfileController>().getWeeklyTopPerformerFullList();
    Get.find<ContestController>().getLiveContestList();
    Get.find<ContestController>().getUpComingContestList();
    Get.find<CollegeContestController>().getLiveCollegeContestList();
    Get.find<WalletController>().getWalletTransactionsList();
    Get.find<ContestController>().getFeaturedContest();
    Get.find<ContestController>().getReadSetting();
  }

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getStockIndexInstrumentsList();
    await getDashboardReturnSummary();
    await getDashboardCarousel();
    await getDashboard(selectedTradeType, selectedTimeFrame);
    await liveIndexDetails();
    socketIndexConnection();
  }

  void navigateToCarousel(String link) {
    if (link == 'marginxs') {
      selectedIndex(3);

      Get.find<MarginXController>().loadData();
      // Get.toNamed(AppRoutes.marginx);
      // Get.to(() => MarginXView());
    } else if (link == 'testzone') {
      selectedIndex(4);
      Get.find<ContestController>().loadData();
    } else if (link == 'tenxtrading') {
      selectedIndex(2);
      Get.find<TenxTradingController>().loadData();
    } else if (link == 'referrals') {
      Get.find<ReferralsController>().loadData();
      Get.toNamed(AppRoutes.referrals);
    } else if (link == 'wallet') {
      Get.find<WalletController>().loadData();
      Get.toNamed(AppRoutes.wallet);
    } else if (link == 'market') {
      selectedIndex(1);
      Get.find<VirtualTradingController>().loadData();
    } else if (link == 'toptestzoneportfolios') {
      // selectedIndex(3);
      Get.find<ContestProfileController>().loadData();

      Get.to(() => ContestTopPerformerCard());
    }
  }

  String getPaidCapAmount(num fees, num cap) {
    num percentage = (fees * cap) / 100;
    return FormatHelper.formatNumbers(percentage, showDecimal: false);
  }

  String getStockIndexName(int instId) {
    int index = stockIndexInstrumentList
        .indexWhere((element) => element.instrumentToken == instId);
    return stockIndexInstrumentList[index].displayName ?? '-';
  }

  String getProductName(String? label) {
    String name = '';
    if (label == 'virtual') name = 'F&O';
    if (label == 'tenx') name = 'TenX Trading';
    if (label == 'contest') name = 'TestZones Trading';
    return name;
  }

  Color getValueColor(dynamic value) {
    if (value != null) {
      if (value is String) {
        if (value.contains('-')) {
          return AppColors.danger;
        } else if (value == '0') {
          return AppColors.success;
        }
      } else {
        num number = value is int || value is double ? value : num.parse(value);
        if (number > 0) {
          return AppColors.success;
        } else if (number < 0) {
          return AppColors.danger;
        } else if (number == 0) {
          return AppColors.success;
        }
      }
    }
    return AppColors.grey;
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
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getDashboard(String? tradeType, String? timeFame) async {
    isPerformanceLoading(true);
    try {
      final RepoResponse<DashboardTradeSummaryResponse> response =
          tradeType == 'virtual'
              ? await repository.getDashboardVirtual(tradeType, timeFame)
              : await repository.getDashboard(tradeType, timeFame);

      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          print('userdatafetch');
          userDashboard(response.data?.data);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPerformanceLoading(false);
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
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getStockIndexInstrumentsList() async {
    isLoading(true);
    try {
      final RepoResponse<StockIndexInstrumentListResponse> response =
          await repository.getStockIndexInstrumentsList();
      if (response.data != null) {
        stockIndexInstrumentList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  int calculateSeatsLeft(int maxParticipants, int currentParticipants) {
    int seatsLeft = maxParticipants - currentParticipants;
    return seatsLeft;
  }

  Future liveIndexDetails() async {
    try {
      final RepoResponse<IndexLivePriceListResponse> response =
          await repository.getIndexLivePrices();
      if (response.data != null && response.data!.data != null) {
        stockIndexDetailsList.clear();

        stockIndexDetailsList.assignAll(
          response.data!.data!.map((item) {
            return StockIndexDetails.fromJson(item.toJson());
          }).toList(),
        );
      } else {
        if (stockIndexDetailsList.isEmpty) {
          stockIndexDetailsList.assignAll(stockIndexDetailsList);
        }
      }
      print("liveIndexDetails${stockIndexDetailsList.length}");
    } catch (e) {
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future socketIndexConnection() async {
    List<StockIndexDetails>? stockTemp = [];
    try {
      socketService.socket.on(
        'index-tick',
        (data) {
          stockTemp = StockIndexDetailsListResponse.fromJson(data).data ?? [];
          for (var element in stockTemp ?? []) {
            if (stockIndexDetailsList
                .any((obj) => obj.instrumentToken == element.instrumentToken)) {
              int index = stockIndexDetailsList.indexWhere(
                (stock) => stock.instrumentToken == element.instrumentToken,
              );
              stockIndexDetailsList.removeAt(index);
              stockIndexDetailsList.insert(index, element);
            } else {
              stockIndexDetailsList.add(element);
            }
          }
        },
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
