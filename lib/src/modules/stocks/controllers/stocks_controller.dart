import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stoxhero/src/modules/stocks/widget/stock_total_holding_details.dart';
import 'package:stoxhero/src/modules/stocks/widget/stock_total_position_details.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app.dart';

class StocksTradingBinding implements Bindings {
  @override
  void dependencies() => Get.put(StocksTradingController());
}

class StocksTradingController extends BaseController<StocksTradingRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isPendingOrderStateLoading = false.obs;
  bool get isPendingOrderStateLoadingStatus => isPendingOrderStateLoading.value;

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

  final isFundsStateLoading = false.obs;
  bool get isFundsStateLoadingStatus => isFundsStateLoading.value;

  final isExecutedOrderStateLoading = false.obs;
  bool get isExecutedOrderStateLoadingStatus =>
      isExecutedOrderStateLoading.value;

  final selectedStopProfitQuantity = 0.obs;
  final selectedStopLossQuantity = 0.obs;
  final stoplossQuantityList = <StoplossQuantityData>[].obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;

  final stockTotalPositionDetails = StockTotalPositionDetails().obs;
  final stockTotalHoldingDetails = StockTotalHoldingDetails().obs;

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
  final selectedProductGroupValue = 0.obs;

  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;
  final stopProfitPriceTextController = TextEditingController();
  final selectedStringQuantity = "0".obs;
  final limitPriceTextController = TextEditingController();
  final stopLossPriceTextController = TextEditingController();
  final selectedType = "".obs;

  final selectedQuantity = 0.obs;
  final stopLossQuantityTextController = TextEditingController();
  final quantityTextController = TextEditingController();
  final stopProfitQuantityTextController = TextEditingController();
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
  final watchlistEquityInstrumentSymbolList = <String>[].obs;
  final stockTradeTodaysOrdersList = <StockTodayTradeOrder>[].obs;
  final stockfundsmargin = StockFundsMargin().obs;
  final stocksStopLossExecutedOrdersList = <StocksExcuatedOrderData>[].obs;
  final stopLossPendingOrderList = <StocksPendingOrderData>[].obs;
  final stopLossPendingOrder = StocksPendingOrderData().obs;
  final stockslastTradePrice = TextEditingController();

  Future loadData() async {
    loadUserDetails();

    await getEquityInstrumentDetails();
    await getStockIndexInstrumentsList();
    await getStocksTradingPortfolio();
    await getStockPositionsList();
    await getStocksFundsMargin();
    await getStocksStopLossExecutedOrder();
    await getStocksStopLossPendingOrder();

    socketConnection();
    socketIndexConnection();
    socketSendConnection();
    //  await getStocksTradingInstruments();
  }

  Future loadUserDetails() async {
    userDetails.value = AppStorage.getUserDetails();
  }

  void socketConnectEquityWatchlist() {
    socketService.socket.emit('equity-watchlist');
  }

  void socketDisconnectEquityWatchlist() {
    socketService.socket.emit('leave-equity-watchlist');
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
          // print("hello${tradingInstrumentTradeDetailsList}");
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

  Future socketSendConnection() async {
    isPendingOrderStateLoading(true);
    try {
      socketService.socket.off('sendOrderResponse${userDetails.value.sId}');
      socketService.socket.on(
        'sendOrderResponse${userDetails.value.sId}',
        (data) {
          log('sendOrderResponse${userDetails.value.sId} $data');
          if (data.containsKey("message")) {
            String message = data["message"];
            SnackbarHelper.showSnackbar(message);
          }
          getStockPositionsList();
          getStocksStopLossPendingOrder();
          getStocksStopLossExecutedOrder();
          getStockTodayOrderList();
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    isPendingOrderStateLoading(false);
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
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}';
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
    // equityInstrumentDetailList.clear();
    try {
      final RepoResponse<EquityInstrumentDetailsResponse> response =
          await repository.getEquityInstrumentDetails({});
      if (response.data?.data != null) {
        equityInstrumentDetailList(response.data?.data ?? []);
        watchlistEquityInstrumentSymbolList.clear();
        for (EquityInstrumentDetail data in equityInstrumentDetailList) {
          if (data.symbol != null)
            watchlistEquityInstrumentSymbolList.add(
              data.symbol ?? "",
            );
        }
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
    try {
      await repository.removeInstrument(instToken ?? 0);
      selectedWatchlistIndex(-1);
      watchlistEquityInstrumentSymbolList.clear();
      // await getStockIndexInstrumentsList(); // await getVirtualTradingWatchlist();
      // await searchInstruments(searchTextController.text, showShimmer: false);
      SnackbarHelper.showSnackbar('Stock Remove');
      getEquityInstrumentDetails();
      await getStockTradingWatchlist();
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future getStopLossPendingCancelOrder(String? id) async {
    isPendingOrderStateLoading(true);
    try {
      await repository.getStopLossPendingCancelOrder(id ?? '');
      stopLossPendingOrderList([]);
      await getStocksStopLossPendingOrder();
      SnackbarHelper.showSnackbar('Order Cancelled');
      await getStocksStopLossExecutedOrder();
      await getStocksTradingPortfolio();
      await getStockPositionsList();
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
  }

  Future getStopLossEditOrder(String? id, String? type) async {
    print("typess${type}");
    isPendingOrderStateLoading(true);
    PendingEditOrderRequest data = PendingEditOrderRequest(
      executionPrice: type == "StopLoss"
          ? stopLossPriceTextController.text
          : (type == "StopProfit"
              ? stopProfitPriceTextController.text
              : (type == "Limit" ? limitPriceTextController.text : '0')),
    );
    // PendingEditOrderRequest data = PendingEditOrderRequest(
    //   executionPrice: limitPriceTextController.text,
    // );
    print("typein1012${data.toJson()}");
    try {
      final response = await repository.getStopLossEditOrder(
        id,
        data.toJson(),
      );
      Get.back();
      getStocksStopLossPendingOrder();
      if (response.data?.status?.toLowerCase() == "Success") {
        getStocksStopLossPendingOrder();
        stopLossPriceTextController.text = '';
        stopProfitPriceTextController.text = '';
        limitPriceTextController.text = '';
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
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
      stopProfitPrice: stopProfitPriceTextController.text,
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
        await getStockHoldingsList();
        // await getStopLossPendingOrder();
        await getStockTodayOrderList();
        await getStocksTradingPortfolio();
        await getStocksStopLossExecutedOrder();
        await getStocksStopLossPendingOrder();
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
      lastPrice: getInstrumentLastPrice(
        inst.instrumentToken!,
        inst.exchangeToken!,
      ).toString(),
    );

    try {
      final RepoResponse<StockMarginRequiredResponse> response =
          await repository.getMarginRequired(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          marginRequired(response.data);

          //     print('hii${data.toJson()}');
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
    selectedProductGroupValue.value = newValue;
    selectedType.value = labelText;
    // print("handleRadioValueChanged : $labelText");
  }

  void handleRadioProductChanged(int newValue, String labelText) {
    selectedOrderGroupValue.value = newValue;
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

// All Portfolio Summary Calculation

  //Open Positions For Holdings and Possitions

  int getOpenPositionCount() {
    int positionsOpenCount = 0;

    for (var position in stockPositionsList) {
      if (position.lots != null && position.lots != 0) {
        positionsOpenCount++;
      }
    }
    // print('count position${positionsOpenCount}');
    return positionsOpenCount;
  }

  int getOpenHoldingCount() {
    int holdingOpenCount = 0;

    for (var holding in stockHoldingsList) {
      if (holding.lots != null && holding.lots != 0) {
        holdingOpenCount++;
      }
    }
    // print('count holding${holdingOpenCount}');
    return holdingOpenCount;
  }

  num calculateHoldingTotalNetPNL() {
    num totalHoldingNetPNL = 0;
    for (var holding in stockHoldingsList) {
      if (holding.iId?.isLimit != true) {
        num avg = holding.amount ?? 0;
        int lots = holding.lots?.toInt() ?? 0;
        num ltp = getInstrumentLastPrice(
          holding.iId?.instrumentToken ?? 0,
          holding.iId?.exchangeInstrumentToken ?? 0,
        );
        if (ltp == 0) return 0;
        num value = (avg + (lots) * ltp);
        num brokerage = holding.brokerage ?? 0;
        num broker = value - brokerage;
        totalHoldingNetPNL += broker;
      }
    }
    return totalHoldingNetPNL.round();
  }

  num calculatePositionTotalNetPNL() {
    num totalPositionNetPNL = 0;
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
        totalPositionNetPNL += broker;
      }
    }
    return totalPositionNetPNL.round();
  }

  num calculateMargin() {
    num positionlots = 0;
    num holdinglots = 0;

    num positionmargin = 0;
    num holdingmargin = 0;

    num amountholding = 0;
    num amountposition = 0;

    num holdinglimitMargin = 0;
    num positionlimitMargin = 0;

    num positionsubtractAmount = 0;
    num holdingsubtractAmount = 0;

    for (var position in stockPositionsList) {
      if (position.lots != 0) {
        positionlots += position.lots ?? 0;
        positionmargin += position.margin ?? 0;
      }
      if (position.iId?.isLimit == true) {
        positionlimitMargin += position.margin ?? 0;
      } else {
        if (position.lots! < 0) {
          positionlimitMargin += position.margin ?? 0;
          positionsubtractAmount +=
              ((position.lots!) * (position.lastaverageprice ?? 0)).abs();
        }
        amountposition += ((position.amount ?? 0) - (position.brokerage ?? 0));
      }
    }

    for (var holding in stockHoldingsList) {
      if (holding.lots != 0) {
        holdinglots += holding.lots ?? 0;
        holdingmargin += holding.margin ?? 0;
      }
      if (holding.iId?.isLimit == true) {
        holdinglimitMargin += holding.margin ?? 0;
      } else {
        if (holding.lots! < 0) {
          holdinglimitMargin += holding.margin ?? 0;
          holdingsubtractAmount +=
              ((holding.lots!) * (holding.lastaverageprice ?? 0)).abs();
        }
        amountholding += ((holding.amount ?? 0) - (holding.brokerage ?? 0));
      }
    }

    //  print("hiii${stocksPortfolio.toJson()}");

    num openingBalance = 0;
    num totalFund = stocksPortfolio.value.totalFund ?? 0;

    if (stocksPortfolio.value.openingBalance != null) {
      openingBalance = stocksPortfolio.value.openingBalance ?? 0;
    } else {
      openingBalance = totalFund;
    }
    //available
    num availableMargin =
        ((calculatePositionTotalNetPNL() + calculateHoldingTotalNetPNL()) < 0)
            ? ((positionlots + holdinglots) == 0
                ? (openingBalance -
                    (holdingmargin + positionmargin) +
                    (calculatePositionTotalNetPNL() +
                        calculateHoldingTotalNetPNL()))
                : (openingBalance -
                    (((amountposition + amountholding) -
                                (positionsubtractAmount +
                                    holdingsubtractAmount))
                            .abs() +
                        (holdinglimitMargin + positionlimitMargin))))
            : (openingBalance - (holdingmargin + positionmargin));

    return availableMargin;
  }

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
  //position ka calc

  void calculateTotalPositionValues() {
    int totalLots = 0;
    num totalPositionBrokerage = 0;
    num totalGross = 0;
    num totalPositionInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    //num totalInvestedValue =0;

    for (var position in stockPositionsList) {
      if (position.iId?.isLimit ?? false) {
      } else {
        totalLots += position.lots ?? 0;
        totalPositionBrokerage += position.brokerage ?? 0;

        totalGross += getInstrumentLastPrice(
              position.iId!.instrumentToken!,
              position.iId!.exchangeInstrumentToken!,
            ).abs() ??
            0;
        // totalGross += getInstrumentLastPrice(position.iId.instrumentToken,
        //             position.iId.exchangeInstrumentToken)
        //         ?.abs() ??
        //     0;
        // totalHoldingInvested += holding.amount?.abs() ?? 0;
        totalCurrentValue += (getInstrumentLastPrice(
                  position.iId!.instrumentToken!,
                  position.iId!.exchangeInstrumentToken!,
                ).abs() ??
                0) *
            (position.lots?.abs() ?? 0);

        // totalPnl = (totalCurrentValue - totalNet);
        totalPnl += calculateGrossPNL(
          position.amount ?? 0,
          position.lots!.toInt(),
          getInstrumentLastPrice(
            position.iId!.instrumentToken!,
            position.iId!.exchangeInstrumentToken!,
          ),
        );
        if (position.lots != 0) {
          totalPositionInvested += position.amount?.abs() ?? 0;
        }

        // print('final${totalHoldingInvested}');

        if (position.lots != 0) {
          totalRoi = ((totalPnl * 100) / totalPositionInvested);
        } else {
          totalRoi = 0;
        }
      }
    }

    stockTotalPositionDetails(
      StockTotalPositionDetails(
        lots: totalLots,
        brokerage: totalPositionBrokerage,
        gross: totalGross,
        holdingnet: totalPositionInvested,
        currentvalue: totalCurrentValue,
        roi: totalRoi,
        pnl: totalPnl,
      ),
    );
    // print('positiontotal ${totalPositionInvested}');
  }

  // num calculateTotalPositionPnl() {
  //  num totalGross = 0;
  //  int totalLots = 0;
  //   num totalPositionBrokerage = 0;
  //   num totalPositionInvested = 0;
  //   num totalCurrentValue = 0;
  //   num totalRoi = 0;
  //   num totalPnl = 0;
  //   for (var position in stockPositionsList) {
  //     if (position.iId?.isLimit ?? false) {
  //     } else {
  //       totalLots += position.lots ?? 0;
  //       totalPositionBrokerage += position.brokerage ?? 0;

  //       totalGross += getInstrumentLastPrice(
  //             position.iId!.instrumentToken!,
  //             position.iId!.exchangeInstrumentToken!,
  //           ).abs() ??
  //           0;
  //       // totalGross += getInstrumentLastPrice(position.iId.instrumentToken,
  //       //             position.iId.exchangeInstrumentToken)
  //       //         ?.abs() ??
  //       //     0;
  //       // totalHoldingInvested += holding.amount?.abs() ?? 0;
  //       totalCurrentValue += (getInstrumentLastPrice(
  //                 position.iId!.instrumentToken!,
  //                 position.iId!.exchangeInstrumentToken!,
  //               ).abs() ??
  //               0) *
  //           (position.lots?.abs() ?? 0);

  //       // totalPnl = (totalCurrentValue - totalNet);
  //       totalPnl += calculateGrossPNL(
  //         position.amount ?? 0,
  //         position.lots!.toInt(),
  //         getInstrumentLastPrice(
  //           position.iId!.instrumentToken!,
  //           position.iId!.exchangeInstrumentToken!,
  //         ),
  //       );
  //       if (position.lots != 0) {
  //         totalPositionInvested += position.amount?.abs() ?? 0;
  //       }

  //       // print('final${totalHoldingInvested}');

  //       if (position.lots != 0) {
  //         totalRoi = ((totalPnl * 100) / totalPositionInvested);
  //       } else {
  //         totalRoi = 0;
  //       }
  //     }
  //   }

  //  num final = FormatHelper.formatNumbers(
  //                       totalPnl.round().toString(),
  //                       decimal: 2,
  //                     );
  //  // return totalPnl.round();
  //  return final;
  //   // for (var position in virtualPositionsList) {
  //   //   if (position.id?.isLimit != true) {
  //   //     num avg = position.amount ?? 0;
  //   //     int lots = position.lots?.toInt() ?? 0;
  //   //     num ltp = getInstrumentLastPrice(
  //   //       position.id?.instrumentToken ?? 0,
  //   //       position.id?.exchangeInstrumentToken ?? 0,
  //   //     );
  //   //     if (ltp == 0) return 0;
  //   //     num value = (avg + (lots) * ltp);
  //   //     num brokerage = position.brokerage ?? 0;
  //   //     num broker = value - brokerage;
  //   //     totalNetPNL += broker;
  //   //   }
  //   // }
  //   // return totalNetPNL.round();
  // }

  String calculateTotalPositionPnl() {
    num totalGross = 0;
    int totalLots = 0;
    num totalPositionBrokerage = 0;
    num totalPositionInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    for (var position in stockPositionsList) {
      if (position.iId?.isLimit ?? false) {
        continue; // Skip to the next iteration if it is a limit.
      }

      totalLots += position.lots ?? 0;
      totalPositionBrokerage += position.brokerage ?? 0;

      num lastPrice = getInstrumentLastPrice(
            position.iId!.instrumentToken!,
            position.iId!.exchangeInstrumentToken!,
          ).abs() ??
          0;

      totalGross += lastPrice;

      totalCurrentValue += lastPrice * (position.lots?.abs() ?? 0);

      totalPnl += calculateGrossPNL(
        position.amount ?? 0,
        position.lots!.toInt(),
        lastPrice,
      );

      if (position.lots != 0) {
        totalPositionInvested += position.amount?.abs() ?? 0;
        totalRoi = (totalPnl * 100) / totalPositionInvested;
      } else {
        totalRoi = 0;
      }
    }

    String finalTotalPnl = FormatHelper.formatNumbers(
      totalPnl.toString(),
      decimal: 2,
    );

    return finalTotalPnl;
  }

  String calculateTotalPositionroi() {
    num totalGross = 0;
    int totalLots = 0;
    num totalPositionBrokerage = 0;
    num totalPositionInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    for (var position in stockPositionsList) {
      if (position.iId?.isLimit ?? false) {
        continue; // Skip to the next iteration if it is a limit.
      }

      totalLots += position.lots ?? 0;
      totalPositionBrokerage += position.brokerage ?? 0;

      num lastPrice = getInstrumentLastPrice(
            position.iId!.instrumentToken!,
            position.iId!.exchangeInstrumentToken!,
          ).abs() ??
          0;

      totalGross += lastPrice;

      totalCurrentValue += lastPrice * (position.lots?.abs() ?? 0);

      totalPnl += calculateGrossPNL(
        position.amount ?? 0,
        position.lots!.toInt(),
        lastPrice,
      );

      if (position.lots != 0) {
        totalPositionInvested += position.amount?.abs() ?? 0;
        totalRoi = (totalPnl * 100) / totalPositionInvested;
      } else {
        totalRoi = 0;
      }
    }

    String finalTotalroiPositions = FormatHelper.formatNumbers(
      totalRoi.toString(),
      decimal: 2,
    );

    return finalTotalroiPositions;
  }

  String calculateTotalPositionInvested() {
    num totalGross = 0;
    int totalLots = 0;
    num totalPositionBrokerage = 0;
    num totalPositionInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    for (var position in stockPositionsList) {
      if (position.iId?.isLimit ?? false) {
        continue; // Skip to the next iteration if it is a limit.
      }

      totalLots += position.lots ?? 0;
      totalPositionBrokerage += position.brokerage ?? 0;

      num lastPrice = getInstrumentLastPrice(
            position.iId!.instrumentToken!,
            position.iId!.exchangeInstrumentToken!,
          ).abs() ??
          0;

      totalGross += lastPrice;

      totalCurrentValue += lastPrice * (position.lots?.abs() ?? 0);

      totalPnl += calculateGrossPNL(
        position.amount ?? 0,
        position.lots!.toInt(),
        lastPrice,
      );

      if (position.lots != 0) {
        totalPositionInvested += position.amount?.abs() ?? 0;
        totalRoi = (totalPnl * 100) / totalPositionInvested;
      } else {
        totalRoi = 0;
      }
    }

    String finalTotalInvestedPositions = FormatHelper.formatNumbers(
      totalPositionInvested.toString(),
      decimal: 2,
    );

    return finalTotalInvestedPositions;
  }

  String calculateTotalPositionCurrentValue() {
    num totalGross = 0;
    int totalLots = 0;
    num totalPositionBrokerage = 0;
    num totalPositionInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    for (var position in stockPositionsList) {
      if (position.iId?.isLimit ?? false) {
        continue; // Skip to the next iteration if it is a limit.
      }

      totalLots += position.lots ?? 0;
      totalPositionBrokerage += position.brokerage ?? 0;

      num lastPrice = getInstrumentLastPrice(
            position.iId!.instrumentToken!,
            position.iId!.exchangeInstrumentToken!,
          ).abs() ??
          0;

      totalGross += lastPrice;

      totalCurrentValue += lastPrice * (position.lots?.abs() ?? 0);

      totalPnl += calculateGrossPNL(
        position.amount ?? 0,
        position.lots!.toInt(),
        lastPrice,
      );

      if (position.lots != 0) {
        totalPositionInvested += position.amount?.abs() ?? 0;
        totalRoi = (totalPnl * 100) / totalPositionInvested;
      } else {
        totalRoi = 0;
      }
    }

    String finalTotalCurrentValuePositions = FormatHelper.formatNumbers(
      totalCurrentValue.toString(),
      decimal: 2,
    );

    return finalTotalCurrentValuePositions;
  }

//live price for holdings ka

  String calculateTotalHoldingPnl() {
    int totalLots = 0;
    num totalHoldingBrokerage = 0;
    num totalGross = 0;
    num totalHoldingInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    //num totalInvestedValue =0;

    for (var holding in stockHoldingsList) {
      if (holding.iId?.isLimit ?? false) {
      } else {
        totalLots += holding.lots ?? 0;
        totalHoldingBrokerage += holding.brokerage ?? 0;
        totalGross += getInstrumentLastPrice(
              holding.iId!.instrumentToken!,
              holding.iId!.exchangeInstrumentToken!,
            ).abs() ??
            0;
        // totalHoldingInvested += holding.amount?.abs() ?? 0;
        totalCurrentValue += (getInstrumentLastPrice(
                  holding.iId!.instrumentToken!,
                  holding.iId!.exchangeInstrumentToken!,
                ).abs() ??
                0) *
            (holding.lots?.abs() ?? 0);

        // totalPnl = (totalCurrentValue - totalNet);
        totalPnl += calculateGrossPNL(
          holding.amount ?? 0,
          holding.lots!.toInt(),
          getInstrumentLastPrice(
            holding.iId!.instrumentToken!,
            holding.iId!.exchangeInstrumentToken!,
          ),
        );

        if (holding.lots != 0) {
          totalHoldingInvested += holding.amount?.abs() ?? 0;
        }
        if (holding.lots != 0) {
          totalRoi = ((totalPnl * 100) / totalHoldingInvested);
        } else {
          totalRoi = 0;
        }
      }
    }
    //print('holdingtotal${totalHoldingInvested}');
    String finalTotalPnl = FormatHelper.formatNumbers(
      totalPnl.toString(),
      decimal: 2,
    );
    return finalTotalPnl;
  }

  String calculateTotalHoldingroi() {
    int totalLots = 0;
    num totalHoldingBrokerage = 0;
    num totalGross = 0;
    num totalHoldingInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    //num totalInvestedValue =0;

    for (var holding in stockHoldingsList) {
      if (holding.iId?.isLimit ?? false) {
      } else {
        totalLots += holding.lots ?? 0;
        totalHoldingBrokerage += holding.brokerage ?? 0;
        totalGross += getInstrumentLastPrice(
              holding.iId!.instrumentToken!,
              holding.iId!.exchangeInstrumentToken!,
            ).abs() ??
            0;
        // totalHoldingInvested += holding.amount?.abs() ?? 0;
        totalCurrentValue += (getInstrumentLastPrice(
                  holding.iId!.instrumentToken!,
                  holding.iId!.exchangeInstrumentToken!,
                ).abs() ??
                0) *
            (holding.lots?.abs() ?? 0);

        // totalPnl = (totalCurrentValue - totalNet);
        totalPnl += calculateGrossPNL(
          holding.amount ?? 0,
          holding.lots!.toInt(),
          getInstrumentLastPrice(
            holding.iId!.instrumentToken!,
            holding.iId!.exchangeInstrumentToken!,
          ),
        );

        if (holding.lots != 0) {
          totalHoldingInvested += holding.amount?.abs() ?? 0;
        }
        if (holding.lots != 0) {
          totalRoi = ((totalPnl * 100) / totalHoldingInvested);
        } else {
          totalRoi = 0;
        }
      }
    }
    //print('holdingtotal${totalHoldingInvested}');
    String finalTotalroiHoldings = FormatHelper.formatNumbers(
      totalRoi.toString(),
      decimal: 2,
    );

    return finalTotalroiHoldings;
  }

  String calculateTotalHoldingInvested() {
    int totalLots = 0;
    num totalHoldingBrokerage = 0;
    num totalGross = 0;
    num totalHoldingInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    //num totalInvestedValue =0;

    for (var holding in stockHoldingsList) {
      if (holding.iId?.isLimit ?? false) {
      } else {
        totalLots += holding.lots ?? 0;
        totalHoldingBrokerage += holding.brokerage ?? 0;
        totalGross += getInstrumentLastPrice(
              holding.iId!.instrumentToken!,
              holding.iId!.exchangeInstrumentToken!,
            ).abs() ??
            0;
        // totalHoldingInvested += holding.amount?.abs() ?? 0;
        totalCurrentValue += (getInstrumentLastPrice(
                  holding.iId!.instrumentToken!,
                  holding.iId!.exchangeInstrumentToken!,
                ).abs() ??
                0) *
            (holding.lots?.abs() ?? 0);

        // totalPnl = (totalCurrentValue - totalNet);
        totalPnl += calculateGrossPNL(
          holding.amount ?? 0,
          holding.lots!.toInt(),
          getInstrumentLastPrice(
            holding.iId!.instrumentToken!,
            holding.iId!.exchangeInstrumentToken!,
          ),
        );

        if (holding.lots != 0) {
          totalHoldingInvested += holding.amount?.abs() ?? 0;
        }
        if (holding.lots != 0) {
          totalRoi = ((totalPnl * 100) / totalHoldingInvested);
        } else {
          totalRoi = 0;
        }
      }
    }
    //print('holdingtotal${totalHoldingInvested}');
    String finalTotalInvestedHoldings = FormatHelper.formatNumbers(
      totalHoldingInvested.toString(),
      decimal: 2,
    );

    return finalTotalInvestedHoldings;
  }

  String calculateTotalHoldingCurrentValue() {
    int totalLots = 0;
    num totalHoldingBrokerage = 0;
    num totalGross = 0;
    num totalHoldingInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    //num totalInvestedValue =0;

    for (var holding in stockHoldingsList) {
      if (holding.iId?.isLimit ?? false) {
      } else {
        totalLots += holding.lots ?? 0;
        totalHoldingBrokerage += holding.brokerage ?? 0;
        totalGross += getInstrumentLastPrice(
              holding.iId!.instrumentToken!,
              holding.iId!.exchangeInstrumentToken!,
            ).abs() ??
            0;
        // totalHoldingInvested += holding.amount?.abs() ?? 0;
        totalCurrentValue += (getInstrumentLastPrice(
                  holding.iId!.instrumentToken!,
                  holding.iId!.exchangeInstrumentToken!,
                ).abs() ??
                0) *
            (holding.lots?.abs() ?? 0);

        // totalPnl = (totalCurrentValue - totalNet);
        totalPnl += calculateGrossPNL(
          holding.amount ?? 0,
          holding.lots!.toInt(),
          getInstrumentLastPrice(
            holding.iId!.instrumentToken!,
            holding.iId!.exchangeInstrumentToken!,
          ),
        );

        if (holding.lots != 0) {
          totalHoldingInvested += holding.amount?.abs() ?? 0;
        }
        if (holding.lots != 0) {
          totalRoi = ((totalPnl * 100) / totalHoldingInvested);
        } else {
          totalRoi = 0;
        }
      }
    }
    //print('holdingtotal${totalHoldingInvested}');
    String finalTotalCurrentValueHoldings = FormatHelper.formatNumbers(
      totalCurrentValue,
      decimal: 2,
    );

    return finalTotalCurrentValueHoldings;
  }

//Holdings ka pura scene

  Future getStockHoldingsList() async {
    isHoldingStateLoading(true);
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
    num totalHoldingBrokerage = 0;
    num totalGross = 0;
    num totalHoldingInvested = 0;
    num totalCurrentValue = 0;
    num totalRoi = 0;
    num totalPnl = 0;

    //num totalInvestedValue =0;

    for (var holding in stockHoldingsList) {
      if (holding.iId?.isLimit ?? false) {
      } else {
        totalLots += holding.lots ?? 0;
        totalHoldingBrokerage += holding.brokerage ?? 0;
        totalGross += getInstrumentLastPrice(
              holding.iId!.instrumentToken!,
              holding.iId!.exchangeInstrumentToken!,
            ).abs() ??
            0;
        // totalHoldingInvested += holding.amount?.abs() ?? 0;
        totalCurrentValue += (getInstrumentLastPrice(
                  holding.iId!.instrumentToken!,
                  holding.iId!.exchangeInstrumentToken!,
                ).abs() ??
                0) *
            (holding.lots?.abs() ?? 0);

        // totalPnl = (totalCurrentValue - totalNet);
        totalPnl += calculateGrossPNL(
          holding.amount ?? 0,
          holding.lots!.toInt(),
          getInstrumentLastPrice(
            holding.iId!.instrumentToken!,
            holding.iId!.exchangeInstrumentToken!,
          ),
        );

        if (holding.lots != 0) {
          totalHoldingInvested += holding.amount?.abs() ?? 0;
        }
        if (holding.lots != 0) {
          totalRoi = ((totalPnl * 100) / totalHoldingInvested);
        } else {
          totalRoi = 0;
        }
      }
    }
    //print('holdingtotal${totalHoldingInvested}');
    stockTotalHoldingDetails(
      StockTotalHoldingDetails(
        lots: totalLots,
        brokerage: totalHoldingBrokerage,
        gross: totalGross,
        net: totalHoldingInvested,
        currentvalue: totalCurrentValue,
        roi: totalRoi,
        pnl: totalPnl,
      ),
    );
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
    num value = (((lots.abs()) * ltp.abs()) - avg.abs());
    pnl += value;
    return pnl;
  }

  num calculateGrossROI(num avg, int lots, num ltp) {
    if (ltp == 0) return 0;
    num pnl = 0;
    num value = (lots * ltp) - avg.abs();

    pnl += value;

    num roi = (pnl / avg.abs()) * 100;

    return roi;
  }

  List<int> generateLotsList({String? type}) {
    List<int> result = [];

    selectedQuantity.value = result[0];
    lotsValueList.assignAll(result);
    return result;
  }

  Future getStocksStopLossExecutedOrder() async {
    isExecutedOrderStateLoading(true);
    try {
      final RepoResponse<StocksExcuatedOrderResponse> response =
          await repository.getStocksStopLossExcuatedOrder(
        stockfundsmargin.value.portfolioId.toString(),
      );
      if (response.data?.status?.toLowerCase() == "success") {
        stocksStopLossExecutedOrdersList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
      print('hiii${stockfundsmargin.toJson()}');
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isExecutedOrderStateLoading(false);
  }

  Future getStocksStopLossPendingOrder() async {
    isPendingOrderStateLoading(true);
    try {
      final RepoResponse<StocksPendingOrderResponse> response =
          await repository.getStocksStopLossPendingOrder(
        stockfundsmargin.value.portfolioId.toString(),
      );
      // print('harshit${stockfundsmargin.value.portfolioId}');
      if (response.data?.status?.toLowerCase() == "success") {
        List<StocksPendingOrderData>? tempList = [];
        tempList = response.data?.data
            ?.where((order) => (order.quantity != null && order.quantity! > 0))
            .toList();
        stopLossPendingOrderList(tempList);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
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
    StockPendingOrderModifyRequest data = StockPendingOrderModifyRequest(
      exchange: inst.exchange,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      // quantity: selectedQuantity.value,
      product: selectedOrderGroupValue.value == 1 ? "CNC" : "MIS",
      orderType: selectedType.value,
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      stopLossPrice: stopLossPriceTextController.text,
      stopProfitPrice: stopProfitPriceTextController.text,
      stopLossQuantity: selectedStopLossQuantity.value,
      stopProfitQuantity: selectedStopProfitQuantity.value,
      symbol: inst.tradingsymbol,
      validity: "DAY",

      id: stockfundsmargin.value
          .portfolioId, //  id: virtualPortfolio.value.portfolioId(in virtual)
      lastPrice: inst.lastPrice.toString(),
      variety: "regular",
      stock: "Stock",
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
      print("type in991 ${response.data.toString()}");

      if (response.data?.status == "Success") {
        SnackbarHelper.showSnackbar(response.data?.message);
        await getStocksStopLossPendingOrder();
        await getStockTodayOrderList();
        selectedStringQuantity("");

        print(
            "typein1001 ${limitPriceTextController.text} ${stopProfitPriceTextController.text} ${stopLossPriceTextController.text}");
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

  Future getStocksFundsMargin() async {
    isFundsStateLoading(true);
    try {
      final RepoResponse<StocksFundsMarginResponse> response =
          await repository.getStockFundsMargin();

      if (response.data != null) {
        stockfundsmargin(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log("port ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isFundsStateLoading(false);
  }
}
