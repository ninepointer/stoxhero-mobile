import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

import '../../../app/app.dart';

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
  final tradingWatch = TradingWatchlist().obs;
  final tradingWatchlistIds = <int>[].obs;

  final virtualPositionsList = <VirtualTradingPosition>[].obs;
  final virtualPosition = VirtualTradingPosition().obs;
  final virtualInstrumentTradeDetails = <VirtualTradingInstrumentTradeDetails>[].obs;

  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final selectedWatchlistIndex = RxInt(-1);
  final selectedQuantity = 0.obs;
  final lotsValueList = <int>[0].obs;

  final isLivePriceLoaded = false.obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;

  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await socketConnection();
    await socketIndexConnection();
    await getInstrumentLivePriceList();
    await getStockIndexInstrumentsList();
    await getVirtualTradingWatchlist();
    await getVirtualPositionsList();
    await getVirtualTradingPortfolio();
  }

  String getStockIndexName(int instId) {
    // log('instToken : $instId');
    int index = stockIndexInstrumentList.indexWhere((element) => element.instrumentToken == instId);
    return stockIndexInstrumentList[index].displayName ?? '-';
  }

  List<int> generateLotsList({String? type}) {
    List<int> result = [];

    if (type?.contains('BANK') ?? false) {
      for (int i = 15; i <= 900; i += 15) result.add(i);
    } else if (type?.contains('FIN') ?? false) {
      for (int i = 40; i <= 1800; i += 40) result.add(i);
    } else {
      for (int i = 50; i <= 1800; i += 50) result.add(i);
    }

    selectedQuantity.value = result[0];
    lotsValueList.assignAll(result);
    return result;
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

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.virtualSearchSymbol);
  }

  num calculateGrossPNL(num avg, int lots, num ltp) {
    num pnl = 0;
    num value = (avg + (lots) * ltp);
    pnl += value;
    return pnl;
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
      totalGross += position.lastaverageprice ?? 0;
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
    log('ContestTotalPositionDetails : ${tenxTotalPositionDetails.toJson()}');
  }

  num calculateTotalGrossPNL() {
    num totalGross = 0;
    for (var position in virtualPositionsList) {
      num avg = position.amount!;
      int lots = position.lots!.toInt();
      num ltp = getInstrumentLastPrice(
        position.id!.instrumentToken!,
        position.id!.exchangeInstrumentToken!,
      );

      num pnl = 0;
      num value = (avg + (lots) * ltp);
      pnl += value;
      totalGross += pnl;
    }
    return totalGross.round();
  }

  num calculateTotalNetPNL() {
    num totalNetPNL = 0;
    for (var position in virtualPositionsList) {
      num avg = position.amount!;
      int lots = position.lots!.toInt();
      num ltp = getInstrumentLastPrice(
        position.id!.instrumentToken!,
        position.id!.exchangeInstrumentToken!,
      );
      num value = (avg + (lots) * ltp);
      num brokerage = position.brokerage!;
      num broker = value - brokerage;
      totalNetPNL += broker;
    }
    return totalNetPNL.round();
  }

  num calculateMargin() {
    num pnl = 0;
    num amount = 0;
    num lots = 0;
    for (var position in virtualPositionsList) {
      amount += position.amount ?? 0;
      lots += position.lots ?? 0;
    }
    num openingBalance = virtualPortfolio.value.openingBalance ?? 0;
    pnl += openingBalance + amount;
    if (lots == 0) {
      num margin = openingBalance + calculateTotalNetPNL();
      return margin;
    } else {
      return pnl;
    }
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
      return FormatHelper.formatNumbers(price, showSymbol: false);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future getInstrumentLivePriceList() async {
    isLoading(true);
    try {
      final RepoResponse<InstrumentLivePriceListResponse> response = await repository.getInstrumentLivePrices();
      if (response.data != null) {
        if (response.data?.data! != null) {
          isLivePriceLoaded(true);
          instrumentLivePriceList(response.data?.data ?? []);
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
      SnackbarHelper.showSnackbar('Instrument Remove');
      // } else {
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

  Future placeVirtualTradingOrder(TransactionType type, TradingInstrument inst) async {
    Get.back();
    isLoading(true);
    VirtualTradingPlaceOrderRequest data = VirtualTradingPlaceOrderRequest(
      orderType: "MARKET",
      price: "",
      product: "NRML",
      quantity: selectedQuantity.value,
      triggerPrice: "",
      buyOrSell: type == TransactionType.exit
          ? type == TransactionType.buy
              ? "BUY"
              : "SELL"
          : type == TransactionType.buy
              ? "SELL"
              : "BUY",
      exchange: inst.exchange,
      exchangeInstrumentToken: inst.exchangeToken,
      orderId: Uuid().v4(),
      paperTrade: true,
      stopLoss: "",
      symbol: inst.tradingsymbol,
      trader: userDetailsData.sId,
      userId: userDetailsData.email,
      validity: "DAY",
      variety: "regular",
      uId: Uuid().v4(),
      createdBy: userDetailsData.name,
      instrumentToken: inst.instrumentToken,
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

  Future getStockIndexInstrumentsList() async {
    isLoading(true);
    try {
      final RepoResponse<StockIndexInstrumentListResponse> response = await repository.getStockIndexInstrumentsList();
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
            if (stockIndexDetailsList.any((obj) => obj.instrumentToken == element.instrumentToken)) {
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
