import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';
import '../../../app/app.dart';

class TenxTradingBinding implements Bindings {
  @override
  void dependencies() => Get.put(TenxTradingController());
}

class TenxTradingController extends BaseController<TenxTradingRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final searchTextController = TextEditingController();
  final selectedSubscriptionId = ''.obs;
  final selectedSubscription = TenxActiveSubscription().obs;
  final walletBalance = RxNum(0);
  final selectedWatchlistIndex = RxInt(-1);
  final isLivePriceLoaded = false.obs;

  final tradingInstruments = <TradingInstrument>[].obs;
  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;

  final tenxActiveSub = <TenxActiveSubscription>[].obs;
  final tenxInstrumentTradeDetailsList = <TenxTradingInstrumentTradeDetails>[].obs;
  final tenxPositionsList = <TenxTradingPosition>[].obs;
  final tenxPosition = TenxTradingPosition().obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;

  final tenxPortfolioDetails = TenxTradingPortfolioDetails().obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final userSubscriptionsIds = <String>[].obs;
  final selectedQuantity = 0.obs;
  final lotsValueList = <int>[0].obs;

  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;

  void loadUserDetails() {
    userDetails.value = AppStorage.getUserDetails();
  }

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getTenxTradingActiveSubs();
    await getTenxTradingWatchlist();
    await getTenxPositionsList();
    await getTenxTradingPortfolioDetails();
    await getInstrumentLivePriceList();
    await socketConnection();
    await socketIndexConnection();
    await getStockIndexInstrumentsList();
  }

  num calculateGrossPNL(num ltp, num avg, int lots) {
    num position = ltp - avg;
    num grossPNL = position * lots;
    return grossPNL;
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
      for (int i = 40; i <= 880; i += 40) result.add(i);
    } else {
      for (int i = 50; i <= 1800; i += 50) result.add(i);
    }

    selectedQuantity.value = result[0];
    lotsValueList.assignAll(result);
    return result;
  }

  void calculateTotalPositionValues() {
    int totalLots = 0;
    num totalBrokerage = 0;
    num totalGross = 0;
    num totalNet = 0;

    for (var position in tenxPositionsList) {
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
    log('TenxTotalPositionDetails : ${tenxTotalPositionDetails.toJson()}');
  }

  num calculateTotalGrossPNL() {
    num totalGrossPNL = 0;

    for (var position in tenxPositionsList) {
      num ltp = getInstrumentLastPrice(
        position.id?.instrumentToken ?? 0,
        position.id?.exchangeInstrumentToken ?? 0,
      );
      num avg = position.lastaverageprice ?? 0;

      num diff = ltp - avg;
      int lots = position.lots ?? 0;
      num gross = 0;
      if (lots == 0) {
        gross += position.amount ?? 0;
      } else {
        gross = diff * lots;
      }
      totalGrossPNL += gross;
    }

    // tenxTotalPositionDetails(
    //   TenxTotalPositionDetails(

    //     gross: totalGross,
    //     net: totalNet,
    //   ),
    // );
    log('TotalGross : ${totalGrossPNL.toString()}');

    return totalGrossPNL;
  }

  num calculateTotalNetPNL() {
    num totalNetPNL = 0;
    num totalBrokerage = 0;

    for (var position in tenxPositionsList) {
      num ltp = getInstrumentLastPrice(
        position.id!.instrumentToken!,
        position.id!.exchangeInstrumentToken!,
      );
      num avg = position.lastaverageprice ?? 0;
      num lots = position.lots ?? 0;

      num diff = ltp - avg;
      num gross = diff * lots;

      totalBrokerage = position.brokerage ?? 0;
      num netPNL = gross - totalBrokerage;
      totalNetPNL = netPNL;
    }

    log('totalNetPNL : ${totalNetPNL.toString()}');
    return totalNetPNL;
  }

  void calculateUserWalletAmount() async {
    num amount = 0;
    var response = await Get.find<WalletRepository>().getWalletTransactionsList();
    var list = response.data?.data?.transactions ?? [];
    for (var e in list) amount += e.amount ?? 0;
    walletBalance(amount);
  }

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.tenxSearchSymbol);
  }

  // void calculateTotalPositionValues() {
  //   num totalLots = 0;
  //   num totalBrokerage = 0;

  //   for (var data in tenxPositionsList) {
  //     log('data : ${data.toJson()}');
  //     totalLots += data.lots ?? 0;
  //     totalBrokerage += data.brokerage ?? 0;
  //   }
  //   tenxTotalPositionDetails(TenxTotalPositionDetails(
  //     lots: totalLots,
  //     brokerage: totalBrokerage,
  //   ));
  //   log('tenxTotalPositionDetails : ${tenxTotalPositionDetails.toJson()}');
  // }

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

  // String getInstrumentLastPrice(int instID, int exchID) {
  //   if (tenxInstrumentTradeDetailsList.isNotEmpty) {
  //     int index = tenxInstrumentTradeDetailsList.indexWhere(
  //       (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
  //     );
  //     if (index == -1) return FormatHelper.formatNumbers('00');
  //     String? price = tenxInstrumentTradeDetailsList[index].lastPrice?.toString();
  //     return FormatHelper.formatNumbers(price);
  //   } else {
  //     return FormatHelper.formatNumbers('00');
  //   }
  // }

  num getInstrumentLastPrice(int instID, int exchID) {
    if (tenxInstrumentTradeDetailsList.isNotEmpty) {
      int index = tenxInstrumentTradeDetailsList.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return 0;
      num price = tenxInstrumentTradeDetailsList[index].lastPrice ?? 0;

      return price;
    } else {
      return 0;
    }
  }

  String getInstrumentChanges(int instID, int exchID) {
    if (tenxInstrumentTradeDetailsList.isNotEmpty) {
      int index = tenxInstrumentTradeDetailsList.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price = tenxInstrumentTradeDetailsList[index].change?.toString();
      return FormatHelper.formatNumbers(price);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future socketConnection() async {
    List<TenxTradingInstrumentTradeDetails>? tempList = [];
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
      socket.on('tick-room', (data) {
        // log('Socket : tick-room $data');
        tempList = TenxTradingInstrumentTradeDetailsListResponse.fromJson(data).data ?? [];
        tempList?.forEach((element) {
          if (tenxInstrumentTradeDetailsList
              .any((obj) => obj.instrumentToken == element.instrumentToken)) {
            int index = tenxInstrumentTradeDetailsList.indexWhere(
              (stock) => stock.instrumentToken == element.instrumentToken,
            );
            tenxInstrumentTradeDetailsList.removeAt(index);
            tenxInstrumentTradeDetailsList.insert(index, element);
          } else {
            tenxInstrumentTradeDetailsList.add(element);
          }
        });
      });
      socket.onDisconnect((_) => log('Socket : Disconnect'));
      socket.onConnectError((err) => log(err));
      socket.onError((err) => log(err));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future purchaseIntent() async {
    var data = {
      "purchase_intent_by": userDetails.value.sId,
      "tenXSubscription": selectedSubscriptionId.value,
    };

    try {
      await repository.postPurchaseIntent(data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future getTenxTradingActiveSubs() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingActiveResponse> response =
          await repository.getTenxActiveSubscriptions();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxActiveSub.clear();
          userSubscriptionsIds.clear();
          tenxActiveSub(response.data?.data ?? []);
          for (var userSub in userDetails.value.subscription!) {
            if (userSub.subscriptionId != null) {
              userSubscriptionsIds.add(userSub.subscriptionId!.id!);
            }
          }
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

  Future getTenxTradingWatchlist() async {
    isLoading(true);
    try {
      final RepoResponse<TradingWatchlistResponse> response = await repository.getTenxWatchlist();
      if (response.data != null) {
        if (response.data?.data! != null) {
          tradingWatchlist.clear();
          tradingWatchlistIds.clear();
          tradingWatchlist(response.data?.data ?? []);
          for (var element in tradingWatchlist) {
            tradingWatchlistIds
                .add(element.instrumentToken ?? element.exchangeInstrumentToken ?? 0);
          }
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
      final RepoResponse<TradingInstrumentListResponse> response =
          await repository.searchInstruments(value);
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

  Future getTenxPositionsList() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingPositionListResponse> response =
          await repository.getTenxPositions(
        selectedSubscriptionId.value,
      );
      if (response.data != null) {
        if (response.data?.data! != null) {
          tenxPositionsList(response.data?.data ?? []);
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

  Future getInstrumentLivePriceList() async {
    isLoading(true);
    try {
      final RepoResponse<InstrumentLivePriceListResponse> response =
          await repository.getInstrumentLivePrices();
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

  Future getTenxTradingPortfolioDetails() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingPortfolioDetailsResponse> response =
          await repository.getTenxPortfolioDetails(
        selectedSubscriptionId.value,
      );
      if (response.data?.data != null) {
        log('getTenxTradingPortfolioDetails');
        tenxPortfolioDetails(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getUserWalletTransactionsList() async {
    isLoading(true);
    try {
      final RepoResponse<InstrumentLivePriceListResponse> response =
          await repository.getInstrumentLivePrices();
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

  Future placeTenxTradingOrder(TransactionType type, TradingInstrument inst) async {
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
      createdBy: userDetails.value.name,
      orderId: Uuid().v4(),
      subscriptionId: selectedSubscriptionId.value,
      userId: userDetails.value.email,
      instrumentToken: inst.instrumentToken,
      trader: userDetails.value.sId,
      paperTrade: false,
      tenxTraderPath: true,
    );
    log('placeTenxTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.placeOrder(
        data.toJson(),
      );
      log(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successfull');
        await getTenxPositionsList();
        await getTenxTradingPortfolioDetails();
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

  Future addInstrument(TradingInstrument inst) async {
    isLoading(true);
    AddInstrumentRequest data = AddInstrumentRequest(
      chartInstrument: inst.chartInstrument,
      instrument: inst.name,
      exchange: inst.exchange,
      status: inst.status,
      symbol: inst.tradingsymbol,
      lotSize: inst.lotSize,
      instrumentToken: inst.instrumentToken,
      uId: Uuid().v4(),
      contractDate: inst.expiry,
      maxLot: 900,
      from: "TenX Trader",
      exchangeSegment: inst.segment,
      exchangeInstrumentToken: inst.exchangeToken,
    );

    log('addInstrument : ${data.toJson()}');
    try {
      await repository.addInstrument(data.toJson());
      // if (response.data?.message == "Instrument Added") {
      tradingWatchlist.clear();
      tradingInstruments.clear();
      await getTenxTradingWatchlist();
      await searchInstruments(searchTextController.text);
      SnackbarHelper.showSnackbar('Instrument Added');
      // } else {
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
      tradingWatchlist.clear();
      tradingInstruments.clear();
      await getTenxTradingWatchlist();
      await searchInstruments(searchTextController.text);
      log('getTenxTradingWatchlist : ${tradingWatchlist.length}');
      SnackbarHelper.showSnackbar('Instrument Remove');

      // } else {
      //   SnackbarHelper.showSnackbar(response.error?.message);
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future purchaseSubscription() async {
    isLoading(true);
    var data = {
      "subscriptionAmount": selectedSubscription.value.discountedPrice,
      "subscriptionName": selectedSubscription.value.planName,
      "subscribedId": selectedSubscription.value.sId,
    };
    log(data.toString());
    try {
      final RepoResponse<GenericResponse> response = await repository.purchaseSubscription(
        data,
      );
      if (response.data?.status == "success") {
        Get.back();
        await Get.find<AuthController>().getUserDetails(navigate: false);
        loadUserDetails();
        await getTenxTradingActiveSubs();
        SnackbarHelper.showSnackbar('Transaction Successfull');
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
