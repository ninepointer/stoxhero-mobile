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
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;
  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final equityInstrumentDetailList = <EquityInstrumentDetail>[].obs;

  Future loadData() async {
    loadUserDetails();
    socketConnection();
    socketIndexConnection();
    getEquityInstrumentDetails();
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
        'equity-ticks',
        (data) {
        //  print("equity-ticks${data}");
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
        //  print("hello${tradingInstrumentTradeDetailsList}");
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future addStocktoWatchlist() async {
    print(selectedWatchlistStock.value.toJson());
  }

//  num instrumentlastprice(){
//   num ltp =0;
//   for(ltp in tradingInstrumentTradeDetailsList)
//  }

  Future getReadSetting() async {
    isLoading(true);

    try {
      final RepoResponse<ReadSettingResponse> response =
          await repository.readSetting();
      readSetting(response.data);
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
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

  String getStockIndexName(int instId) {
    int index = stockIndexInstrumentList
        .indexWhere((element) => element.instrumentToken == instId);
    return stockIndexInstrumentList[index].displayName ?? '-';
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
      log(e.toString());
    }
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

  //socket things for LTP in search sheet
  num getInstrumentLastPrice(int instID, int exchID) {
    num priceValue = 0;
    // print("hii start${tradingInstrumentTradeDetailsList}");

    if (tradingInstrumentTradeDetailsList.isNotEmpty) {
      int index = tradingInstrumentTradeDetailsList.indexWhere(
        (stock) =>
            stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      //  print(
      //   "hii${index} ${tradingInstrumentTradeDetailsList[index].lastPrice}");
      if (index == -1) {
        //  print("hii index nhi mila");
        int index = instrumentLivePriceList.indexWhere(
          (stock) =>
              stock.instrumentToken == instID ||
              stock.instrumentToken == exchID,
        );
        if (index == -1) {
          priceValue = 0;
        } else {
          priceValue = instrumentLivePriceList[index].lastPrice ?? 0;
        }
      } else {
        //  print(
        //  "hii final ${tradingInstrumentTradeDetailsList[index].lastPrice}");
        priceValue = tradingInstrumentTradeDetailsList[index].lastPrice ?? 0;
      }
    }
    // print("yoyoyo${tradingInstrumentTradeDetailsList}");
    return priceValue;
  }

  String getInstrumentChanges(int instID, int exchID) {
    if (tradingInstrumentTradeDetailsList.isNotEmpty) {
      int index = tradingInstrumentTradeDetailsList.indexWhere(
        (stock) =>
            stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price =
          tradingInstrumentTradeDetailsList[index].change?.toString();
      return FormatHelper.formatNumbers(price, showSymbol: false);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future addInstrument(StockWatchlistSearchData stock) async {
    isWatchlistStateLoading(true);
    AddStockWathclistRequest data = AddStockWathclistRequest(
      exchangeInstrumentToken: stock.exchangeToken,
      exchange: stock.exchange,
      symbol: stock.name,
      status: stock.status,
      instrumentToken: stock.instrumentToken,
    );

    log('addStock : ${data.symbol}');

    try {
      final RepoResponse<GenericResponse> response = await repository.addStock(
        data.toJson(),
      );
      await getEquityInstrumentDetails();
      if (response.data?.message == "Stock Added") {
        // await getContestWatchList();
        // await searchInstruments(searchTextController.text, showShimmer: false);
        SnackbarHelper.showSnackbar("Stock Added");
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  //get wala chiz
  Future getEquityInstrumentDetails() async {
    equityInstrumentDetailList.clear();
    try {
      final RepoResponse<EquityInstrumentDetailsResponse> response =
          await repository.getEquityInstrumentDetails({});
      if (response.data?.data != null) {
        equityInstrumentDetailList(response.data?.data ?? []);
        print(
            'equityInstrumentDetailList : ${equityInstrumentDetailList.length}');
        update();
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }
}
