import 'dart:developer';
import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
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

  final isInternshipLoading = false.obs;
  bool get isInternshipLoadingStatus => isInternshipLoading.value;

  final isTodaysOrdersLoading = false.obs;
  bool get isTodaysOrdersLoadingStatus => isTodaysOrdersLoading.value;

  final isAllOrdersLoading = false.obs;
  bool get isAllOrdersLoadingStatus => isAllOrdersLoading.value;

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
  bool get isExecutedOrderStateLoadingStatus => isExecutedOrderStateLoading.value;

  final segmentedControlValue = 0.obs;

  final selectedTabBarIndex = 0.obs;

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
  final internshipPositionList = <TradingPosition>[].obs;
  final tradingInstrumentTradeDetailsList = <TradingInstrumentTradeDetails>[].obs;
  final tradingInstruments = <TradingInstrument>[].obs;
  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;
  final internshipAllOrders = <InternshipOrdersList>[].obs;
  final internshipTodayOrders = <InternshipOrdersList>[].obs;
  final selectedWatchlistIndex = RxInt(-1);
  final selectedQuantity = 0.obs;
  final lotsValueList = <int>[0].obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final marginRequired = MarginRequiredResponse().obs;
  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;
  final selectedStringQuantity = "0".obs;
  final stopLossFormKey = GlobalKey<FormState>();
  final stopLossPriceTextController = TextEditingController();
  final stopProfitPriceTextController = TextEditingController();
  final quanitityTextController = TextEditingController();
  final limitPriceTextController = TextEditingController();
  final stopLossExecutedOrdersList = <StopLossExecutedOrdersList>[].obs;
  final stopLossPendingOrderList = <StopLossPendingOrdersList>[].obs;
  final stopLossPendingOrder = StopLossPendingOrdersList().obs;
  final stopLossPendingCancelOrder = StopLossPendingCancelOrder().obs;
  final internshipCertificate = <InternshipBatches>[].obs;
  final internshipCertificateDownload = InternshipBatches().obs;
  final selectedType = "".obs;
  final selectedGroupValue = 0.obs;

  final rangeGrossAmount = 0.0.obs;
  final rangeNetAmount = 0.0.obs;
  final rangeBrokerageAmount = 0.0.obs;
  final rangeTotalOrders = 0.obs;
  final rangeTotalTradingDays = 0.obs;
  final rangeTotalGreenDays = 0.obs;
  final rangeTotalRedDays = 0.obs;
  final isEligibleForCertificate = false.obs;

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getInternshipBatchDetails();
    await getInternshipCertificate();
    if (isParticipated()) {
      await getInternshipBatchPortfolioDetails();
    } else {
      await Get.find<CareerController>().getCareerList('Job');
    }
  }

  Future loadInternshipAnalyticsData() async {
    userDetails.value = AppStorage.getUserDetails();
    String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
    startDateTextController.text = date;
    endDateTextController.text = date;
    await getInternshipAnalyticsOverview();
    await getInternshipAnalyticsDateWisePnLOverviewDetails();
    await getInternshipAnalyticsMonthlyPnLOverviewDetails();
  }

  Future loadTradingData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getInstrumentLivePriceList();
    await getStockIndexInstrumentsList();
    await getInternshipPositions();
    await getStopLossPendingOrder();
    await getStopLossExecutedOrder();
    await getInternshipTodayOrdersList();
    await getInternshipBatchPortfolioDetails();
    await getInternshipWatchlist();
    socketIndexConnection();
    socketConnection();
    socketSendConnection();
  }

  Future loadOrderData() async {
    userDetails.value = AppStorage.getUserDetails();
    selectedTabBarIndex(0);
    await getInternshipTodayOrdersList();
    await getInternshipAllOrdersList();
  }

  void changeTabBarIndex(int val) => selectedTabBarIndex.value = val;

  bool handleTextField(TransactionType type, int transactionLotSize, int positionLots) {
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

  bool isParticipated() {
    bool isParticipated = false;
    String intershipId = internshipBatchDetails.value.id ?? '';
    for (InternshipBatchList intership in userDetails.value.internshipBatch ?? []) {
      if (intership.sId == intershipId) {
        for (InternshipParticipants user in intership.participants ?? []) {
          if (user.user == userDetails.value.sId) isParticipated = true;
        }
      }
    }
    return isParticipated;
  }

  int getOpenPositionCount() {
    int openCount = 0;
    for (var position in internshipPositionList) {
      if (position.id?.isLimit ?? false) {
      } else if (position.lots != 0) {
        openCount++;
      }
    }
    return openCount;
  }

  int getClosePositionCount() {
    int closeCount = 0;
    for (var position in internshipPositionList) {
      if (position.id?.isLimit ?? false) {
      } else if (position.lots == 0) {
        closeCount++;
      }
    }
    return closeCount;
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

  void downloadFile() async {
    Directory dir = await getApplicationDocumentsDirectory();

    String path = dir.path;
    String docsFolderPath = '$path/StoxHero/docs';
    String filePath = '$docsFolderPath/Certificate.pdf';
    String apiUrl = '${AppUrls.internshipCertificateDownload(internshipCertificateDownload.value.id)}';

    await File(filePath).create(recursive: true);
    Get.find<NetworkService>().downloadFile(path: apiUrl, filePath: filePath);
    await OpenFilex.open(filePath);
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

    for (var position in internshipPositionList) {
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

  num calculateTotalGrossPNL() {
    num totalGross = 0;
    for (var position in internshipPositionList) {
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
    for (var position in internshipPositionList) {
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
    for (var position in internshipPositionList) {
      if (position.lots != 0) {
        lots += position.lots ?? 0;
        margin += position.margin ?? 0;
      }
    }
    num openingBalance = 0;
    num totalFund = internshipBatchPortfolio.value.totalFund ?? 0;

    if (internshipBatchPortfolio.value.openingBalance != null) {
      openingBalance = internshipBatchPortfolio.value.openingBalance ?? 0;
      // print('openingBalance1 $openingBalance');
    } else {
      openingBalance = totalFund;
      // print('openingBalance2 $openingBalance');
    }
    num availableMargin = (calculateTotalNetPNL() < 0)
        ? (lots == 0 ? (openingBalance - margin + calculateTotalNetPNL()) : (openingBalance - margin))
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
      print(e.toString());
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
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future socketConnection() async {
    List<TradingInstrumentTradeDetails>? tempList = [];
    try {
      socketService.socket.on(
        'tick-room',
        (data) {
          tempList = TradingInstrumentTradeDetailsListResponse.fromJson(data).data ?? [];
          tempList?.forEach(
            (element) {
              if (tradingInstrumentTradeDetailsList.any((obj) => obj.instrumentToken == element.instrumentToken)) {
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
        },
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future addInstrument(TradingInstrument inst) async {
    isWatchlistStateLoading(true);
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

    print('addInstrument : ${data.toJson()}');

    try {
      final RepoResponse<GenericResponse> response = await repository.addInstrument(
        data.toJson(),
      );
      if (response.data?.message == "Instrument Added") {
        await getInternshipWatchlist();
        await searchInstruments(searchTextController.text, showShimmer: false);
        SnackbarHelper.showSnackbar("Instrument Added");
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future removeInstrument(int? instToken) async {
    isWatchlistStateLoading(true);
    try {
      await repository.removeInstrument(instToken ?? 0);
      // if (response.data != null) {
      selectedWatchlistIndex(-1);
      await getInternshipWatchlist();
      await searchInstruments(searchTextController.text, showShimmer: false);
      print('getInternshipWatchlist : ${tradingWatchlist.length}');
      SnackbarHelper.showSnackbar('Instrument Remove');
      // } else {
      // }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future getInternshipWatchlist() async {
    isWatchlistStateLoading(true);
    try {
      final RepoResponse<TradingWatchlistResponse> response = await repository.getInternshipWatchlist();
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
      print("watch ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future getInternshipPositions() async {
    isPositionStateLoading(true);
    try {
      final RepoResponse<TradingPositionListResponse> response =
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
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPositionStateLoading(false);
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
      print(e.toString());
    }
  }

  Future searchInstruments(String? value, {bool showShimmer = true}) async {
    showShimmer ? isInstrumentListLoading(true) : isWatchlistStateLoading(true);

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
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    showShimmer ? isInstrumentListLoading(false) : isWatchlistStateLoading(false);
  }

  Future placeInternshipOrder(TransactionType type, TradingInstrument inst) async {
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
    InternshipPlaceOrderRequest data = InternshipPlaceOrderRequest(
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
      subscriptionId: internshipBatchDetails.value.id,
      battleId: internshipBatchDetails.value.id,
      marginxId: internshipBatchDetails.value.id,
      triggerPrice: "",
      internPath: true,
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    print('placeVirtualTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.paperPlaceOrder(
        data.toJson(),
      );
      print(response.data.toString());
      Get.back();
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successful');
        await getInternshipPositions();
        await getStopLossPendingOrder();
        await getInternshipTodayOrdersList();
        await getInternshipBatchPortfolioDetails();
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
    isTradingOrderSheetLoading(false);
  }

  Future getInternshipBatchDetails() async {
    isInternshipLoading(true);
    try {
      final RepoResponse<InternshipBatchResponse> response = await repository.getInternshipBatchDetails();
      if (response.data != null) {
        internshipBatchDetails(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isInternshipLoading(false);
  }

  Future getInternshipBatchPortfolioDetails() async {
    isPortfolioStateLoading(true);
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
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPortfolioStateLoading(false);
  }

  Future getInternshipAnalyticsOverview() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsOverviewDetailsResponse> response =
          await repository.getInternshipAnalyticsOverview(internshipBatchDetails.value.id);
      if (response.data != null) {
        internshipOverview(response.data?.data?[0] ?? AnalyticsOverviewDetails());
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
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

      final RepoResponse<AnalyticsDateWiseDetailsResponse> response =
          await repository.getInternshipAnalyticsDateWisePnLOverviewDetails(internshipBatchDetails.value.id, query);
      if (response.data != null) {
        internshipDateWisePnlList.value = response.data?.data ?? [];
        rangeCalculation();
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getInternshipAnalyticsMonthlyPnLOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsMonthlyPnLOverviewDetailsResponse> response =
          await repository.getInternshipAnalyticsMonthlyPnLOverviewDetails(internshipBatchDetails.value.id);
      if (response.data != null) {
        internshipMonthlyPnlList(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getInternshipTodayOrdersList() async {
    internshipTodayOrders.clear();
    isTodaysOrdersLoading(true);
    try {
      final RepoResponse<InternshipOrdersListResponse> response = await repository.getInternshipTodayOrdersList();
      if (response.data != null) {
        internshipTodayOrders(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isTodaysOrdersLoading(false);
  }

  Future getInternshipAllOrdersList() async {
    internshipAllOrders.clear();
    isAllOrdersLoading(true);
    try {
      final RepoResponse<InternshipOrdersListResponse> response = await repository.getInternshipAllOrdersList();
      if (response.data != null) {
        internshipAllOrders(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isAllOrdersLoading(false);
  }

  int calculateQuantity(TransactionType type, int tradingLots, int selectQuantity) {
    if (type == TransactionType.sell || type == TransactionType.exit) {
      if (tradingLots == selectQuantity || tradingLots.abs() >= selectQuantity) {
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
      quantity: calculateQuantity(type, inst.lotSize ?? 0, selectedQuantity.value),
      product: "NRML",
      orderType: selectedType.value,
      validity: "DAY",
      variety: "regular",
      price: limitPriceTextController.text,
      lastPrice: inst.lastPrice.toString(),
    );

    try {
      final RepoResponse<MarginRequiredResponse> response = await repository.getMarginRequired(
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

  Future getStopLossExecutedOrder() async {
    isExecutedOrderStateLoading(true);
    try {
      final RepoResponse<StopLossExecutedOrdersListResponse> response = await repository.getStopLossExecutedOrder(
        internshipBatchDetails.value.id,
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
      final RepoResponse<StopLossPendingOrdersListResponse> response = await repository.getStopLossPendingOrder(
        internshipBatchDetails.value.id,
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
      await getInternshipBatchPortfolioDetails();
      await getStopLossExecutedOrder();
      loadTradingData();
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
  }

  Future pendingOrderModify(TransactionType type, TradingInstrument inst) async {
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
      id: internshipBatchDetails.value.id,
      lastPrice: inst.lastPrice.toString(),
      variety: "regular",
      from: "Internship Trader",
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    print('PendingOrderModifyRequest : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.pendingOrderModify(
        data.toJson(),
      );
      Get.back();
      print(response.data.toString());
      if (response.data?.status == "Success") {
        SnackbarHelper.showSnackbar(response.data?.message);
        await getStopLossPendingOrder();
        await getInternshipTodayOrdersList();
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
          getInternshipPositions();
          getStopLossPendingOrder();
          getStopLossExecutedOrder();
          getInternshipTodayOrdersList();
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    isPendingOrderStateLoading(false);
  }

  Future getInternshipCertificate() async {
    isLoading(true);
    try {
      final RepoResponse<InternshipCertificateResponse> response = await repository.getInternshipCertificate();
      if (response.data?.status?.toLowerCase() == "success") {
        if (response.data?.message == "Eligible for certificate") {
          isEligibleForCertificate.value = true;
        }
        internshipCertificate(response.data?.batches ?? []);
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
