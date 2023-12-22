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















  Future getStocksTradingInstruments() async {
   
    try {
      final RepoResponse<StockWatchlistSearchDataResponse> response =
          await repository. getStockWatchlist("hdfc");
      if (response.data?.data != null) {
        tradingInstruments(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch(e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }
}
