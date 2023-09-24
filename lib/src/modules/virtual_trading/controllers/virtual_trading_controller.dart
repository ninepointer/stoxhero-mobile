import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
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

  final tradingInstruments = <TradingInstrument>[].obs;
  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;

  final virtualPositionsList = <VirtualTradingPosition>[].obs;
  final virtualPosition = VirtualTradingPosition().obs;
  final virtualInstrumentTradeDetails = <VirtualTradingInstrumentTradeDetails>[].obs;

  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final selectedWatchlistIndex = RxInt(-1);
  final selectedQuantity = 0.obs;
  final lotsValueList = <int>[0].obs;

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getVirtualTradingPortfolio();
    await getVirtualTradingWatchlist();
    await getVirtualPositionsList();
    await socketConnection();
  }

  num calculateGrossPNL(num ltp, num avg, int lots) {
    num position = ltp - avg;
    num grossPNL = position * lots;
    return grossPNL;
  }

  num calculateNetPNL(num ltp, num avg, int lots, num brokerage) {
    num position = ltp - avg;
    num grossPNL = position * lots;
    num netPNL = grossPNL * brokerage;
    return netPNL;
  }

  List<int> generateLotsList({String? type}) {
    List<int> result = [];
    switch (type) {
      case 'NIFTY50':
        for (int i = 50; i <= 1800; i += 50) result.add(i);
        break;
      case 'BANKNIFTY':
        for (int i = 15; i <= 900; i += 15) result.add(i);
        break;
      case 'FINNIFTY':
        for (int i = 40; i <= 880; i += 40) result.add(i);
        break;
    }
    selectedQuantity.value = result[0];
    lotsValueList.assignAll(result);
    return result;
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

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.virtualSearchSymbol);
  }

  void calculateTotalPositionValues() {
    int totalLots = 0;
    num totalBrokerage = 0;
    num totalGross = 0;
    num totalNet = 0;

    for (var position in virtualPositionsList) {
      log('postion : ${position.toJson()}');
      totalLots += position.lots ?? 0;
      totalBrokerage += position.brokerage ?? 0;
      totalGross += position.amount ?? 0;
      totalNet += position.amount ?? 0;
    }

    tenxTotalPositionDetails(
      TenxTotalPositionDetails(
        lots: totalLots,
        brokerage: totalBrokerage,
        gross: totalGross,
        net: totalNet,
      ),
    );
  }

  num getInstrumentLastPrice(int instID, int exchID) {
    if (virtualInstrumentTradeDetails.isNotEmpty) {
      int index = virtualInstrumentTradeDetails.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return 0;
      num price = virtualInstrumentTradeDetails[index].lastPrice ?? 0;

      return price;
    } else {
      return 0;
    }
  }

  String getInstrumentChanges(int instID, int exchID) {
    if (virtualInstrumentTradeDetails.isNotEmpty) {
      int index = virtualInstrumentTradeDetails.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price = virtualInstrumentTradeDetails[index].change?.toString();
      return FormatHelper.formatNumbers(price);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future addInstrument(TradingInstrument inst) async {
    isLoading(true);
    AddInstrumentRequest data = AddInstrumentRequest(
      instrument: inst.name,
      exchange: inst.exchange,
      status: inst.status,
      symbol: inst.tradingsymbol,
      lotSize: inst.lotSize,
      instrumentToken: inst.instrumentToken,
      uId: Uuid().v4(),
      contractDate: inst.expiry,
      maxLot: 1800,
      from: "paperTrade",
      chartInstrument: inst.chartInstrument,
      exchangeSegment: inst.segment,
      exchangeInstrumentToken: inst.exchangeToken,
    );

    log('addInstrument : ${data.toJson()}');

    try {
      final RepoResponse<GenericResponse> response = await repository.addInstrument(
        data.toJson(),
      );
      if (response.data?.message == "Instrument Added") {
        tradingWatchlist.clear();
        tradingInstruments.clear();
        await getVirtualTradingWatchlist();
        await searchInstruments(searchTextController.text);
        SnackbarHelper.showSnackbar("Instrument Added");
      }
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
      tradingWatchlist.clear();
      tradingInstruments.clear();
      await getVirtualTradingWatchlist();
      await searchInstruments(searchTextController.text);
      log('getVirtualTradingWatchlist : ${tradingWatchlist.length}');
      // } else {
      // SnackbarHelper.showSnackbar(response.error?.message);
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future socketConnection() async {
    List<VirtualTradingInstrumentTradeDetails>? tempList = [];
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
      socket.on('index-tick', (data) {
        // print(data);
        // log('Socket : index-tick $data');
      });
      socket.on(
        'tick-room',
        (data) {
          // log('Socket : tick-room $data');
          tempList = VirtualTradingInstrumentTradeDetailsListResponse.fromJson(data).data ?? [];
          tempList?.forEach((element) {
            if (virtualInstrumentTradeDetails.any((obj) => obj.instrumentToken == element.instrumentToken)) {
              int index = virtualInstrumentTradeDetails.indexWhere(
                (stock) => stock.instrumentToken == element.instrumentToken,
              );
              virtualInstrumentTradeDetails.removeAt(index);
              virtualInstrumentTradeDetails.insert(index, element);
            } else {
              virtualInstrumentTradeDetails.add(element);
            }
          });
        },
      );
      socket.onDisconnect((_) => log('Socket : Disconnect'));
      socket.onConnectError((err) => log(err));
      socket.onError((err) => log(err));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future placeVirtualTradingOrder(TransactionType type, VirtualTradingInstrument inst) async {
    Get.back();
    isLoading(true);
    TenxTradingPlaceOrderRequest data = TenxTradingPlaceOrderRequest(
      exchange: inst.exchange,
      symbol: inst.tradingsymbol,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      quantity: selectedQuantity.value,
      price: "",
      product: "NRML",
      orderType: "MARKET",
      triggerPrice: "",
      stopLoss: "",
      uId: Uuid().v4(),
      exchangeInstrumentToken: inst.exchangeToken,
      validity: "DAY",
      variety: "regular",
      createdBy: userDetailsData.name,
      orderId: Uuid().v4(),
      userId: userDetailsData.email,
      instrumentToken: inst.instrumentToken,
      trader: userDetailsData.sId,
      paperTrade: true,
      tenxTraderPath: false,
    );
    log('placeVirtualTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.paperPlaceOrder(
        data.toJson(),
      );
      log(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successfull');
        await getVirtualPositionsList();
        await getVirtualTradingPortfolio();
      } else if (response.data?.status == "Failed") {
        log(response.error!.message!.toString());
        SnackbarHelper.showSnackbar(response.error?.message);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
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
      final RepoResponse<TradingWatchlistResponse> response = await repository.getVirtualTradingWatchlist();
      if (response.data != null) {
        if (response.data?.data! != null) {
          tradingWatchlist.clear();
          tradingWatchlistIds.clear();
          tradingWatchlist(response.data?.data ?? []);
          for (var element in tradingWatchlist) {
            tradingWatchlistIds.add(element.instrumentToken ?? element.exchangeInstrumentToken ?? 0);
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
          calculateTotalPositionValues();
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

  Future searchInstruments(String? value) async {
    isLoading(true);
    try {
      final RepoResponse<TradingInstrumentListResponse> response = await repository.searchInstruments(value);
      if (response.data != null) {
        if (response.data?.data! != null) {
          tradingInstruments.clear();
          tradingInstruments(response.data?.data ?? []);
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
