import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class VirtualTradingBinding implements Bindings {
  @override
  void dependencies() => Get.put(VirtualTradingController());
}

class VirtualTradingController extends BaseController<VirtualTradingRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final searchTextController = TextEditingController();
  final virtualPortfolio = VirtualTradingPortfolio().obs;
  final virtualWatchList = <VirtualTradingWatchList>[].obs;
  final virtualInstruments = <VirtualTradingInstrument>[].obs;
  final virtualPositionsList = <VirtualTradingPosition>[].obs;

  final selectedQuantity = 50.obs;
  final virtualWatchlistIds = <int>[].obs;
  final selectedWatchlistIndex = RxInt(-1);
  final stockIndex = StockIndexResponse().obs;

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    Get.toNamed(AppRoutes.virtualSearchSymbol);
  }

  // void calculateTotalPositionValues() {
  //   num totalLots = 0;
  //   num totalBrokerage = 0;

  //   for (var position in virtualPositionsList) {
  //     log('postion : ${position.toJson()}');
  //     totalLots += position.lots ?? 0;
  //     totalBrokerage += position.brokerage ?? 0;
  //   }

  //   virtualPositionsList.forEach((element) {
  //     element.lots = totalLots;
  //     element.brokerage = totalBrokerage;
  //   });

  //   log('virtualPositionsList : ${virtualPositionsList.toJson()}');
  // }

  Future loadData() async {
    await getVirtualTradingPortfolio();
    await getVirtualTradingWatchlist();
    await getVirtualPositionsList();
    // getStockIndex();
  }

  Color getValueColor(dynamic value) {
    if (value != null) {
      num number = value is int || value is double ? value : num.parse(value);
      if (number > 0) {
        return AppColors.success;
      } else if (number < 0) {
        return AppColors.danger;
      } else if (number == 0) {
        return AppColors.white;
      }
    }
    return AppColors.white;
  }

  String getInstrumentLastPrice(int instID, int exchID) {
    if (virtualInstruments.isNotEmpty) {
      int index = virtualInstruments.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price = virtualInstruments[index].lastPrice?.toString();
      return FormatHelper.formatNumbers(price);
    } else {
      return FormatHelper.formatNumbers('00');
    }
  }

  String getInstrumentChanges(int instID, int exchID) {
    if (virtualInstruments.isNotEmpty) {
      int index = virtualInstruments.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price = virtualInstruments[index].exchange?.toString();
      return FormatHelper.formatNumbers(price);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future getVirtualTradingPortfolio() async {
    isLoading(true);
    try {
      final RepoResponse<VirtualTradingPortfolioResponse> response = await repository.getVirtualTradingPortfolio();
      if (response.data != null) {
        virtualPortfolio(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log("port ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getVirtualTradingWatchlist() async {
    isLoading(true);
    try {
      final RepoResponse<VirtualTradingWatchListResponse> response = await repository.getVirtualTradingWatchlist();
      if (response.data != null) {
        if (response.data?.data! != null) {
          virtualWatchList.clear();
          virtualWatchlistIds.clear();
          virtualWatchList(response.data?.data ?? []);
          for (var element in virtualWatchList) {
            virtualWatchlistIds.add(element.instrumentToken ?? element.exchangeInstrumentToken ?? 0);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log("watch ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getVirtualPositionsList() async {
    isLoading(true);
    try {
      final RepoResponse<VirtualTradingPositionListResponse> response = await repository.getVirtualPositions();
      if (response.data != null) {
        if (response.data?.data! != null) {
          virtualPositionsList(response.data?.data ?? []);
          // calculateTotalPositionValues();
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

  // Future getStockIndex() async {
  //   isLoading(true);
  //   try {
  //     final RepoResponse<StockIndexResponse> response = await repository.getStockIndex();
  //     if (response.data != null) {
  //       stockIndex();
  //     } else {
  //       SnackbarHelper.showSnackbar(response.error?.message);
  //     }
  //   } catch (e) {
  //     log("stock ${e.toString()}");
  //     SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
  //   }
  //   isLoading(false);
  // }

  Future searchInstruments(String? value) async {
    isLoading(true);
    try {
      final RepoResponse<VirtualTradingInstrumentListResponse> response = await repository.searchInstruments(value);
      if (response.data != null) {
        if (response.data?.data! != null) {
          virtualInstruments.clear();
          virtualInstruments(response.data?.data ?? []);
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

  Future addInstrument(VirtualTradingInstrument inst) async {
    isLoading(true);
    AddInstrumentRequest data = AddInstrumentRequest(
      instrument: inst.name,
      exchange: inst.exchange,
      status: inst.status,
      symbol: inst.tradingsymbol,
      lotSize: 25,
      instrumentToken: inst.instrumentToken,
      uId: Uuid().v4(),
      contractDate: inst.expiry,
      maxLot: 900,
      // from: "TenX Trader",
      exchangeSegment: inst.segment,
      exchangeInstrumentToken: inst.exchangeToken,
    );

    log('addInstrument : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.addInstrument(
        data.toJson(),
      );
      // if (response.data?.message == "Instrument Added") {
      virtualWatchList.clear();
      virtualInstruments.clear();
      await getVirtualTradingWatchlist();
      await searchInstruments(searchTextController.text);
      // } else {
      SnackbarHelper.showSnackbar(response.error?.message);
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future removeInstrument(int? instToken) async {
    isLoading(true);
    try {
      await repository.removeInstrument(instToken ?? 0);
      // if (response.data != null) {
      selectedWatchlistIndex(-1);
      virtualWatchList.clear();
      virtualInstruments.clear();
      await getVirtualTradingWatchlist();
      await searchInstruments(searchTextController.text);
      log('getVirtualTradingWatchlist : ${virtualWatchList.length}');
      // } else {
      // SnackbarHelper.showSnackbar(response.error?.message);
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }
}
