import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stoxhero/src/data/models/response/tenx_my_active_subscribed_list_response.dart';
import 'package:stoxhero/src/data/models/response/tenx_my_expired_subscription_list_response.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app.dart';
import '../../../data/models/response/trading_instrument_trade_details_list_response.dart';

class TenxTradingBinding implements Bindings {
  @override
  void dependencies() => Get.put(TenxTradingController());
}

class TenxTradingController extends BaseController<TenxTradingRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final isActiveLoading = false.obs;
  bool get isActiveLoadingStatus => isActiveLoading.value;

  final isSubscribeLoading = false.obs;
  bool get isSubscribeLoadingStatus => isSubscribeLoading.value;

  final isExpiredLoading = false.obs;
  bool get isExpiredLoadingStatus => isExpiredLoading.value;

  final isLeaderboardLoading = false.obs;
  bool get isLeaderboardLoadingStatus => isLeaderboardLoading.value;

  final selectedTabBarIndex = 0.obs;

  final searchTextController = TextEditingController();
  final selectedSubscriptionId = ''.obs;
  final selectSubscriptionName = ''.obs;
  final selectSubscriptionAmount = 0.obs;
  final selectedSubscription = TenxActiveSubscription().obs;
  final walletBalance = RxNum(0);
  final selectedWatchlistIndex = RxInt(-1);

  final tradingInstrumentTradeDetailsList = <TradingInstrumentTradeDetails>[].obs;
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
  final selectedStringQuantity = "0".obs;
  final lotsValueList = <int>[0].obs;

  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;
  final tenxCountTradingDays = <CountTradingDays>[].obs;
  final selectedTenXSub = TenXSubscription().obs;
  final tenXSubscription = <TenXSubscription>[].obs;
  final tenxMyActiveSubcribedList = <TenxMyActiveSubscribedList>[].obs;
  final tenxMyActiveSubcribed = TenxMyActiveSubscribedList().obs;

  final tenxMyExpiredSubcriptionList = <TenxMyExpiredSubscriptionList>[].obs;
  final tenxMyExpiredSubcription = TenxMyExpiredSubscriptionList().obs;

  final tenxLeaderboard = <TenxLeaderboardList>[].obs;

  void loadUserDetails() {
    userDetails.value = AppStorage.getUserDetails();
  }

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getTenxTradingActiveSubs();
    await getTenxMyActiveSubscribed();
    await getTenxMyExpiredSubscription();
    await getTenxLeaderboard();
  }

  Future loadTenxData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getTenxCountTradingDays();
    await getInstrumentLivePriceList();
    await getStockIndexInstrumentsList();
    await getTenxTradingWatchlist();
    await getTenxPositionsList();
    await getTenxTradingPortfolioDetails();
    socketConnection();
    socketIndexConnection();
    await getTenXSubscriptionList();
  }

  void changeTabBarIndex(int val) => selectedTabBarIndex.value = val;

  DateTime date() {
    DateTime subscribedOn = DateTime.parse(tenxMyActiveSubcribed.value.subscribedOn ?? '');
    DateTime newExpiryDate = subscribedOn.add(Duration(days: tenxMyActiveSubcribed.value.expiryDays ?? 0));
    return newExpiryDate;
  }

  int getOpenPositionCount() {
    int openCount = 0;
    for (var position in tenxPositionsList) {
      if (position.lots != 0) {
        openCount++;
      }
    }
    return openCount;
  }

  int getClosePositionCount() {
    int closeCount = 0;
    for (var position in tenxPositionsList) {
      if (position.lots == 0) {
        closeCount++;
      }
    }
    return closeCount;
  }

  double calculateSavingsPercentage(actualPrice, discountPrice) {
    int savings = actualPrice - discountPrice;
    double savingsPercentage = (savings / actualPrice) * 100;
    return savingsPercentage;
  }

  String getStockIndexName(int instId) {
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

  void calculateTotalPositionValues() {
    int totalLots = 0;
    num totalBrokerage = 0;
    num totalGross = 0;
    num totalNet = 0;

    for (var position in tenxPositionsList) {
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
  }

  num calculateGrossPNL(num amount, int lots, num ltp) {
    if (ltp == 0) return 0;
    num pnl = 0;
    num value = (amount + (lots * ltp));
    pnl += value;
    return pnl;
  }

  num calculateTotalGrossPNL() {
    num totalGross = 0;
    for (var position in tenxPositionsList) {
      num avg = position.amount ?? 0;
      int lots = position.lots?.toInt() ?? 0;
      num ltp = getInstrumentLastPrice(
        position.id?.instrumentToken ?? 0,
        position.id?.exchangeInstrumentToken ?? 0,
      );
      if (ltp == 0) return 0;
      num value = (avg + (lots) * ltp);
      totalGross += value;
    }
    return totalGross.round();
  }

  num calculateTotalNetPNL() {
    num totalNetPNL = 0;
    for (var position in tenxPositionsList) {
      num avg = position.amount ?? 0;
      int lots = position.lots?.toInt() ?? 0;
      num ltp = getInstrumentLastPrice(
        position.id?.instrumentToken ?? 0,
        position.id?.exchangeInstrumentToken ?? 0,
      );
      if (ltp == 0) return 0;
      num value = (avg + (lots) * ltp);
      num brokerage = position.brokerage ?? 0;
      num broker = value - brokerage;
      totalNetPNL += broker;
    }
    return totalNetPNL.round();
  }

  num calculateMargin() {
    num amount = 0;
    num lots = 0;
    for (var position in tenxPositionsList) {
      if (position.lots != 0) {
        amount += position.amount!.abs();
        lots += position.lots ?? 0;
      }
    }
    num openingBalance = 0;
    num totalFund = tenxPortfolioDetails.value.totalFund ?? 0;

    if (tenxPortfolioDetails.value.openingBalance != null) {
      openingBalance = tenxPortfolioDetails.value.openingBalance ?? 0;
      // print('openingBalance1 $openingBalance');
    } else {
      openingBalance = totalFund;
      // print('openingBalance2 $openingBalance');
    }

    num availableMargin = openingBalance != 0
        ? lots == 0
            ? openingBalance + calculateTotalNetPNL()
            : openingBalance - amount
        : totalFund;

    // print('Amount $amount');
    // print('lots $lots');
    // print('calculateTotalNetPNL${calculateTotalNetPNL()}');
    // print('openingBalance $openingBalance');
    // print('totalFund $totalFund');
    // print('availableMargin $availableMargin');
    // String availableMarginPnlString = availableMargin >= 0 ? "₹" + availableMargin.toStringAsFixed(2) ?? "₹0" : "₹0";

    // if (lots == 0) {
    //   marginValue = totalFund + calculateTotalNetPNL();
    // } else if (lots < 0) {
    //   marginValue = totalFund - amount;
    // } else {
    //   marginValue = totalFund + amount;
    // }
    return availableMargin;
  }

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.tenxSearchSymbol);
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

  num getInstrumentLastPrice(int instID, int exchID) {
    num priceValue = 0;
    if (tradingInstrumentTradeDetailsList.isNotEmpty) {
      int index = tradingInstrumentTradeDetailsList.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) {
        int index = instrumentLivePriceList.indexWhere(
          (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
        );

        if (index == -1) {
          priceValue = 0;
        } else {
          priceValue = instrumentLivePriceList[index].lastPrice ?? 0;
        }
      } else {
        priceValue = tradingInstrumentTradeDetailsList[index].lastPrice ?? 0;
      }
    }
    return priceValue;
  }

  String getInstrumentChanges(int instID, int exchID) {
    if (tradingInstrumentTradeDetailsList.isNotEmpty) {
      int index = tradingInstrumentTradeDetailsList.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price = tradingInstrumentTradeDetailsList[index].change?.toString();
      return FormatHelper.formatNumbers(price, showSymbol: false);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future socketConnection() async {
    List<TradingInstrumentTradeDetails>? tempList = [];
    try {
      socketService.socket.on('tick-room', (data) {
        tempList = TradingInstrumentTradeDetailsListResponse.fromJson(data).data ?? [];
        tempList?.forEach((element) {
          if (tradingInstrumentTradeDetailsList.any((obj) => obj.instrumentToken == element.instrumentToken)) {
            int index = tradingInstrumentTradeDetailsList.indexWhere(
              (stock) => stock.instrumentToken == element.instrumentToken,
            );
            tradingInstrumentTradeDetailsList.removeAt(index);
            tradingInstrumentTradeDetailsList.insert(index, element);
          } else {
            tradingInstrumentTradeDetailsList.add(element);
          }
        });
      });
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
    isActiveLoading(true);
    try {
      final RepoResponse<TenxTradingActiveResponse> response = await repository.getTenxActiveSubscriptions();
      if (response.data?.status?.toLowerCase() == "success") {
        tenxActiveSub.clear();
        userSubscriptionsIds.clear();
        tenxActiveSub(response.data?.data ?? []);
        for (var userSub in userDetails.value.subscription!) {
          if (userSub.subscriptionId != null) {
            userSubscriptionsIds.add(userSub.subscriptionId!.id!);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isActiveLoading(false);
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
            tradingWatchlistIds.add(element.instrumentToken ?? element.exchangeInstrumentToken ?? 0);
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

  Future getTenxPositionsList() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingPositionListResponse> response = await repository.getTenxPositions(
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
      final RepoResponse<InstrumentLivePriceListResponse> response = await repository.getInstrumentLivePrices();
      if (response.data != null) {
        if (response.data?.data! != null) {
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
      final RepoResponse<TenxTradingPortfolioDetailsResponse> response = await repository.getTenxPortfolioDetails(
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

  Future placeTenxTradingOrder(TransactionType type, TradingInstrument inst) async {
    Get.back();
    isLoading(true);
    if (type == TransactionType.exit) {
      if (selectedStringQuantity.value.contains('-')) {
        type = TransactionType.buy;
      } else {
        type = TransactionType.sell;
      }
    } else {
      if (selectedStringQuantity.value.contains('-')) {
        if (type == TransactionType.buy) {
          type = TransactionType.sell;
        } else {
          type = TransactionType.buy;
        }
      }
    }
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
      battleId: selectedSubscriptionId.value,
      marginxId: selectedSubscriptionId.value,
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    print('placeTenxTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.placeTenxTradingOrder(
        data.toJson(),
      );
      print(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successfull');
        await getTenxPositionsList();
        await getTenxTradingPortfolioDetails();
      } else if (response.data?.status == "Failed") {
        print(response.error!.message!.toString());
        SnackbarHelper.showSnackbar(response.error?.message);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
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
    Get.back();
    isLoading(true);
    var data = {
      "bonusRedemption": 0,
      "coupon": "",
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
        SnackbarHelper.showSnackbar(response.data?.message ?? 'Subscription purchased successfully');
      }
      await Get.find<AuthController>().getUserDetails(navigate: false);
      loadUserDetails();
      await getTenxTradingActiveSubs();
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
      socketService.socket.on(
        'index-tick',
        (data) {
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
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getTenxCountTradingDays() async {
    isLoading(true);
    try {
      final RepoResponse<CountTradingDaysResponse> response = await repository.getTenxCountTradingDays(
        selectedSubscriptionId.value,
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxCountTradingDays(response.data?.data ?? []);
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

  Future getTenXSubscriptionList() async {
    isLoading(true);
    try {
      final RepoResponse<TenXSubscriptionResponse> response = await repository.getTenXSubscriptionList();
      if (response.data != null) {
        tenXSubscription.clear();
        tenXSubscription(response.data?.data ?? []);
        if (tenXSubscription.isNotEmpty) selectedTenXSub(tenXSubscription.first);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getTenxMyActiveSubscribed() async {
    isSubscribeLoading(true);
    try {
      final RepoResponse<TenxMyActiveSubscribedListResponse> response = await repository.getTenxMyActiveSubscribed();
      if (response.data?.status?.toLowerCase() == "success") {
        tenxMyActiveSubcribedList.clear();
        userSubscriptionsIds.clear();
        tenxMyActiveSubcribedList(response.data?.data ?? []);
        for (var userSub in userDetails.value.subscription!) {
          if (userSub.subscriptionId != null) {
            userSubscriptionsIds.add(userSub.subscriptionId!.id!);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isSubscribeLoading(false);
  }

  Future getTenxMyExpiredSubscription() async {
    isExpiredLoading(true);
    try {
      final RepoResponse<TenxMyExpiredSubscriptionListResponse> response =
          await repository.getTenxMyExpiredSubscription();
      if (response.data?.status?.toLowerCase() == "success") {
        tenxMyExpiredSubcriptionList.clear();
        userSubscriptionsIds.clear();
        tenxMyExpiredSubcriptionList(response.data?.data ?? []);
        for (var userSub in userDetails.value.subscription!) {
          if (userSub.subscriptionId != null) {
            userSubscriptionsIds.add(userSub.subscriptionId!.id!);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isExpiredLoading(false);
  }

  Future getTenxLeaderboard() async {
    isLeaderboardLoading(true);
    try {
      final RepoResponse<TenxLeaderboardListResponse> response = await repository.getTenxLeaderboard();
      if (response.data?.status?.toLowerCase() == "success") {
        tenxLeaderboard(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLeaderboardLoading(false);
  }

  Future tenxRenewSubscription() async {
    Get.back();
    isLoading(true);
    var data = {
      "bonusRedemption": 0,
      "coupon": "",
      "subscriptionAmount": tenxMyActiveSubcribed.value.discountedPrice,
      "subscriptionName": tenxMyActiveSubcribed.value.planName,
      "subscriptionId": tenxMyActiveSubcribed.value.sId,
    };
    log(data.toString());
    try {
      final RepoResponse<GenericResponse> response = await repository.tenxRenewSubscription(
        data,
      );
      if (response.data?.status == "success") {
        SnackbarHelper.showSnackbar(response.data?.message ?? 'Subscription renewed successfully');
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future tenxTutorial() async {
    var data = {
      "tenXSubscription": selectedSubscriptionId.value,
      "tutorialViewedBy": userDetails.value.sId,
    };
    try {
      await repository.tenxTutorial(data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future tenxCapturePurchaseIntent() async {
    var data = {
      "tenXSubscription": selectedSubscriptionId.value,
      "tutorialViewedBy": userDetails.value.sId,
    };
    try {
      await repository.tenxTutorial(data);
    } catch (e) {
      log(e.toString());
    }
  }
}
