import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';
import '../../../app/app.dart';
import '../../../data/models/response/trading_instrument_trade_details_list_response.dart';

class MarginXBinding implements Bindings {
  @override
  void dependencies() => Get.put(MarginXController());
}

class MarginXController extends BaseController<MarginXRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final isLiveLoading = false.obs;
  bool get isLiveLoadingStatus => isLiveLoading.value;

  final isUpcomingLoading = false.obs;
  bool get isUpcomingLoadingStatus => isUpcomingLoading.value;

  final isCompletedLoading = false.obs;
  bool get isCompletedLoadingStatus => isCompletedLoading.value;

  final isOrdersLoading = false.obs;
  bool get isOrdersLoadingStatus => isOrdersLoading.value;

  final selectedTabBarIndex = 0.obs;

  final searchTextController = TextEditingController();
  final upComingMarginXList = <UpcomingMarginX>[].obs;
  final upComingMarginX = UpcomingMarginX().obs;
  final liveMarginXList = <LiveMarginX>[].obs;
  final completedMarginXList = <CompletedMarginX>[].obs;
  final completedMarginXOrdersList = <CompletedMarginXOrders>[].obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final tradingInstrumentTradeDetailsList = <TradingInstrumentTradeDetails>[].obs;
  final marginXPositionList = <MarginXPositionList>[].obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final marginXPortfolio = MarginXPortfolio().obs;
  final liveMarginX = LiveMarginX().obs;
  final completedMarginX = CompletedMarginX().obs;
  final contestWatchlistIds = <int>[].obs;
  final walletBalance = RxNum(0);
  final selectedWatchlistIndex = RxInt(-1);
  final selectedQuantity = 0.obs;
  final selectedStringQuantity = "0".obs;
  final lotsValueList = <int>[0].obs;

  final tradingInstruments = <TradingInstrument>[].obs;
  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;

  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;

  Future loadData() async {
    loadUserDetails();
    await getLiveMarginXList();
    await getUpComingMarginXList();
    await getCompletedMarginXList();
  }

  Future loadUserDetails() async {
    userDetails.value = AppStorage.getUserDetails();
  }

  Future loadTradingData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getInstrumentLivePriceList();
    await getStockIndexInstrumentsList();
    await getMarginXPortfolioDetails();
    await getMarginXPositions();
    await getMarginXTradingWatchlist();
    socketConnection();
    socketIndexConnection();
  }

  int getOpenPositionCount() {
    int openCount = 0;
    for (var position in marginXPositionList) {
      if (position.lots != 0) {
        openCount++;
      }
    }
    return openCount;
  }

  int getClosePositionCount() {
    int closeCount = 0;
    for (var position in marginXPositionList) {
      if (position.lots == 0) {
        closeCount++;
      }
    }
    return closeCount;
  }

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.marginXSearchSymbol);
  }

  Future calculateUserWalletAmount() async {
    num amount = 0;
    var response = await Get.find<WalletRepository>().getWalletTransactionsList();
    var list = response.data?.data?.transactions ?? [];
    for (var e in list) amount += e.amount ?? 0;
    walletBalance(amount);
  }

  String getStockIndexName(int instId) {
    int index = stockIndexInstrumentList.indexWhere((element) => element.instrumentToken == instId);
    return stockIndexInstrumentList[index].displayName ?? '-';
  }

  bool checkIfPurchased(marginx) {
    bool isPurchased = false;
    for (MParticipants user in marginx.participants) {
      if (user.userId == userDetails.value.sId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  bool checkIfLivePurchased(marginx) {
    bool isPurchased = false;
    for (Participantss user in marginx.participants) {
      if (user.userId == userDetails.value.sId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  int calculateSeatsLeft(int maxParticipants, int currentParticipants) {
    int seatsLeft = maxParticipants - currentParticipants;

    return seatsLeft >= 0 ? seatsLeft : 0;
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

    for (var position in marginXPositionList) {
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

  num calculateGrossPNL(num amount, int lots, num ltp) {
    if (ltp == 0) return 0;
    num pnl = 0;
    num value = (amount + (lots * ltp));
    pnl += value;
    return pnl;
  }

  num calculateTotalGrossPNL() {
    num totalGross = 0;
    for (var position in marginXPositionList) {
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
    for (var position in marginXPositionList) {
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
    for (var position in marginXPositionList) {
      if (position.lots != 0) {
        amount += position.amount!.abs();
        lots += position.lots ?? 0;
      }
    }
    num openingBalance = 0;
    num totalFund = marginXPortfolio.value.totalFund ?? 0;

    if (marginXPortfolio.value.totalFund != null) {
      openingBalance = marginXPortfolio.value.totalFund ?? 0;
    } else {
      openingBalance = totalFund;
    }
    num availableMargin = openingBalance != 0
        ? lots == 0
            ? openingBalance + calculateTotalNetPNL()
            : openingBalance - amount
        : totalFund;
    return availableMargin;
  }

  // num calculateMargin() {
  //   num amount = 0;
  //   num lots = 0;
  //   for (var position in marginXPositionList) {
  //     if (position.lots != 0) {
  //       amount += position.amount!.abs();
  //       lots += position.lots ?? 0;
  //     }
  //   }
  //   num openingBalance = 0;
  //   num totalFund = marginXPortfolio.value.totalFund ?? 0;

  //   if (marginXPortfolio.value.totalFund != null) {
  //     totalFund = marginXPortfolio.value.totalFund ?? 0;
  //   } else {
  //     totalFund = totalFund;
  //   }

  //   num availableMargin = openingBalance != 0
  //       ? lots == 0
  //           ? openingBalance + calculateTotalNetPNL()
  //           : openingBalance - amount
  //       : totalFund;
  //   return availableMargin;
  // }

  num calculateReturn() {
    num? entryFee = liveMarginX.value.marginXTemplate?.entryFee;
    if (entryFee == null) {
      return 0;
    }
    num factor = marginXPortfolio.value.totalFund! / entryFee;
    num value = calculateTotalNetPNL() / factor;
    return value;
  }

  num calculateAccountBalance() {
    num? entryFee = liveMarginX.value.marginXTemplate?.entryFee;
    num bal = entryFee! + calculateReturn();
    return bal;
  }

  num calculatePayout(num entryFee, num earning) {
    num pay = (entryFee - earning).toDouble();
    num payout = (pay / entryFee) * 100;
    return payout;
  }

  void changeTabBarIndex(int val) => selectedTabBarIndex.value = val;

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

  Future getMarginXTradingWatchlist() async {
    isLoading(true);
    try {
      final RepoResponse<TradingWatchlistResponse> response = await repository.getMarginXWatchlist(
        liveMarginX.value.isNifty,
        liveMarginX.value.isBankNifty,
        liveMarginX.value.isFinNifty,
      );
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

  Future getMarginXPositions() async {
    isLoading(true);
    try {
      final RepoResponse<MarginXPositionListResponse> response =
          await repository.getMarginXPositions(liveMarginX.value.id);
      if (response.data != null) {
        if (response.data?.data! != null) {
          marginXPositionList(response.data?.data ?? []);
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

  Future getMarginXPortfolioDetails() async {
    isLoading(true);
    try {
      final RepoResponse<MarginXPortfolioResponse> response =
          await repository.getMarginXPortfolioDetails(liveMarginX.value.id);
      if (response.data?.data != null) {
        marginXPortfolio(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future searchInstruments(
    String? value,
  ) async {
    isLoading(true);
    try {
      final RepoResponse<TradingInstrumentListResponse> response = await repository.searchInstruments(
        value,
        liveMarginX.value.isNifty,
        liveMarginX.value.isBankNifty,
        liveMarginX.value.isFinNifty,
      );
      if (response.data != null) {
        if (response.data?.data != null) {
          tradingInstruments.clear();
          tradingInstruments.addAll(response.data?.data ?? []);
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
      chartInstrument: inst.chartInstrument,
      instrument: inst.name,
      exchange: inst.exchange,
      status: inst.status,
      symbol: inst.tradingsymbol,
      lotSize: inst.lotSize,
      instrumentToken: inst.instrumentToken,
      uId: Uuid().v4(),
      contractDate: inst.expiry,
      maxLot: 1800,
      from: "Daily Contest",
      exchangeSegment: inst.segment,
      exchangeInstrumentToken: inst.exchangeToken,
    );

    log('addInstrument : ${data.toJson()}');
    try {
      await repository.addInstrument(data.toJson());
      // if (response.data?.message == "Instrument Added") {
      tradingWatchlist.clear();
      tradingInstruments.clear();
      await getMarginXTradingWatchlist();
      await searchInstruments(
        searchTextController.text,
      );
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
      await getMarginXTradingWatchlist();
      await searchInstruments(
        searchTextController.text,
      );
      log('MarginX WatchList : ${tradingWatchlist.length}');
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

  Future placeMarginXOrder(TransactionType type, TradingInstrument inst) async {
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
    ContestPlaceOrderRequest data = ContestPlaceOrderRequest(
      orderType: "MARKET",
      price: "",
      product: "NRML",
      quantity: selectedQuantity.value,
      triggerPrice: "",
      battleId: liveMarginX.value.id,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      contestId: liveMarginX.value.id,
      createdBy: userDetailsData.name,
      exchange: inst.exchange,
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      marginxId: liveMarginX.value.id,
      orderId: Uuid().v4(),
      paperTrade: false,
      stopLoss: "",
      subscriptionId: liveMarginX.value.id,
      symbol: inst.tradingsymbol,
      trader: userDetailsData.sId,
      uId: Uuid().v4(),
      userId: userDetailsData.email,
      validity: "DAY",
      variety: "regular",
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    log('placeVirtualTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.paperPlaceOrder(
        data.toJson(),
      );
      log(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successfull');
        await getMarginXPositions();
        await getMarginXPortfolioDetails();
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

  Future getUpComingMarginXList() async {
    isUpcomingLoading(true);
    try {
      final RepoResponse<UpComingMarginXListResponse> response = await repository.getUpComingMarginXList();
      if (response.data != null) {
        upComingMarginXList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isUpcomingLoading(false);
  }

  Future getLiveMarginXList() async {
    isLiveLoading(true);
    try {
      final RepoResponse<LiveMarginxListResponse> response = await repository.getLiveMarginXList();
      if (response.data != null) {
        liveMarginXList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLiveLoading(false);
  }

  Future getCompletedMarginXList() async {
    isCompletedLoading(true);
    try {
      final RepoResponse<CompletedMarginxListResponse> response = await repository.getCompletedMarginXList();
      if (response.data != null) {
        completedMarginXList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isCompletedLoading(false);
  }

  Future getCompletedMarginXOrders(String? id) async {
    isOrdersLoading(true);
    try {
      final RepoResponse<CompletedMarginXOrdersResponse> response = await repository.getCompletedMarginXOrders(id);
      if (response.data != null) {
        completedMarginXOrdersList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isOrdersLoading(false);
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

  Future purchaseMarginX(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final RepoResponse<GenericResponse> response = await repository.purchaseMarginX(
        data,
      );
      if (response.data != null) {
        SnackbarHelper.showSnackbar(response.data?.message ?? 'Success');
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
      await Get.find<AuthController>().getUserDetails(navigate: false);
      loadUserDetails();
      getUpComingMarginXList();
      getLiveMarginXList();
    } catch (e) {
      log('Purchase Marginx: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future<void> getShareMarginX(bool isUpcoming) async {
    isLiveLoading(true);

    try {
      await repository.getShareMarginX(isUpcoming ? upComingMarginX.value.id : liveMarginX.value.id);

      if (isUpcoming) {
        getUpComingMarginXList();
      } else {
        getLiveMarginXList();
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }

    isLiveLoading(false);
  }
}
