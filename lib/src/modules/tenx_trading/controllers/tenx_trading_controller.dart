import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  final isWatchlistLoading = false.obs;
  bool get isWatchlistLoadingStatus => isWatchlistLoading.value;

  final isPositionLoading = false.obs;
  bool get isPositionLoadingStatus => isPositionLoading.value;

  final isActiveLoading = false.obs;
  bool get isActiveLoadingStatus => isActiveLoading.value;

  final isSubscribeLoading = false.obs;
  bool get isSubscribeLoadingStatus => isSubscribeLoading.value;

  final isExpiredLoading = false.obs;
  bool get isExpiredLoadingStatus => isExpiredLoading.value;

  final isLeaderboardLoading = false.obs;
  bool get isLeaderboardLoadingStatus => isLeaderboardLoading.value;

  final isPendingOrderStateLoading = false.obs;
  bool get isPendingOrderStateLoadingStatus => isPendingOrderStateLoading.value;

  final isOrderStateLoading = false.obs;
  bool get isOrderStateLoadingStatus => isOrderStateLoading.value;

  final isExecutedOrderStateLoading = false.obs;
  bool get isExecutedOrderStateLoadingStatus =>
      isExecutedOrderStateLoading.value;

  final isMarginStateLoading = false.obs;
  bool get isMarginStateLoadingStatus => isMarginStateLoading.value;

  final selectedTabBarIndex = 0.obs;

  final stopLossFormKey = GlobalKey<FormState>();
  final searchTextController = TextEditingController();
  final stopLossPriceTextController = TextEditingController();
  final stopProfitPriceTextController = TextEditingController();
  final quanitityTextController = TextEditingController();
  final limitPriceTextController = TextEditingController();
  final selectedSubscriptionId = ''.obs;
  final selectedSubscriptionTime = ''.obs;
  final selectSubscriptionName = ''.obs;
  final selectSubscriptionAmount = 0.obs;
  final selectedSubscription = TenxActivePlan().obs;
  final walletBalance = RxNum(0);
  final selectedWatchlistIndex = RxInt(-1);

  final tradingInstrumentTradeDetailsList =
      <TradingInstrumentTradeDetails>[].obs;
  final tenxInstrumentTradeDetailsList =
      <TenxTradingInstrumentTradeDetails>[].obs;
  final tradingInstruments = <TradingInstrument>[].obs;
  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;

  final tenxPositionsList = <TradingPosition>[].obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final tenxPosition = TradingPosition().obs;

  final tenxPortfolioDetails = TenxTradingPortfolioDetails().obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final userSubscriptionsIds = <String>[].obs;

  final selectedQuantity = 0.obs;
  final selectedStringQuantity = "0".obs;
  final lotsValueList = <int>[0].obs;

  final defaultSelectedValidity = PlanValidity(label: 'All', validity: 0);

  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;
  final tenxCountTradingDays = <CountTradingDays>[].obs;
  final selectedTenXSub = TenXSubscription().obs;
  final tenXSubscription = <TenXSubscription>[].obs;

  final tenxLeaderboard = <TenxLeaderboardList>[].obs;
  final stopLossExecutedOrdersList = <StopLossExecutedOrdersList>[].obs;
  final stopLossPendingOrderList = <StopLossPendingOrdersList>[].obs;
  final stopLossPendingOrder = StopLossPendingOrdersList().obs;
  final stopLossPendingCancelOrder = StopLossPendingCancelOrder().obs;
  final selectedType = "".obs;
  final selectedGroupValue = 0.obs;
  final isMarketSelected = true.obs;
  final tenxTradeTodaysOrdersList = <TenxTradeOrder>[].obs;

  final sendOrder = SendOrderResponse().obs;
  final sendOrderList = <SendOrderResponse>[].obs;

  final tenxAvailablePlans = <TenxActivePlan>[].obs;
  final tenxAvailablePlansUnFiltered = <TenxActivePlan>[].obs;

  final tenxSubscribedPlansPNLData = TenxSubscribedPlanPnl().obs;
  final tenxSubscribedPlans = <TenxSubscribedPlan>[].obs;
  final tenxSubscribedPlansUnFiltered = <TenxSubscribedPlan>[].obs;
  final tenxSubscribedPlanSelected = TenxSubscribedPlan().obs;

  final tenxExpiredPlans = <TenxExpiredPlan>[].obs;
  final tenxExpiredPlansUnFiltered = <TenxExpiredPlan>[].obs;
  final tenxExpiredPlanSelected = TenxExpiredPlan().obs;

  final tenxAvailableValidityList = <PlanValidity>[].obs;
  final tenxAvailableValiditySelected =
      PlanValidity(label: 'All', validity: 0).obs;

  final tenxSubscribedValidityList = <PlanValidity>[].obs;
  final tenxSubscribedValiditySelected =
      PlanValidity(label: 'All', validity: 0).obs;

  final tenxExpiredValidityList = <PlanValidity>[].obs;
  final tenxExpiredValiditySelected =
      PlanValidity(label: 'All', validity: 0).obs;

  final marginRequired = MarginRequiredResponse().obs;

  Future loadUserDetails() async {
    userDetails.value = AppStorage.getUserDetails();
  }

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getTenxActivePlans();
    await getTenxSubscribedPlans();
    await getTenxExpiredPlans();

    await getTenxLeaderboard();
  }

  Future loadTenxData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getTenxCountTradingDays();
    await getInstrumentLivePriceList();
    await getStockIndexInstrumentsList();

    // await getTenXSubscriptionList();
    await getTenxTradingWatchlist();
    await getTenxPositionList();
    await getStopLossPendingOrder();
    await getStopLossExecutedOrder();
    await getTenxTodayOrdersList();
    await getTenxTradingPortfolioDetails();
    socketConnection();
    socketIndexConnection();
    socketSendConnection();
  }

  Future loadDataAfterPaymentSuccess() async {
    await Get.find<AuthController>().getUserDetails(navigate: false);
    await loadUserDetails();
    getTenxActivePlans();
  }

  void changeTabBarIndex(int val) => selectedTabBarIndex.value = val;

  void updateTenxAvailablePlanValidity() {
    var filteredList = <TenxActivePlan>[];
    if (tenxAvailableValiditySelected.value.label == 'All') {
      filteredList = tenxAvailablePlansUnFiltered;
    } else {
      for (var plan in tenxAvailablePlansUnFiltered) {
        if (plan.validity == tenxAvailableValiditySelected.value.validity) {
          filteredList.add(plan);
        }
      }
    }
    tenxAvailablePlans(filteredList);
  }

  void updateTenxSubscribedPlanValidity() {
    var filteredList = <TenxSubscribedPlan>[];
    if (tenxSubscribedValiditySelected.value.label == 'All') {
      filteredList = tenxSubscribedPlansUnFiltered;
    } else {
      for (var plan in tenxSubscribedPlansUnFiltered) {
        if (plan.validity == tenxSubscribedValiditySelected.value.validity) {
          filteredList.add(plan);
        }
      }
    }
    tenxSubscribedPlans(filteredList);
  }

  void updateTenxExpiredPlanValidity() {
    var filteredList = <TenxExpiredPlan>[];
    if (tenxExpiredValiditySelected.value.label == 'All') {
      filteredList = tenxExpiredPlansUnFiltered;
    } else {
      for (var plan in tenxExpiredPlansUnFiltered) {
        if (plan.validity == tenxExpiredValiditySelected.value.validity) {
          filteredList.add(plan);
        }
      }
    }
    tenxExpiredPlans(filteredList);
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

  String getFormattedExpiryDate(String? subscribedOn, int? expiryDays) {
    if (subscribedOn != null) {
      DateTime subscribedDateTimeUTC = DateTime.parse(subscribedOn);
      DateTime expiryDateTimeUTC =
          subscribedDateTimeUTC.add(Duration(days: expiryDays ?? 0));
      DateTime expiryDateTimeIST =
          expiryDateTimeUTC.add(Duration(hours: 5, minutes: 30));
      String formattedIST =
          DateFormat('d MMM yyyy hh:mm a').format(expiryDateTimeIST);
      return formattedIST;
    } else {
      return '-';
    }
  }

  String date() {
    DateTime subscribedOn =
        DateTime.parse(tenxSubscribedPlanSelected.value.subscribedOn ?? '');
    DateTime newExpiryDate = subscribedOn
        .add(Duration(days: tenxSubscribedPlanSelected.value.expiryDays ?? 0));
    return newExpiryDate.toString();
  }

  int getOpenPositionCount() {
    int openCount = 0;
    for (var position in tenxPositionsList) {
      if (position.id?.isLimit ?? false) {
      } else if (position.lots != 0) {
        openCount++;
      }
    }
    return openCount;
  }

  int getClosePositionCount() {
    int closeCount = 0;
    for (var position in tenxPositionsList) {
      if (position.id?.isLimit ?? false) {
      } else if (position.lots == 0) {
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
    int index = stockIndexInstrumentList
        .indexWhere((element) => element.instrumentToken == instId);
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
      if (position.id?.isLimit ?? false) {
      } else {
        totalLots += position.lots ?? 0;
        totalBrokerage += position.brokerage ?? 0;
        totalGross += position.lastaverageprice ?? 0;
        totalNet += position.amount ?? 0;
      }

      // totalLots += position.lots ?? 0;
      // totalBrokerage += position.brokerage ?? 0;
      // totalGross += position.lastaverageprice ?? 0;
      // totalNet += position.amount ?? 0;
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

  // num calculateTotalGrossPNL() {
  //   num totalGross = 0;
  //   for (var position in tenxPositionsList) {
  //     num avg = position.amount ?? 0;
  //     int lots = position.lots?.toInt() ?? 0;
  //     num ltp = getInstrumentLastPrice(
  //       position.id?.instrumentToken ?? 0,
  //       position.id?.exchangeInstrumentToken ?? 0,
  //     );
  //     if (ltp == 0) return 0;
  //     num value = (avg + (lots) * ltp);
  //     totalGross += value;
  //   }
  //   return totalGross.round();
  // }

  num calculateTotalGrossPNL() {
    num totalGross = 0;
    for (var position in tenxPositionsList) {
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
    for (var position in tenxPositionsList) {
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

  // num calculateTotalNetPNL() {
  //   num totalNetPNL = 0;
  //   for (var position in tenxPositionsList) {
  //     num avg = position.amount ?? 0;
  //     int lots = position.lots?.toInt() ?? 0;
  //     num ltp = getInstrumentLastPrice(
  //       position.id?.instrumentToken ?? 0,
  //       position.id?.exchangeInstrumentToken ?? 0,
  //     );
  //     if (ltp == 0) return 0;
  //     num value = (avg + (lots) * ltp);
  //     num brokerage = position.brokerage ?? 0;
  //     num broker = value - brokerage;
  //     totalNetPNL += broker;
  //   }
  //   return totalNetPNL.round();
  // }

  num calculateMargin() {
    num lots = 0;
    num margin = 0;
    num amount = 0;
    num limitMargin = 0;
    for (var position in tenxPositionsList) {
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
    num totalFund = tenxPortfolioDetails.value.totalFund ?? 0;

    if (tenxPortfolioDetails.value.openingBalance != null) {
      openingBalance = tenxPortfolioDetails.value.openingBalance ?? 0;
    } else {
      openingBalance = totalFund;
    }
    num availableMargin = (calculateTotalNetPNL() < 0)
        ? (lots == 0
            ? (openingBalance - margin + calculateTotalNetPNL())
            : (openingBalance - (amount.abs() + limitMargin)))
        : (openingBalance - margin);
    // print('availableMargin $availableMargin');
    // print('calculateTotalNetPNL ${calculateTotalNetPNL()}');
    // print('margin$margin');
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

  Future getTenxTradingWatchlist() async {
    isWatchlistStateLoading(true);
    try {
      final RepoResponse<TradingWatchlistResponse> response =
          await repository.getTenxWatchlist();
      if (response.data != null) {
        if (response.data?.data! != null) {
          tradingWatchlist.clear();
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

  Future searchInstruments(String? value, {bool showShimmer = true}) async {
    showShimmer ? isInstrumentListLoading(true) : isWatchlistStateLoading(true);
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
    showShimmer
        ? isInstrumentListLoading(false)
        : isWatchlistStateLoading(false);
  }

  Future getTenxPositionList() async {
    isPositionStateLoading(true);
    try {
      final RepoResponse<TradingPositionListResponse> response =
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
    isPositionStateLoading(false);
  }

  Future getInstrumentLivePriceList() async {
    isInstrumentListLoading(true);
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
    isInstrumentListLoading(false);
  }

  Future getTenxTradingPortfolioDetails() async {
    isPortfolioStateLoading(true);
    try {
      final RepoResponse<TenxTradingPortfolioDetailsResponse> response =
          await repository.getTenxPortfolioDetails(
        selectedSubscriptionId.value,
      );
      if (response.data?.data != null) {
        tenxPortfolioDetails(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPortfolioStateLoading(false);
  }

  // Future loadExpiredTenxAnalyticsData() async {
  //   userDetails.value = AppStorage.getUserDetails();
  //   String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
  //   startDateTextController.text = date;
  //   endDateTextController.text = date;
  //   await getInternshipAnalyticsOverview();
  //   await getInternshipAnalyticsDateWisePnLOverviewDetails();
  //   await getInternshipAnalyticsMonthlyPnLOverviewDetails();
  // }

  // Future placeTenxTradingOrder(TransactionType type, TradingInstrument inst) async {
  //   isTradingOrderSheetLoading(true);
  //   if (type == TransactionType.exit) {
  //     if (selectedStringQuantity.value.contains('-')) {
  //       type = TransactionType.buy;
  //     } else {
  //       type = TransactionType.sell;
  //     }
  //   } else {
  //     if (selectedStringQuantity.value.contains('-')) {
  //       if (type == TransactionType.buy) {
  //         type = TransactionType.sell;
  //       } else {
  //         type = TransactionType.buy;
  //       }
  //     }
  //   }
  //   TenxTradingPlaceOrderRequest data = TenxTradingPlaceOrderRequest(
  //     exchange: inst.exchange,
  //     symbol: inst.tradingsymbol,
  //     buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
  //     quantity: selectedQuantity.value,
  //     price: "",
  //     product: "NRML",
  //     orderType: "MARKET",
  //     triggerPrice: "",
  //     stopLoss: "",
  //     uId: Uuid().v4(),
  //     exchangeInstrumentToken: inst.exchangeToken,
  //     validity: "DAY",
  //     variety: "regular",
  //     createdBy: userDetails.value.name,
  //     orderId: Uuid().v4(),
  //     subscriptionId: selectedSubscriptionId.value,
  //     userId: userDetails.value.email,
  //     instrumentToken: inst.instrumentToken,
  //     trader: userDetails.value.sId,
  //     paperTrade: false,
  //     tenxTraderPath: true,
  //     battleId: selectedSubscriptionId.value,
  //     marginxId: selectedSubscriptionId.value,
  //     deviceDetails: DeviceDetails(
  //       deviceType: 'Mobile',
  //       platformType: Platform.isAndroid ? 'Android' : 'iOS',
  //     ),
  //   );
  //   print('placeTenxTradingOrder : ${data.toJson()}');
  //   try {
  //     final RepoResponse<GenericResponse> response = await repository.placeTenxTradingOrder(
  //       data.toJson(),
  //     );
  //     Get.back();
  //     print(response.data.toString());
  //     if (response.data?.status == "Complete") {
  //       SnackbarHelper.showSnackbar('Trade Successful');
  //       await getTenxPositionsList();
  //       await getTenxTradingPortfolioDetails();
  //     } else if (response.data?.status == "Failed") {
  //       print(response.error!.message!.toString());
  //       SnackbarHelper.showSnackbar(response.error?.message);
  //     } else {
  //       SnackbarHelper.showSnackbar(response.error?.message);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
  //   }
  //   isTradingOrderSheetLoading(false);
  // }

  Future placeTenxTradingOrder(
      TransactionType type, TradingInstrument inst) async {
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
    TenxTradingPlaceOrderRequest data = TenxTradingPlaceOrderRequest(
      exchange: inst.exchange,
      symbol: inst.tradingsymbol,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      quantity: selectedQuantity.value,
      product: "NRML",
      orderType: selectedType.value,
      stopLoss: "",
      stopLossPrice: stopLossPriceTextController.text,
      stopProfitPrice: stopProfitPriceTextController.text,
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
      tenxTraderPath: true,
      subscriptionId: selectedSubscriptionId.value,
      battleId: selectedSubscriptionId.value,
      marginxId: selectedSubscriptionId.value,
      triggerPrice: "",
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    print('placeTenxTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response =
          await repository.placeTenxTradingOrder(
        data.toJson(),
      );
      Get.back();
      print(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successful');
        await getTenxPositionList();
        await getStopLossPendingOrder();
        await getTenxTodayOrdersList();
        await getTenxTradingPortfolioDetails();
      } else if (response.data?.status == "Failed") {
        log(response.error!.message!.toString());
        SnackbarHelper.showSnackbar(response.error?.message);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isTradingOrderSheetLoading(false);
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
      maxLot: 900,
      from: "TenX Trader",
      exchangeSegment: inst.segment,
      exchangeInstrumentToken: inst.exchangeToken,
    );

    log('addInstrument : ${data.toJson()}');
    try {
      await repository.addInstrument(data.toJson());
      // if (response.data?.message == "Instrument Added") {
      await getTenxTradingWatchlist();
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
      // if (response.data != null) {
      // selectedWatchlistIndex(-1);
      // tradingWatchlist.clear();
      // tradingInstruments.clear();
      await getTenxTradingWatchlist();
      await searchInstruments(searchTextController.text, showShimmer: false);
      SnackbarHelper.showSnackbar('Instrument Remove');

      // } else {
      //   SnackbarHelper.showSnackbar(response.error?.message);
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future purchaseSubscription(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final RepoResponse<GenericResponse> response =
          await repository.purchaseSubscription(
        data,
      );
      if (response.data?.status == "success") {
        SnackbarHelper.showSnackbar(
            response.data?.message ?? 'Subscription purchased successfully');
      }
      loadDataAfterPaymentSuccess();
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getStockIndexInstrumentsList() async {
    isInstrumentListLoading(true);
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
    isInstrumentListLoading(false);
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

  Future getTenxCountTradingDays() async {
    isLoading(true);
    try {
      final RepoResponse<CountTradingDaysResponse> response =
          await repository.getTenxCountTradingDays(
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
      final RepoResponse<TenXSubscriptionResponse> response =
          await repository.getTenXSubscriptionList();
      if (response.data != null) {
        tenXSubscription.clear();
        tenXSubscription(response.data?.data ?? []);
        if (tenXSubscription.isNotEmpty) {
          selectedTenXSub(tenXSubscription.first);
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

  Future getTenxActivePlans() async {
    isActiveLoading(true);
    try {
      final RepoResponse<TenxActivePlanListResponse> response =
          await repository.getTenxActiveSubscriptions();
      if (response.data?.status?.toLowerCase() == "success") {
        tenxAvailablePlans.clear();
        userSubscriptionsIds.clear();
        tenxAvailablePlans(response.data?.data ?? []);
        tenxAvailablePlansUnFiltered(response.data?.data ?? []);
        for (var userSub in userDetails.value.subscription!) {
          if (userSub.subscriptionId != null) {
            userSubscriptionsIds.add(userSub.subscriptionId!.id!);
          }
        }
        Set<int> uniqueValues = Set<int>();
        List<PlanValidity> result = [];

        for (TenxActivePlan sub in tenxAvailablePlans) {
          if (sub.validity != null) {
            if (sub.validity != 0 && uniqueValues.add(sub.validity!)) {
              result.add(PlanValidity(
                label: '${sub.validity} Days',
                validity: sub.validity!,
              ));
            }
          }
        }
        result.sort(
          (a, b) => a.validity!.compareTo(b.validity!),
        );
        result.insert(0, defaultSelectedValidity);
        if (result.length.isGreaterThan(1)) {
          tenxAvailableValidityList.clear();
          tenxAvailableValiditySelected(defaultSelectedValidity);
          tenxAvailableValidityList(result);
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

  Future getTenxSubscribedPlans() async {
    isSubscribeLoading(true);
    try {
      final RepoResponse<TenxSubscribedPlanListResponse> response =
          await repository.getTenxMyActiveSubscribed();
      if (response.data?.status?.toLowerCase() == "success") {
        tenxSubscribedPlans.clear();
        userSubscriptionsIds.clear();
        tenxSubscribedPlans(response.data?.data ?? []);
        tenxSubscribedPlansUnFiltered(response.data?.data ?? []);
        for (var userSub in userDetails.value.subscription!) {
          if (userSub.subscriptionId != null) {
            userSubscriptionsIds.add(userSub.subscriptionId!.id!);
          }
        }
        Set<int> uniqueValues = Set<int>();
        List<PlanValidity> result = [];

        for (TenxSubscribedPlan sub in tenxSubscribedPlans) {
          if (sub.validity != null) {
            if (sub.validity != 0 && uniqueValues.add(sub.validity!)) {
              result.add(PlanValidity(
                label: '${sub.validity} Days',
                validity: sub.validity!,
              ));
            }
          }
        }
        result.sort(
          (a, b) => a.validity!.compareTo(b.validity!),
        );
        result.insert(0, defaultSelectedValidity);
        if (result.length.isGreaterThan(1)) {
          tenxSubscribedValidityList.clear();
          tenxSubscribedValiditySelected(defaultSelectedValidity);
          tenxSubscribedValidityList(result);
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

  Future getTenxExpiredPlans() async {
    isExpiredLoading(true);
    try {
      final RepoResponse<TenxExpiredPlanListResponse> response =
          await repository.getTenxMyExpiredSubscription();
      if (response.data?.status?.toLowerCase() == "success") {
        tenxExpiredPlans.clear();
        userSubscriptionsIds.clear();
        tenxExpiredPlans(response.data?.data ?? []);
        tenxExpiredPlansUnFiltered(response.data?.data ?? []);
        for (var userSub in userDetails.value.subscription!) {
          if (userSub.subscriptionId != null) {
            userSubscriptionsIds.add(userSub.subscriptionId!.id!);
          }
        }
        Set<int> uniqueValues = Set<int>();
        List<PlanValidity> result = [];

        for (TenxExpiredPlan sub in tenxExpiredPlans) {
          if (sub.validity != null) {
            if (sub.validity != 0 && uniqueValues.add(sub.validity!)) {
              result.add(PlanValidity(
                label: '${sub.validity} Days',
                validity: sub.validity!,
              ));
            }
          }
        }
        result.sort(
          (a, b) => a.validity!.compareTo(b.validity!),
        );
        result.insert(0, defaultSelectedValidity);
        if (result.length.isGreaterThan(1)) {
          tenxExpiredValidityList.clear();
          tenxExpiredValiditySelected(defaultSelectedValidity);
          tenxExpiredValidityList(result);
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
      final RepoResponse<TenxLeaderboardListResponse> response =
          await repository.getTenxLeaderboard();
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

  Future tenxRenewSubscription(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final RepoResponse<GenericResponse> response =
          await repository.tenxRenewSubscription(
        data,
      );
      if (response.data?.status == "success") {
        SnackbarHelper.showSnackbar(
            response.data?.message ?? 'Subscription renewed successfully');
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

  Future<void> getTenxMyActiveSubscribedPNL(
      String? id, String? subscribeOn) async {
    isLoading(true);

    try {
      final RepoResponse<TenxSubscribedPlanPNLResponse> response =
          await repository.getTenxMyActiveSubscribedPNL(id, subscribeOn);

      if (response.data != null) {
        // Update the RxList using assignAll
        tenxSubscribedPlansPNLData(response.data?.data?[0]);
      }
    } catch (e) {
      log(e.toString());
      // SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

  Future getTenxTodayOrdersList() async {
    isOrderStateLoading(true);
    try {
      final RepoResponse<TenxTradeOrdersListResponse> response =
          await repository.getTenxTradeTodaysOrdersList(
        selectedSubscriptionId.value,
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxTradeTodaysOrdersList(response.data?.data ?? []);
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
        selectedSubscriptionId.value,
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
        selectedSubscriptionId.value,
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
      await getTenxTradingPortfolioDetails();
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
      symbol: inst.tradingsymbol,
      validity: "DAY",
      id: selectedSubscriptionId.value,
      lastPrice: inst.lastPrice.toString(),
      variety: "regular",
      from: "TenX Trader",
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
        await getTenxTodayOrdersList();
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
          getTenxPositionList();
          getStopLossPendingOrder();
          getStopLossExecutedOrder();
          getTenxTodayOrdersList();
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    isPendingOrderStateLoading(false);
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
}
