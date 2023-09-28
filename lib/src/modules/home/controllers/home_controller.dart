import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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

  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;

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
    await socketIndexConnection();
    await getStockIndexInstrumentsList();
    await getDashboardReturnSummary();
    await getDashboardCarousel();
    await getDashboard(selectedTradeType, selectedTimeFrame);
  }

  String getStockIndexName(int instId) {
    // log('instToken : $instId');
    int index = stockIndexInstrumentList.indexWhere((element) => element.instrumentToken == instId);
    return stockIndexInstrumentList[index].displayName ?? '-';
  }

  String getProductName(String? label) {
    String name = '';
    if (label == 'virtual') name = 'Virtual Trading';
    if (label == 'tenx') name = 'TenX Trading';
    if (label == 'contest') name = 'Contest Trading';
    return name;
  }

  Color getValueColor(dynamic value) {
    if (value != null) {
      num number = value is int || value is double ? value : num.parse(value);
      if (number < 0) {
        return AppColors.success;
      } else if (number > 0) {
        return AppColors.danger;
      } else if (number == 0) {
        return AppColors.black;
      }
    }
    return AppColors.white;
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
      log('car ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future socketIndexConnection() async {
    List<StockIndexDetails>? stockTemp = [];
    try {
      IO.Socket socket;
      socket = IO.io(AppUrls.baseURL, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
      });
      socket.connect();
      socket.onConnect((_) {
        log('Socket : Connected');
        socket.emit('userId', userDetails.value.sId);
        socket.emit('user-ticks', userDetails.value.sId);
      });
      socket.on(
        'index-tick',
        (data) {
          // log('Stock Socket : index-tick $data');
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

          // log('Socket : ${stockIndexDetailsList.length}');
        },
      );
      socket.onDisconnect((_) => log('Socket : Disconnect'));
      socket.onConnectError((err) => log(err));
      socket.onError((err) => log(err));
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
