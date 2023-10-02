import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/app.dart';

class AnalyticsBinding implements Bindings {
  @override
  void dependencies() => Get.put(AnalyticsController());
}

class AnalyticsController extends BaseController<AnalyticsRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final startDateTextController = TextEditingController();
  final endDateTextController = TextEditingController();

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final selectedTab = 0.obs;

  final virtualTadingOverviewDetails = AnalyticsOverviewDetails().obs;
  final tenxTadingOverviewDetails = AnalyticsOverviewDetails().obs;
  final infinityTadingOverviewDetails = AnalyticsOverviewDetails().obs;

  final virtualTadingDateWiseList = <AnalyticsDateWiseDetails>[].obs;
  final tenxTadingDateWiseList = <AnalyticsDateWiseDetails>[].obs;
  final infinityTadingDateWiseList = <AnalyticsDateWiseDetails>[].obs;

  final virtualTadingExpectedPnlList = <AnalyticsExpectedPnLOverviewDetails>[].obs;
  final tenxTadingExpectedPnlList = <AnalyticsExpectedPnLOverviewDetails>[].obs;
  final infinityTadingExpectedPnlList = <AnalyticsExpectedPnLOverviewDetails>[].obs;

  final virtualTadingMonthlyPnlList = <AnalyticsMonthlyPnLOverviewDetails>[].obs;
  final tenxTradingMonthlyPnlList = <AnalyticsMonthlyPnLOverviewDetails>[].obs;
  final infinityTradingMonthlyPnlList = <AnalyticsMonthlyPnLOverviewDetails>[].obs;

  final rangeGrossAmount = 0.0.obs;
  final rangeNetAmount = 0.0.obs;
  final rangeBrokerageAmount = 0.0.obs;
  final rangeTotalOrders = 0.obs;
  final rangeTotalTradingDays = 0.obs;
  final rangeTotalGreenDays = 0.obs;
  final rangeTotalRedDays = 0.obs;

  AnalyticsOverviewDetails get overviewDetails => getOverViewDetails();

  AnalyticsOverviewDetails getOverViewDetails() {
    AnalyticsOverviewDetails details = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingOverviewDetails.value
            : tenxTadingOverviewDetails.value
        : virtualTadingOverviewDetails.value;
    return details;
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

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void loadData() async {
    loadUserDetails();

    String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
    startDateTextController.text = date;
    endDateTextController.text = date;

    if (userDetailsData.designation == AppConstants.equityTraderType) {
      await getInfinityTradingOverviewDetails();
      await getInfinityTradingDateWiseDetails();
      await getInfinityAnalyticsExpectedPnLOverviewDetails();
      await getInfinityAnalyticsMonthlyPnLOverviewDetails();
    } else {
      await getTenxTradingOverviewDetails();
      await getTenxTradingOverviewDetails();
      await getTenXAnalyticsExpectedPnLOverviewDetails();
      await getTenXAnalyticsMonthlyPnLOverviewDetails();
    }
    await getVirtualTradingOverviewDetails();
    await getVirtualTradingDateWiseDetails();
    await getVirtualAnalyticsExpectedPnLOverviewDetails();
    await getVirtualAnalyticsMonthlyPnLOverviewDetails();

    rangeCalculation();
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<AnalyticsDateWiseDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingDateWiseList
            : tenxTadingDateWiseList
        : virtualTadingDateWiseList;

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

  Widget bottomTitless(double value, TitleMeta meta) {
    List<AnalyticsExpectedPnLOverviewDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingExpectedPnlList
            : tenxTadingExpectedPnlList
        : virtualTadingExpectedPnlList;

    var date = DateFormat("dd MMM").format(
      DateFormat('yyyy-MM-dd').parse(dataList[value.toInt() - 1].sId!),
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
    var index = value.toInt();
    String date = ""; // Default value for date

    if (index >= 0 && index < virtualTadingMonthlyPnlList.length) {
      String? dateStr = virtualTadingMonthlyPnlList[index].date;
      if (dateStr != null && dateStr.isNotEmpty) {
        try {
          date = DateFormat("dd MMM").format(DateFormat('yyyy-MM-dd').parse(dateStr));
        } catch (e) {
          print("Error parsing date: $e");
        }
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 55,
      child: Text(
        date,
        style: AppStyles.tsGreyRegular10,
      ),
    );
  }

  // List<double> getChartMinMaxValue(ChartType type) {
  //   List<AnalyticsDateWiseDetails> dataList = selectedTab.value == 0
  //       ? userDetailsData.designation == AppConstants.equityTraderType
  //           ? infinityTadingDateWiseList
  //           : tenxTadingDateWiseList
  //       : virtualTadingDateWiseList;

  //   double minValue = 0;
  //   double maxValue = 0;

  //   switch (type) {
  //     case ChartType.gross:
  //       dataList.sort((a, b) => (a.gpnl ?? 0).compareTo(b.gpnl ?? 0));
  //       minValue = dataList.first.gpnl!.toDouble();

  //       dataList.sort((a, b) => (b.gpnl ?? 0).compareTo(a.gpnl ?? 0));
  //       maxValue = dataList.first.gpnl!.toDouble();

  //       break;
  //     case ChartType.net:
  //       dataList.sort((a, b) => (a.gpnl ?? 0).compareTo(b.gpnl ?? 0));
  //       minValue = dataList.first.gpnl!.toDouble();

  //       dataList.sort((a, b) => (b.gpnl ?? 0).compareTo(a.gpnl ?? 0));
  //       maxValue = dataList.first.gpnl!.toDouble();

  //       break;
  //     case ChartType.orders:
  //       dataList.sort((a, b) => (a.gpnl ?? 0).compareTo(b.gpnl ?? 0));
  //       minValue = dataList.first.gpnl!.toDouble();

  //       dataList.sort((a, b) => (b.gpnl ?? 0).compareTo(a.gpnl ?? 0));
  //       maxValue = dataList.first.gpnl!.toDouble();

  //       break;
  //     case ChartType.brokerage:
  //       dataList.sort((a, b) => (a.gpnl ?? 0).compareTo(b.gpnl ?? 0));
  //       minValue = dataList.first.gpnl!.toDouble();

  //       dataList.sort((a, b) => (b.gpnl ?? 0).compareTo(a.gpnl ?? 0));
  //       maxValue = dataList.first.gpnl!.toDouble();

  //       break;
  //     default:
  //   }

  //   return [minValue, maxValue];
  // }

  List<BarChartGroupData> getGrossChartsData({
    required Color barColor,
  }) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsDateWiseDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingDateWiseList
            : tenxTadingDateWiseList
        : virtualTadingDateWiseList;

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

    List<AnalyticsDateWiseDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingDateWiseList
            : tenxTadingDateWiseList
        : virtualTadingDateWiseList;

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

    List<AnalyticsDateWiseDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingDateWiseList
            : tenxTadingDateWiseList
        : virtualTadingDateWiseList;

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

    List<AnalyticsDateWiseDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingDateWiseList
            : tenxTadingDateWiseList
        : virtualTadingDateWiseList;

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

  List<BarChartGroupData> getExpectedAvgProfitChartData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsExpectedPnLOverviewDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingExpectedPnlList
            : tenxTadingExpectedPnlList
        : virtualTadingExpectedPnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.expectedAvgProfit?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<BarChartGroupData> getExpectedAvgLossChartData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsExpectedPnLOverviewDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingExpectedPnlList
            : tenxTadingExpectedPnlList
        : virtualTadingExpectedPnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.expectedAvgLoss?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<BarChartGroupData> getExpectedPnLChartData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsExpectedPnLOverviewDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingExpectedPnlList
            : tenxTadingExpectedPnlList
        : virtualTadingExpectedPnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.expectedPnl?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<BarChartGroupData> getRiskRewardChartData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsExpectedPnLOverviewDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingExpectedPnlList
            : tenxTadingExpectedPnlList
        : virtualTadingExpectedPnlList;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.riskRewardRatio?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<BarChartGroupData> getMonthlyGPnLChartData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsMonthlyPnLOverviewDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTradingMonthlyPnlList
            : tenxTradingMonthlyPnlList
        : virtualTadingMonthlyPnlList;

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

  List<BarChartGroupData> getMonthlyNPnlChartData({required Color barColor}) {
    List<BarChartGroupData> barGroups = [];

    List<AnalyticsMonthlyPnLOverviewDetails> dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTradingMonthlyPnlList
            : tenxTradingMonthlyPnlList
        : virtualTadingMonthlyPnlList;

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

  void rangeCalculation() {
    rangeGrossAmount(0.0);
    rangeNetAmount(0.0);
    rangeBrokerageAmount(0.0);
    rangeTotalOrders(0);
    rangeTotalTradingDays(0);
    rangeTotalGreenDays(0);
    rangeTotalRedDays(0);

    var dataList = selectedTab.value == 0
        ? userDetailsData.designation == AppConstants.equityTraderType
            ? infinityTadingDateWiseList
            : tenxTadingDateWiseList
        : virtualTadingDateWiseList;

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

  Future getVirtualTradingOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsOverviewDetailsResponse> response =
          await repository.getVirtualTradingAnalyticsOverviewDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          virtualTadingOverviewDetails(response.data?.data?[0] ?? AnalyticsOverviewDetails());
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

  Future getTenxTradingOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsOverviewDetailsResponse> response =
          await repository.getTenxTradingAnalyticsOverviewDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          final data = response.data?.data;
          if (data != null && data.isNotEmpty) {
            tenxTadingOverviewDetails(data[0]);
          } else {
            SnackbarHelper.showSnackbar("No data available.");
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

  Future getInfinityTradingOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsOverviewDetailsResponse> response =
          await repository.getInfinityTradingAnalyticsOverviewDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          infinityTadingOverviewDetails(response.data?.data?[0] ?? AnalyticsOverviewDetails());
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

  Future getVirtualTradingDateWiseDetails() async {
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
          await repository.getVirtualTradingDateWiseAnalyticsDetails(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          virtualTadingDateWiseList.value = response.data?.data ?? [];
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

  Future getTenxTradingDateWiseDetails() async {
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
          await repository.getTenxTradingDateWiseAnalyticsDetails(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxTadingDateWiseList.value = response.data?.data ?? [];
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

  Future getInfinityTradingDateWiseDetails() async {
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
          await repository.getInfinityTradingDateWiseAnalyticsDetails(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          infinityTadingDateWiseList.value = response.data?.data ?? [];
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

  Future getVirtualAnalyticsExpectedPnLOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsExpectedPnLOverviewDetailsResponse> response =
          await repository.getVirtualAnalyticsExpectedPnLOverviewDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          virtualTadingExpectedPnlList(response.data?.data);
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

  Future getTenXAnalyticsExpectedPnLOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsExpectedPnLOverviewDetailsResponse> response =
          await repository.getTenXAnalyticsExpectedPnLOverviewDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxTadingExpectedPnlList(response.data?.data);
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

  Future getInfinityAnalyticsExpectedPnLOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsExpectedPnLOverviewDetailsResponse> response =
          await repository.getInfinityAnalyticsExpectedPnLOverviewDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          infinityTadingExpectedPnlList(response.data?.data);
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

  Future getVirtualAnalyticsMonthlyPnLOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsMonthlyPnLOverviewDetailsResponse> response =
          await repository.getVirtualAnalyticsMonthlyPnLOverviewDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          virtualTadingMonthlyPnlList(response.data?.data);
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

  Future getTenXAnalyticsMonthlyPnLOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsMonthlyPnLOverviewDetailsResponse> response =
          await repository.getTenXAnalyticsMonthlyPnLOverviewDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxTradingMonthlyPnlList(response.data?.data);
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

  Future getInfinityAnalyticsMonthlyPnLOverviewDetails() async {
    isLoading(true);
    try {
      final RepoResponse<AnalyticsMonthlyPnLOverviewDetailsResponse> response =
          await repository.getInfinityAnalyticsMonthlyPnLOverviewDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          infinityTradingMonthlyPnlList(response.data?.data);
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
