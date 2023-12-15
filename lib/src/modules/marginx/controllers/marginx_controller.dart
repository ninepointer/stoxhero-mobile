import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';
import '../../../app/app.dart';

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

  final isTradingOrderSheetLoading = false.obs;
  bool get isTradingOrderSheetLoadingStatus => isTradingOrderSheetLoading.value;

  final isWatchlistStateLoading = false.obs;
  bool get isWatchlistStateLoadingStatus => isWatchlistStateLoading.value;

  final isPositionStateLoading = false.obs;
  bool get isPositionStateLoadingStatus => isPositionStateLoading.value;

  final isPortfolioStateLoading = false.obs;
  bool get isPortfolioStateLoadingStatus => isPortfolioStateLoading.value;

  final isInstrumentListLoading = false.obs;
  bool get isInstrumentListLoadingStatus => isInstrumentListLoading.value;

  final isMarginStateLoading = false.obs;
  bool get isMarginStateLoadingStatus => isMarginStateLoading.value;

  final isPendingOrderStateLoading = false.obs;
  bool get isPendingOrderStateLoadingStatus => isPendingOrderStateLoading.value;

  final isOrderStateLoading = false.obs;
  bool get isOrderStateLoadingStatus => isOrderStateLoading.value;

  final isExecutedOrderStateLoading = false.obs;
  bool get isExecutedOrderStateLoadingStatus =>
      isExecutedOrderStateLoading.value;

  final selectedTabBarIndex = 0.obs;

  final lotsValueForStopProfit = <int>[0].obs;
  final lotsValueForStopLoss = <int>[0].obs;
  final selectedStopLossQuantity = 0.obs;
  final selectedStopProfitQuantity = 0.obs;
  final stoplossQuantityList = <StoplossQuantityData>[].obs;

  final searchTextController = TextEditingController();
  final upComingMarginXList = <UpcomingMarginX>[].obs;
  final upComingMarginX = UpcomingMarginX().obs;
  final liveMarginXList = <LiveMarginX>[].obs;
  final completedMarginXList = <CompletedMarginX>[].obs;
  final completedMarginXOrdersList = <CompletedMarginXOrders>[].obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final tradingInstrumentTradeDetailsList =
      <TradingInstrumentTradeDetails>[].obs;
  final marginXPositionList = <TradingPosition>[].obs;
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
  final marginRequired = MarginRequiredResponse().obs;

  final stopLossFormKey = GlobalKey<FormState>();
  final stopLossPriceTextController = TextEditingController();
  final stopProfitPriceTextController = TextEditingController();
  final quanitityTextController = TextEditingController();
  final limitPriceTextController = TextEditingController();
  final stopLossExecutedOrdersList = <StopLossExecutedOrdersList>[].obs;
  final stopLossPendingOrderList = <StopLossPendingOrdersList>[].obs;
  final stopLossPendingOrder = StopLossPendingOrdersList().obs;
  final stopLossPendingCancelOrder = StopLossPendingCancelOrder().obs;
  final todayOrders = CompletedMarginXOrders().obs;
  final selectedType = "".obs;
  final selectedGroupValue = 0.obs;

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
    await getMarginXTradingWatchlist();
    await getMarginXPositions();
    await getStopLossPendingOrder();
    await getStopLossExecutedOrder();
    await getMarginXTodayOrdersList();
    await getMarginXPortfolioDetails();
    socketConnection();
    await liveIndexDetails();
    socketIndexConnection();
    socketSendConnection();
  }

  Future loadDataAfterPaymentSuccess() async {
    await Get.find<AuthController>().getUserDetails(navigate: false);
    await loadUserDetails();
    getUpComingMarginXList();
    getLiveMarginXList();
  }

  bool handleTextField(
      TransactionType type, int transactionLotSize, int positionLots) {
    bool isDisabled = false;

    if (type == TransactionType.buy) {
      if (transactionLotSize < 0 && transactionLotSize.abs() == positionLots) {
        isDisabled = true;
        log("BUY - Disable TextField");
      } else {
        isDisabled = false;
        log("BUY - Enable TextField");
      }
    } else if (type == TransactionType.sell) {
      if (transactionLotSize < 0 || transactionLotSize.abs() < positionLots) {
        isDisabled = false;
        log("SELL - Enable TextField");
      } else {
        isDisabled = true;
        log("SELL - Disable TextField");
      }
    }

    return isDisabled;
  }

  void handleRadioValueChanged(int newValue, String labelText) {
    selectedGroupValue.value = newValue;
    selectedType.value = labelText;
  }

  int getOpenPositionCount() {
    int openCount = 0;
    for (var position in marginXPositionList) {
      if (position.id?.isLimit ?? false) {
      } else if (position.lots != 0) {
        openCount++;
      }
    }
    return openCount;
  }

  int getClosePositionCount() {
    int closeCount = 0;
    for (var position in marginXPositionList) {
      if (position.id?.isLimit ?? false) {
      } else if (position.lots == 0) {
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
    var response =
        await Get.find<WalletRepository>().getWalletTransactionsList();
    var list = response.data?.data?.transactions ?? [];
    for (var e in list) amount += e.amount ?? 0;
    walletBalance(amount);
  }

  String getStockIndexName(int instId) {
    int index = stockIndexInstrumentList
        .indexWhere((element) => element.instrumentToken == instId);
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

  List<int> generateLotsListFoStopLoss({String? type, int? openLots}) {
    List<int> result = [];

    var relevantQuantities = stoplossQuantityList.where(
      (element) => element.type == "StopLoss" && element.symbol == type,
    );
    int totalQuantity = relevantQuantities.fold(
      0,
      (sum, element) => sum + (element.quantity ?? 0),
    );
    int cutoff = (openLots ?? 0).abs() - (totalQuantity ?? 0);
    int startValue = 0;
    print("stoplossQuantityPrev${openLots}");

    if (type?.contains('BANK') ?? false) {
      for (int i = 0; i <= 900; i += 15) result.add(i);
    } else if (type?.contains('FIN') ?? false) {
      for (int i = 0; i <= 1800; i += 40) result.add(i);
    } else {
      for (int i = 0; i <= 1800; i += 50) result.add(i);
    }
    startValue = result.first;
    List<int> newList = [];
    for (int i = 0; i < result.length; i++) {
      if (result[i] <= cutoff) {
        newList.add(result[i]);
      } else {
        break;
      }
    }
    print("newList${newList}");
    print("genrateStopLoss${cutoff}");
    selectedStopLossQuantity.value = newList.isNotEmpty ? newList.first : 0;

    lotsValueForStopLoss.assignAll(newList);
    return result;
  }

  List<int> generateLotsListForStopProfit({String? type, int? openLots}) {
    List<int> result = [];

    var relevantQuantities = stoplossQuantityList.where(
      (element) => element.type == "StopProfit" && element.symbol == type,
    );
    int totalQuantity = relevantQuantities.fold(
      0,
      (sum, element) => sum + (element.quantity ?? 0),
    );
    // int cutoff = math.max(openLots ?? 0, totalQuantity) -
    //     math.min(openLots ?? 0, totalQuantity);
    int cutoff = (openLots ?? 0).abs() - (totalQuantity ?? 0);
    int startValue = 0;

    if (type?.contains('BANK') ?? false) {
      for (int i = 0; i <= 900; i += 15) result.add(i);
    } else if (type?.contains('FIN') ?? false) {
      for (int i = 0; i <= 1800; i += 40) result.add(i);
    } else {
      for (int i = 0; i <= 1800; i += 50) result.add(i);
    }
    startValue = result.first;
    List<int> newList = [];
    for (int i = 0; i < result.length; i++) {
      if (result[i] <= cutoff) {
        newList.add(result[i]);
      } else {
        break;
      }
    }
    print("selectedStopProfitQuantity${result}");
    selectedStopProfitQuantity.value = newList.isNotEmpty ? newList.first : 0;

    lotsValueForStopProfit.assignAll(newList);
    return result;
  }

  void calculateTotalPositionValues() {
    int totalLots = 0;
    num totalBrokerage = 0;
    num totalGross = 0;
    num totalNet = 0;

    for (var position in marginXPositionList) {
      if (position.id?.isLimit ?? false) {
      } else {
        totalLots += position.lots ?? 0;
        totalBrokerage += position.brokerage ?? 0;
        totalGross += position.lastaverageprice ?? 0;
        totalNet += position.amount ?? 0;
      }
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
      if (position.id?.isLimit != true) {
        // Check if isLimit is not true
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
    }
    return totalGross.round();
  }

  num calculateTotalNetPNL() {
    num totalNetPNL = 0;
    for (var position in marginXPositionList) {
      if (position.id?.isLimit != true) {
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
    }
    return totalNetPNL.round();
  }

  num calculateMargin() {
    num lots = 0;
    num margin = 0;
    num amount = 0;
    num limitMargin = 0;
    for (var position in marginXPositionList) {
      if (position.lots != 0) {
        lots += position.lots ?? 0;
        margin += position.margin ?? 0;
      }
      if (position.id?.isLimit == true) {
        limitMargin += position.margin ?? 0;
      } else {
        amount += ((position.amount ?? 0) - (position.brokerage ?? 0));
      }
    }
    num openingBalance = 0;
    num totalFund = marginXPortfolio.value.totalFund ?? 0;

    if (marginXPortfolio.value.totalFund != null) {
      openingBalance = marginXPortfolio.value.totalFund ?? 0;
    } else {
      openingBalance = totalFund;
    }
    num availableMargin = (calculateTotalNetPNL() < 0)
        ? (lots == 0
            ? (openingBalance - margin + calculateTotalNetPNL())
            : (openingBalance - (amount.abs() + limitMargin)))
        : (openingBalance - margin);

    return availableMargin;
  }

  num calculateUnRealisedPNL() {
    num pnl = calculateTotalNetPNL();
    if (pnl >= 0) {
      return pnl;
    } else {
      return 0;
    }
  }

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
        (stock) =>
            stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) {
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
        priceValue = tradingInstrumentTradeDetailsList[index].lastPrice ?? 0;
      }
    }
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

  Future getMarginXPendingStoplossOrderData(String id) async {
    try {
      final RepoResponse<VirtualStopLossPendingOrderResponse> response =
          await repository
              .getMarginXStopLossPendingOrder("657b4f2915faa5796e996b8c");
      if (response.data != null) {
        if (response.data?.data! != null) {
          stoplossQuantityList(response.data?.quantity ?? []);
          print("stoplossQuantityList${stoplossQuantityList.length}");
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future getMarginXTradingWatchlist() async {
    isWatchlistStateLoading(true);
    try {
      final RepoResponse<TradingWatchlistResponse> response =
          await repository.getMarginXWatchlist(
        liveMarginX.value.isNifty,
        liveMarginX.value.isBankNifty,
        liveMarginX.value.isFinNifty,
      );
      if (response.data != null) {
        if (response.data?.data! != null) {
          tradingWatchlistIds.clear();
          tradingWatchlist(response.data?.data ?? []);
          for (var element in tradingWatchlist) {
            tradingWatchlistIds.add(element.instrumentToken ??
                element.exchangeInstrumentToken ??
                0);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future getMarginXPositions() async {
    isPositionStateLoading(true);
    try {
      final RepoResponse<TradingPositionListResponse> response =
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
    isPositionStateLoading(false);
  }

  Future getMarginXPortfolioDetails() async {
    isPortfolioStateLoading(true);
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
    isPortfolioStateLoading(false);
  }

  Future searchInstruments(String? value, {bool showShimmer = true}) async {
    showShimmer ? isInstrumentListLoading(true) : isWatchlistStateLoading(true);
    try {
      final RepoResponse<TradingInstrumentListResponse> response =
          await repository.searchInstruments(
        value,
        liveMarginX.value.isNifty,
        liveMarginX.value.isBankNifty,
        liveMarginX.value.isFinNifty,
      );
      if (response.data != null) {
        if (response.data?.data != null) {
          tradingInstruments.addAll(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    showShimmer
        ? isInstrumentListLoading(false)
        : isWatchlistStateLoading(false);
  }

  Future addInstrument(TradingInstrument inst) async {
    isWatchlistStateLoading(true);
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
      await getMarginXTradingWatchlist();
      await searchInstruments(searchTextController.text, showShimmer: false);
      SnackbarHelper.showSnackbar('Instrument Added');
      // } else {
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future removeInstrument(int? instToken) async {
    isWatchlistStateLoading(true);
    try {
      await repository.removeInstrument(instToken ?? 0);
      selectedWatchlistIndex(-1);
      // if (response.data != null) {
      // tradingWatchlist.clear();
      // tradingInstruments.clear();
      await getMarginXTradingWatchlist();
      await searchInstruments(searchTextController.text, showShimmer: false);
      SnackbarHelper.showSnackbar('Instrument Remove');
      // } else {
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future placeMarginXOrder(TransactionType type, TradingInstrument inst) async {
    isTradingOrderSheetLoading(true);
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
      exchange: inst.exchange,
      symbol: inst.tradingsymbol,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      quantity: selectedQuantity.value,
      product: "NRML",
      orderType: selectedType.value,
      stopLoss: "",
      stopLossPrice: double.tryParse(stopLossPriceTextController.text),
      stopProfitPrice: double.tryParse(stopProfitPriceTextController.text),
      price: double.tryParse(limitPriceTextController.text),
      uId: Uuid().v4(),
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      validity: "DAY",
      variety: "regular",
      createdBy: userDetails.value.name,
      userId: userDetails.value.email,
      trader: userDetails.value.sId,
      orderId: Uuid().v4(),
      paperTrade: false,
      subscriptionId: liveMarginX.value.id,
      battleId: liveMarginX.value.id,
      contestId: liveMarginX.value.id,
      marginxId: liveMarginX.value.id,
      triggerPrice: "",
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    log('placeVirtualTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response =
          await repository.paperPlaceOrder(
        data.toJson(),
      );
      log(response.data.toString());
      Get.back();
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successful');
        await getMarginXPositions();
        await getStopLossPendingOrder();
        await getMarginXTodayOrdersList();
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
    isTradingOrderSheetLoading(false);
  }

  Future getInstrumentLivePriceList() async {
    isLoading(true);
    try {
      final RepoResponse<InstrumentLivePriceListResponse> response =
          await repository.getInstrumentLivePrices();
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
      final RepoResponse<UpComingMarginXListResponse> response =
          await repository.getUpComingMarginXList();
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
      final RepoResponse<LiveMarginxListResponse> response =
          await repository.getLiveMarginXList();
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
      final RepoResponse<CompletedMarginxListResponse> response =
          await repository.getCompletedMarginXList();
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
      final RepoResponse<CompletedMarginXOrdersResponse> response =
          await repository.getCompletedMarginXOrders(id);
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
        tempList =
            TradingInstrumentTradeDetailsListResponse.fromJson(data).data ?? [];
        tempList?.forEach((element) {
          if (tradingInstrumentTradeDetailsList
              .any((obj) => obj.instrumentToken == element.instrumentToken)) {
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
      final RepoResponse<StockIndexInstrumentListResponse> response =
          await repository.getStockIndexInstrumentsList();
      if (response.data != null) {
        stockIndexInstrumentList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future liveIndexDetails() async {
    try {
      final RepoResponse<IndexLivePriceListResponse> response =
          await repository.getIndexLivePrices();
      if (response.data != null && response.data!.data != null) {
        stockIndexDetailsList.clear();

        stockIndexDetailsList.assignAll(
          response.data!.data!.map((item) {
            return StockIndexDetails.fromJson(item.toJson());
          }).toList(),
        );
      } else {
        if (stockIndexDetailsList.isEmpty) {
          stockIndexDetailsList.assignAll(stockIndexDetailsList);
        }
      }
      print("liveIndexDetails${stockIndexDetailsList.length}");
    } catch (e) {
      log(e.toString());

      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
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

  Future purchaseMarginX(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final RepoResponse<GenericResponse> response =
          await repository.purchaseMarginX(
        data,
      );
      if (response.data != null) {
        SnackbarHelper.showSnackbar(response.data?.message ?? 'Success');
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
      loadDataAfterPaymentSuccess();
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future<void> getShareMarginX(bool isUpcoming) async {
    try {
      await repository.getShareMarginX(
          isUpcoming ? upComingMarginX.value.id : liveMarginX.value.id);
      // if (isUpcoming) {
      //   getUpComingMarginXList();
      // } else {
      //   getLiveMarginXList();
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  int calculateQuantity(
      TransactionType type, int tradingLots, int selectQuantity) {
    if (type == TransactionType.sell || type == TransactionType.exit) {
      if (tradingLots == selectQuantity ||
          tradingLots.abs() >= selectQuantity) {
        return 0;
      } else if (tradingLots.abs() <= selectQuantity) {
        return selectQuantity - tradingLots.abs();
      }
    }
    return selectQuantity;
  }

  Future getMarginRequired(TransactionType type, TradingInstrument inst) async {
    isMarginStateLoading(true);

    MarginRequiredRequest data = MarginRequiredRequest(
      exchange: inst.exchange,
      symbol: inst.tradingsymbol,
      buyOrSell: inst.lotSize.toString().contains('-')
          ? type == TransactionType.buy
              ? 'SELL'
              : 'BUY'
          : type == TransactionType.buy
              ? 'BUY'
              : 'SELL',
      quantity:
          calculateQuantity(type, inst.lotSize ?? 0, selectedQuantity.value),
      product: "NRML",
      orderType: selectedType.value,
      validity: "DAY",
      variety: "regular",
      price: limitPriceTextController.text,
      lastPrice: inst.lastPrice.toString(),
    );

    try {
      final RepoResponse<MarginRequiredResponse> response =
          await repository.getMarginRequired(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          marginRequired(response.data);
        } else {
          SnackbarHelper.showSnackbar(response.error?.message);
        }
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isMarginStateLoading(false);
    }
  }

  Future getMarginXTodayOrdersList() async {
    isOrderStateLoading(true);
    try {
      final RepoResponse<CompletedMarginXOrdersResponse> response =
          await repository.getMarginXTodayOrdersList(
        liveMarginX.value.id,
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          completedMarginXOrdersList(response.data?.data ?? []);
        } else {
          SnackbarHelper.showSnackbar(response.error?.message);
        }
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isOrderStateLoading(false);
    }
  }

  Future getStopLossExecutedOrder() async {
    isExecutedOrderStateLoading(true);
    try {
      final RepoResponse<StopLossExecutedOrdersListResponse> response =
          await repository.getStopLossExecutedOrder(
        liveMarginX.value.id,
      );
      if (response.data?.status?.toLowerCase() == "success") {
        stopLossExecutedOrdersList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isExecutedOrderStateLoading(false);
  }

  Future getStopLossPendingOrder() async {
    isPendingOrderStateLoading(true);
    try {
      final RepoResponse<StopLossPendingOrdersListResponse> response =
          await repository.getStopLossPendingOrder(
        liveMarginX.value.id,
      );
      if (response.data?.status?.toLowerCase() == "success") {
        stopLossPendingOrderList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
  }

  Future getStopLossPendingCancelOrder(String? id) async {
    isPendingOrderStateLoading(true);
    try {
      await repository.getStopLossPendingCancelOrder(id ?? '');
      await getStopLossPendingOrder();
      await getMarginXPortfolioDetails();
      await getStopLossExecutedOrder();
      loadData();
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
  }

  Future pendingOrderModify(
      TransactionType type, TradingInstrument inst) async {
    isPendingOrderStateLoading(true);
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
    PendingOrderModifyRequest data = PendingOrderModifyRequest(
      exchange: inst.exchange,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      quantity: selectedQuantity.value,
      product: "NRML",
      orderType: "SL/SP-M",
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      stopLossPrice: stopLossPriceTextController.text,
      stopProfitPrice: stopProfitPriceTextController.text,
      stopLossQuantity: selectedStopLossQuantity.value,
      stopProfitQuantity: selectedStopProfitQuantity.value,
      symbol: inst.tradingsymbol,
      validity: "DAY",
      id: liveMarginX.value.id,
      lastPrice: inst.lastPrice.toString(),
      variety: "regular",
      from: "MarginX Trader",
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    print('PendingOrderModifyRequest : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response =
          await repository.pendingOrderModify(
        data.toJson(),
      );
      Get.back();
      print(response.data.toString());
      if (response.data?.status == "Success") {
        SnackbarHelper.showSnackbar(response.data?.message);
        await getStopLossPendingOrder();
        await getMarginXTodayOrdersList();
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
    isPendingOrderStateLoading(false);
  }

  Future getStopLossEditOrder(String? id, String? type) async {
    isPendingOrderStateLoading(true);
    PendingEditOrderRequest data = PendingEditOrderRequest(
      executionPrice: type == "StopLoss"
          ? stopLossPriceTextController.text
          : (type == "StopProfit"
              ? stopProfitPriceTextController.text
              : (type == "Limit" ? limitPriceTextController.text : '0')),
    );
    try {
      final response = await repository.getStopLossEditOrder(
        id,
        data.toJson(),
      );
      Get.back();
      getStopLossPendingOrder();
      if (response.data?.status?.toLowerCase() == "Success") {
        getStopLossPendingOrder();
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
  }

  Future socketSendConnection() async {
    isPendingOrderStateLoading(true);
    try {
      socketService.socket.off('sendOrderResponse${userDetails.value.sId}');
      socketService.socket.on(
        'sendOrderResponse${userDetails.value.sId}',
        (data) {
          print('sendOrderResponse${userDetails.value.sId} $data');
          if (data.containsKey("message")) {
            String message = data["message"];
            SnackbarHelper.showSnackbar(message);
          }
          getMarginXPositions();
          getStopLossPendingOrder();
          getStopLossExecutedOrder();
          getMarginXTodayOrdersList();
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    isPendingOrderStateLoading(false);
  }
}
