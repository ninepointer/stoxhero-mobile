import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';
import '../../../app/app.dart';

class InternshipBinding implements Bindings {
  @override
  void dependencies() => Get.put(InternshipController());
}

class InternshipController extends BaseController<InternshipRespository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final searchTextController = TextEditingController();
  final startDateTextController = TextEditingController();
  final endDateTextController = TextEditingController();
  final internshipAnalytics = <AnalyticsOverviewDetails>[].obs;
  final internshipOverview = AnalyticsOverviewDetails().obs;
  final internshipDateWisePnlList = <AnalyticsDateWiseDetails>[].obs;
  final internshipMonthlyPnlList = <AnalyticsMonthlyPnLOverviewDetails>[].obs;
  final internshipBatchDetails = InternshipBatch().obs;
  final internshipBatchPortfolio = InternshipBatchPortfolio().obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final internshipPositionList = <InternshipPosition>[].obs;
  final tenxInstrumentTradeDetailsList = <TenxTradingInstrumentTradeDetails>[].obs;
  final tradingInstruments = <TradingInstrument>[].obs;
  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;

  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final selectedWatchlistIndex = RxInt(-1);
  final selectedQuantity = 0.obs;
  final lotsValueList = <int>[0].obs;

  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;

  final rangeGrossAmount = 0.0.obs;
  final rangeNetAmount = 0.0.obs;
  final rangeBrokerageAmount = 0.0.obs;
  final rangeTotalOrders = 0.obs;
  final rangeTotalTradingDays = 0.obs;
  final rangeTotalGreenDays = 0.obs;
  final rangeTotalRedDays = 0.obs;

  Future loadUserData() async {
    await getInternshipBatchDetails();
    await getInternshipBatchPortfolioDetails();
  }

  Future loadData() async {
    userDetails(AppStorage.getUserDetails());
    String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
    startDateTextController.text = date;
    endDateTextController.text = date;
    await getInternshipAnalyticsOverview();
    await getInternshipAnalyticsDateWisePnLOverviewDetails();
    await getInternshipAnalyticsMonthlyPnLOverviewDetails();
  }

  Future loadTradingData() async {
    userDetails(AppStorage.getUserDetails());
    await socketConnection();
    await socketIndexConnection();
    await getInternshipWatchlist();
    await getInternshipPositions();

    await getStockIndexInstrumentsList();
    await getInternshipBatchPortfolioDetails();
  }

  String getStockIndexName(int instId) {
    int index = stockIndexInstrumentList.indexWhere((element) => element.instrumentToken == instId);
    return stockIndexInstrumentList[index].displayName ?? '-';
  }

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.internshipSearchSymbol);
  }

  void showDateRangePicker(BuildContext context, {bool isStartDate = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      String date = DateFormat("dd-MM-yyyy").format(pickedDate);
      isStartDate ? startDateTextController.text = date : endDateTextController.text = date;
    }
  }

  void rangeCalculation() {
    rangeGrossAmount(0.0);
    rangeNetAmount(0.0);
    rangeBrokerageAmount(0.0);
    rangeTotalOrders(0);
    rangeTotalTradingDays(0);
    rangeTotalGreenDays(0);
    rangeTotalRedDays(0);

    var dataList = internshipDateWisePnlList;

    dataList.forEach((data) {
      rangeTotalTradingDays(dataList.length);
      rangeGrossAmount.value += data.gpnl ?? 0;
      rangeNetAmount.value += data.npnl ?? 0;
      rangeBrokerageAmount.value += data.brokerage ?? 0;
      rangeTotalOrders.value += data.noOfTrade ?? 0;
      if (data.npnl != null) {
        data.npnl! >= 0 ? rangeTotalGreenDays.value++ : rangeTotalRedDays.value++;
      }
    });
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<AnalyticsDateWiseDetails> dataList = internshipDateWisePnlList;

    var date = DateFormat("dd MMM").format(
      DateFormat('yyyy-MM-dd').parse(dataList[value.toInt() - 1].date!),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 55,
      child: Text(
        date,
        style: AppStyles.tsGreyRegular10,
      ),
    );
  }

  Widget bottomTitlesMonthly(double value, TitleMeta meta) {
    var date = DateFormat("yyyy-MM-dd").parse(
      internshipMonthlyPnlList[value.toInt()].date!,
    );
    var formattedDate = DateFormat("dd MMM").format(date);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 55,
      child: Text(
        formattedDate,
        style: AppStyles.tsGreyRegular10,
      ),
    );
  }

  List<BarChartGroupData> getGrossChartsData({
    required Color barColor,
  }) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsDateWiseDetails> dataList = internshipDateWisePnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barsSpace: 8,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.gpnl?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<BarChartGroupData> getNetChartsData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsDateWiseDetails> dataList = internshipDateWisePnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.npnl?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<BarChartGroupData> getBrokerageChartsData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsDateWiseDetails> dataList = internshipDateWisePnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.brokerage?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<BarChartGroupData> getOrdersChartsData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsDateWiseDetails> dataList = internshipDateWisePnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.noOfTrade?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<BarChartGroupData> getMonthlyGrossPNLChartsData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsMonthlyPnLOverviewDetails> dataList = internshipMonthlyPnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.gpnl?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }
    return barGroups;
  }

  List<BarChartGroupData> getMonthlyNetPNLChartsData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsMonthlyPnLOverviewDetails> dataList = internshipMonthlyPnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.npnl?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }
    return barGroups;
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

    for (var position in internshipPositionList) {
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

  num calculateGrossPNL(num avg, int lots, num ltp) {
    num pnl = 0;
    num value = (avg + (lots) * ltp);
    pnl += value;
    return pnl;
  }

  num calculateTotalGrossPNL() {
    num totalGross = 0;
    for (var position in internshipPositionList) {
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
    for (var position in internshipPositionList) {
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
    log('totalNetPNL : ${totalNetPNL.toString()}');
    return totalNetPNL.round();
  }

  num calculateMargin() {
    num pnl = 0;
    num amount = 0;
    num lots = 0;
    for (var position in internshipPositionList) {
      amount += position.amount ?? 0;
      lots += position.lots ?? 0;
    }
    num openingBalance = internshipBatchPortfolio.value.openingBalance ?? 0;
    pnl += openingBalance + amount;

    if (lots == 0) {
      num margin = pnl + calculateTotalNetPNL();
      return margin;
    } else {
      return pnl;
    }
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
      if (index == -1) return FormatHelper.formatNumbers('00', showSymbol: false);
      String? price = tenxInstrumentTradeDetailsList[index].change?.toString();
      return FormatHelper.formatNumbers(price, showSymbol: false);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
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
        await getInternshipWatchlist();
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
      await getInternshipWatchlist();
      await searchInstruments(searchTextController.text);
      log('getInternshipWatchlist : ${tradingWatchlist.length}');
      SnackbarHelper.showSnackbar('Instrument Remove');
      // } else {
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getInternshipWatchlist() async {
    isLoading(true);
    try {
      final RepoResponse<TradingWatchlistResponse> response =
          await repository.getInternshipWatchlist();
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
      log("watch ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getInternshipPositions() async {
    isLoading(true);
    try {
      final RepoResponse<InternshipPositionResponse> response =
          await repository.getInternshipPositions(internshipBatchDetails.value.id);
      if (response.data != null) {
        if (response.data?.data! != null) {
          internshipPositionList(response.data?.data ?? []);
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

  Future placeInternshipOrder(TransactionType type, TradingInstrument inst) async {
    Get.back();
    isLoading(true);
    InternshipPlaceOrderRequest data = InternshipPlaceOrderRequest(
      orderType: "MARKET",
      price: "",
      product: "NRML",
      quantity: selectedQuantity.value,
      triggerPrice: "",
      battleId: internshipBatchDetails.value.id,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      createdBy: userDetailsData.name,
      exchange: inst.exchange,
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      internPath: true,
      marginxId: internshipBatchDetails.value.id,
      orderId: Uuid().v4(),
      paperTrade: false,
      stopLoss: "",
      subscriptionId: internshipBatchDetails.value.id,
      symbol: inst.tradingsymbol,
      uId: Uuid().v4(),
      userId: userDetailsData.email,
      trader: userDetailsData.sId,
      validity: "DAY",
      variety: "regular",
    );
    log('placeVirtualTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.paperPlaceOrder(
        data.toJson(),
      );
      log(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successfull');
        await getInternshipPositions();
        await getInternshipBatchPortfolioDetails();
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

  Future getInternshipBatchDetails() async {
    isLoading(true);
    try {
      final RepoResponse<InternshipBatchResponse> response =
          await repository.getInternshipBatchDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          internshipBatchDetails(response.data?.data);
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

  Future getInternshipBatchPortfolioDetails() async {
    isLoading(true);
    try {
      final RepoResponse<InternshipBatchPortfolioResponse> response =
          await repository.getInternshipBatchPortfolioDetails(
        internshipBatchDetails.value.id,
      );
      if (response.data?.data != null) {
        internshipBatchPortfolio(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getInternshipAnalyticsOverview() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsOverviewDetailsResponse> response =
          await repository.getInternshipAnalyticsOverview(internshipBatchDetails.value.id);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          internshipOverview(response.data?.data?[0] ?? AnalyticsOverviewDetails());
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

  Future getInternshipAnalyticsDateWisePnLOverviewDetails() async {
    isLoading(true);
    try {
      Map<String, dynamic> query = {
        "from": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(startDateTextController.text),
        ),
        "to": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(endDateTextController.text),
        ),
      };

      final RepoResponse<AnalyticsDateWiseDetailsResponse> response = await repository
          .getInternshipAnalyticsDateWisePnLOverviewDetails(internshipBatchDetails.value.id, query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          internshipDateWisePnlList.value = response.data?.data ?? [];
          rangeCalculation();
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

  Future getInternshipAnalyticsMonthlyPnLOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsMonthlyPnLOverviewDetailsResponse> response = await repository
          .getInternshipAnalyticsMonthlyPnLOverviewDetails(internshipBatchDetails.value.id);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          internshipMonthlyPnlList(response.data?.data);
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
