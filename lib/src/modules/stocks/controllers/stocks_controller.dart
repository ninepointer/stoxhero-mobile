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

  final isOrderStateLoading = false.obs;
  bool get isOrderStateLoadingStatus => isOrderStateLoading.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final readSetting = ReadSettingResponse().obs;

  final isWatchlistStateLoading = false.obs;
  bool get isWatchlistStateLoadingStatus => isWatchlistStateLoading.value;

  final isTradingOrderSheetLoading = false.obs;
  bool get isTradingOrderSheetLoadingStatus => isTradingOrderSheetLoading.value;

  final isMarginStateLoading = false.obs;
  bool get isMarginStateLoadingStatus => isMarginStateLoading.value;

  final isPortfolioStateLoading = false.obs;
  bool get isPortfolioStateLoadingStatus => isPortfolioStateLoading.value;

  final isPositionStateLoading = false.obs;
  bool get isPositionStateLoadingStatus => isHoldingStateLoading.value;

  final isHoldingStateLoading = false.obs;
  bool get isHoldingStateLoadingStatus => isHoldingStateLoading.value;

  final selectedStopProfitQuantity = 0.obs;
  final selectedStopLossQuantity = 0.obs;
  final stoplossQuantityList = <StoplossQuantityData>[].obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final marginRequired = StockMarginRequiredResponse().obs;
  final stocksPortfolio = StocksTradingPortfolio().obs;

  final stockHoldingsList = <StockTradingHolding>[].obs;
  final stockHolding = StockTradingHolding().obs;

  final stockPositionsList = <StockTradingPosition>[].obs;
  final stockPosition = StockTradingPosition().obs;

  final lotsValueList = <int>[0].obs;
  final stopLossFormKey = GlobalKey<FormState>();
  final selectedGroupValue = 0.obs;
  final selectedOrderGroupValue = 0.obs;

  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;
  final stopProfitPriceTextController = TextEditingController();
  final selectedStringQuantity = "0".obs;
  final limitPriceTextController = TextEditingController();
  final stopLossPriceTextController = TextEditingController();
  final selectedType = "".obs;
  final productType = "".obs;
  final selectedQuantity = 0.obs;
  final quanitityTextController = TextEditingController();
  final selectedWatchlistIndex = RxInt(-1);
  final tradingInstruments = <StockWatchlistSearchData>[].obs;
  final searchTextController = TextEditingController();
  final selectedWatchlistStock = StockWatchlistSearchData().obs;
  final isSearchCleared = false.obs;
  final tradingInstrumentTradeDetailsList = <TradingInstrumentTradeDetails>[]
      .obs; //Stores the data items from socket event equity ticks
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;
  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final equityInstrumentDetailList = <EquityInstrumentDetail>[].obs;
  final stockTradeTodaysOrdersList = <StockTodayTradeOrder>[].obs;

  Future loadData() async {
    loadUserDetails();
    socketConnection();
    socketIndexConnection();

    getEquityInstrumentDetails();
    getStockIndexInstrumentsList();
    getStocksTradingPortfolio();
    getStockPositionsList();
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
          print("hello${tradingInstrumentTradeDetailsList}");
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

  Future getStockTradingWatchlist() async {
    isWatchlistStateLoading(true);
    try {
      final RepoResponse<EquityInstrumentDetailsResponse> response =
          await repository.getEquityInstrumentDetails({});
      if (response.data != null) {
        if (response.data?.data! != null) {
          tradingWatchlistIds.clear();
          //  tradingWatchlist(response.data?.data ?? []);
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
      log("watch ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future addInstrument(StockWatchlistSearchData stock) async {
    isWatchlistStateLoading(true);
    AddStockWathclistRequest data = AddStockWathclistRequest(
        exchangeInstrumentToken: stock.exchangeToken,
        exchange: stock.exchange,
        symbol: stock.tradingsymbol,
        status: stock.status,
        instrumentToken: stock.instrumentToken,
        accountType: stock.accountType,
        name: stock.name);

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

  Future removeInstrument(int? instToken) async {
    isWatchlistStateLoading(true);
    try {
      await repository.removeInstrument(instToken ?? 0);
      selectedWatchlistIndex(-1);
      //  await getStockIndexInstrumentsList(); // await getVirtualTradingWatchlist();
      // await searchInstruments(searchTextController.text, showShimmer: false);
      SnackbarHelper.showSnackbar('Stock Remove');
      getEquityInstrumentDetails();
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future placeStocksTradingOrder(
      TransactionType type, TradingInstrument inst) async {
    isTradingOrderSheetLoading(true);
    print("typein584${type} ${selectedStringQuantity.value}");
    if (selectedType.value == "MARKET") {
      stopLossPriceTextController.text = '';
      stopProfitPriceTextController.text = '';
      limitPriceTextController.text = '';
    }
    if (type == TransactionType.exit) {
      stopLossPriceTextController.text = '';
      stopProfitPriceTextController.text = '';
      limitPriceTextController.text = '';
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
    //  print("typein600${type} ${selectedStringQuantity.value}");
    //  print(
    //      "typein601${limitPriceTextController.text} ${stopProfitPriceTextController.text} ${stopLossPriceTextController.text}");

    StockPlaceOrderRequest data = StockPlaceOrderRequest(
      product: selectedOrderGroupValue.value == 1 ? "CNC" : "MIS",
      quantity: selectedQuantity.value,
      triggerPrice: "",
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      exchange: inst.exchange,
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      orderType: selectedType.value,
      price: double.tryParse(limitPriceTextController.text) ?? 0,
      stopLoss: "",
      stopLossPrice: stopLossPriceTextController.text,

      symbol: inst.tradingsymbol,
      validity: "DAY",
      variety: "regular",

      // uId: Uuid().v4(),
      //  stopProfitPrice: stopProfitPriceTextController.text,

      // createdBy: userDetailsData.name,
      // userId: userDetailsData.email,
      // trader: userDetailsData.sId,
      // orderId: Uuid().v4(),
      // paperTrade: true,

      // deviceDetails: DeviceDetails(
      //   deviceType: 'Mobile',
      //   platformType: Platform.isAndroid ? 'Android' : 'iOS',
      // ),
    );
    log('typein628 : ${data.toJson()} ${type}');
    try {
      final RepoResponse<GenericResponse> response =
          await repository.stockPlaceOrder(
        data.toJson(),
      );
      print("harsh${response.data}");
      Get.back();

      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successful');
        await getStockPositionsList();
        // await getStopLossPendingOrder();
        // await getVirtualTodayOrderList();
        await getStocksTradingPortfolio();
        selectedStringQuantity("");
        stopLossPriceTextController.text = '';
        stopProfitPriceTextController.text = '';
        limitPriceTextController.text = '';
        // print(
        //     "typein652${limitPriceTextController.text} ${stopProfitPriceTextController.text} ${stopLossPriceTextController.text}");
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
      final RepoResponse<StockMarginRequiredResponse> response =
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

  int calculateQuantity(type, int tradingLots, int selectQuantity) {
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

  void handleRadioValueChanged(int newValue, String labelText) {
    selectedOrderGroupValue.value = newValue;
    selectedType.value = labelText;
  }

  void handleRadioProductChanged(int newValue, String labelText) {
    selectedOrderGroupValue.value = newValue;
    productType.value = labelText;
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

  Future getStocksTradingPortfolio() async {
    isPortfolioStateLoading(true);
    try {
      final RepoResponse<StocksTradingPortfolioResponse> response =
          await repository.getStocksTradingPortfolio();
      if (response.data != null) {
        stocksPortfolio(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log("port ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPortfolioStateLoading(false);
  }

  num calculateTotalNetPNL() {
    num totalNetPNL = 0;
    for (var position in stockPositionsList) {
      if (position.iId?.isLimit != true) {
        num avg = position.amount ?? 0;
        int lots = position.lots?.toInt() ?? 0;
        num ltp = getInstrumentLastPrice(
          position.iId?.instrumentToken ?? 0,
          position.iId?.exchangeInstrumentToken ?? 0,
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
    num subtractAmount = 0;
    for (var position in stockPositionsList) {
      if (position.lots != 0) {
        lots += position.lots ?? 0;
        margin += position.margin ?? 0;
      }
      if (position.iId?.isLimit == true) {
        limitMargin += position.margin ?? 0;
      } else {
        if (position.lots! < 0) {
          limitMargin += position.margin ?? 0;
          subtractAmount +=
              ((position.lots!) * (position.lastaverageprice ?? 0)).abs();
        }
        amount += ((position.amount ?? 0) - (position.brokerage ?? 0));
      }
    }
    num openingBalance = 0;
    //  print("hiii${stocksPortfolio.toJson()}");
    num totalFund = stocksPortfolio.value.totalFund ?? 0;

    if (stocksPortfolio.value.openingBalance != null) {
      openingBalance = stocksPortfolio.value.openingBalance ?? 0;
    } else {
      openingBalance = totalFund;
    }

    num availableMargin = (calculateTotalNetPNL() < 0)
        ? (lots == 0
            ? (openingBalance - margin + calculateTotalNetPNL())
            : (openingBalance -
                ((amount - subtractAmount).abs() + limitMargin)))
        : (openingBalance - margin);

    return availableMargin;
  }
  //positions ka pura scene

  Future getStockPositionsList() async {
    isPositionStateLoading(true);
    try {
      final RepoResponse<StocksPositionsListResponse> response =
          await repository.getstocksPositions();
      if (response.data != null) {
        if (response.data?.data! != null) {
          stockPositionsList(response.data?.data ?? []);
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

  void calculateTotalPositionValues() {
    int totalLots = 0;
    num totalBrokerage = 0;
    num totalGross = 0;
    num totalNet = 0;
    for (var position in stockPositionsList) {
      if (position.iId?.isLimit ?? false) {
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

//Holdings ka pura scene

  Future getStockHoldingsList() async {
    isPositionStateLoading(true);
    try {
      final RepoResponse<StocksHoldingsListResponse> response =
          await repository.getstocksHoldings();
      if (response.data != null) {
        if (response.data?.data! != null) {
          stockHoldingsList(response.data?.data ?? []);
          calculateTotalHoldingValues();
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isHoldingStateLoading(false);
  }

  void calculateTotalHoldingValues() {
    int totalLots = 0;
    num totalBrokerage = 0;
    num totalGross = 0;
    num totalNet = 0;
    for (var holding in stockHoldingsList) {
      if (holding.iId?.isLimit ?? false) {
      } else {
        totalLots += holding.lots ?? 0;
        totalBrokerage += holding.brokerage ?? 0;
        totalGross += holding.lastaverageprice ?? 0;
        totalNet += holding.amount ?? 0;
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
   // print("kind${tenxTotalPositionDetails.value.toJson()}");
  }

  Future getVirtualPendingStoplossOrderData(String id) async {
    try {
      final RepoResponse<VirtualStopLossPendingOrderResponse> response =
          await repository
              .getVirtualStopLossPendingOrder("6433e2e5500dc2f2d20d686d");
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
      print("stoplossQuantityList${e}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future getStockTodayOrderList() async {
    isOrderStateLoading(true);
    try {
      final RepoResponse<StocksTodayOrderResponse> response =
          await repository.getStockTradeTodaysOrdersList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          stockTradeTodaysOrdersList(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isOrderStateLoading(false);
  }

  num calculateGrossPNL(num avg, int lots, num ltp) {
    if (ltp == 0) return 0;
    num pnl = 0;
    num value = (avg + (lots) * ltp);
    pnl += value;
    return pnl;
  }

  num calculateGrossROI(num avg, int lots, num ltp) {
    if (ltp == 0) return 0;
    num pnl = 0;
    num value = (avg + (lots) * ltp);
    pnl += value;

    num roi = (pnl / avg.abs()) * 100;

    return roi;
  }
}
