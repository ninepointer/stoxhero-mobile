import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app.dart';

class StocksTradingBinding implements Bindings {
  @override
  void dependencies() => Get.put(StocksTradingController());
}

class StocksTradingController extends BaseController<StocksTradingRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final readSetting = ReadSettingResponse().obs;

  final isWatchlistStateLoading = false.obs;
  bool get isWatchlistStateLoadingStatus => isWatchlistStateLoading.value;

  final tradingInstruments = <StockWatchlistSearchData>[].obs;

  final searchTextController = TextEditingController();

  final selectedWatchlistStock = StockWatchlistSearchData().obs;

  final isSearchCleared = false.obs;
  final tradingInstrumentTradeDetailsList =
      <TradingInstrumentTradeDetails>[].obs;

  Future loadData() async {
    loadUserDetails();
    socketConnection();

    //  await getStocksTradingInstruments();
  }

  Future loadUserDetails() async {
    userDetails.value = AppStorage.getUserDetails();
  }

  Future getStocksTradingInstruments(String searchStock) async {
    try {
      final RepoResponse<StockWatchlistSearchDataResponse> response =
          await repository.getStockWatchlist(searchStock);
      if (response.data?.data != null) {
        tradingInstruments(response.data?.data ?? []);
       
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  void clearTradingInstruments() {}

  Future socketConnection() async {
    List<TradingInstrumentTradeDetails>? tempList = [];
    try {
      socketService.socket.on(
        'tick-room',
        (data) {
          tempList =
              TradingInstrumentTradeDetailsListResponse.fromJson(data).data ??
                  [];
          tempList?.forEach(
            (element) {
              if (tradingInstrumentTradeDetailsList.any(
                  (obj) => obj.instrumentToken == element.instrumentToken)) {
                int index = tradingInstrumentTradeDetailsList.indexWhere(
                  (stock) => stock.instrumentToken == element.instrumentToken,
                );
                tradingInstrumentTradeDetailsList.removeAt(index);
                tradingInstrumentTradeDetailsList.insert(index, element);
              } else {
                tradingInstrumentTradeDetailsList.add(element);
              }
            },
          );
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

 Future addStocktoWatchlist() async{

  print(selectedWatchlistStock.value.toJson());

 }


}
