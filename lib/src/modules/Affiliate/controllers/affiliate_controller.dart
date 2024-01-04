import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../app/app.dart';

class AffiliateBinding implements Bindings {
  @override
  void dependencies() => Get.put(AffiliateController());
}

class AffiliateController extends BaseController<AffiliateRespository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final startDateTextController = TextEditingController();
  final endDateTextController = TextEditingController();

  final affiliateSummaryDetails = <AffiliateSummaryData>[].obs;
  final summeryList = <AffiliateSummaryDetails>[].obs;
  final summeryDetails = AffiliateSummaryDetails().obs;
  // final transactionList = <AffiliateTransaction>[].obs;
  final myAffiliateTransctionList = <MyTranscationListData>[].obs;
  final affiliateSignupSummeryList = <AffiliateRafferalSummeryData>[].obs;
  final affiliateSignupSummeryDetails = AffiliateRafferalSummeryData().obs;
  final affilateOverviewDetails = AffiliateOverviewData().obs;

  final myAffiliateRefferalsList = <MyAffiliateRefferal>[].obs;

  String selectedTimeFrame = 'today';
  List<String> timeFrames = [
    "today",
    'Yesterday',
    'this week',
    "last week",
    'this month',
    "last month",
    'custom'
  ];

  final transctionCurrentPage = 0.obs;
  final transctionItemsPerPage = 0.obs;
  final transctionTotalItems = 0.obs;

  final reffralsCurrentPage = 0.obs;
  final reffralsItemsPerPage = 0.obs;
  final reffralsTotalItems = 0.obs;

  final affiliateLast30daysData = <AffiliateLast30DaysData>[].obs;

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void loadData() async {
    loadUserDetails();

    late String startDate;
    late String endDate;

    if (selectedTimeFrame == 'today') {
      startDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
      endDate = startDate;
    } else if (selectedTimeFrame == 'Yesterday') {
      DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
      startDate = DateFormat("dd-MM-yyyy").format(yesterday);
      endDate = startDate;
    } else if (selectedTimeFrame == 'this week') {
      DateTime startOfWeek =
          DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
      startDate = DateFormat("dd-MM-yyyy").format(startOfWeek);
      endDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    } else if (selectedTimeFrame == 'this month') {
      DateTime firstDayOfMonth =
          DateTime(DateTime.now().year, DateTime.now().month, 1);
      startDate = DateFormat("dd-MM-yyyy").format(firstDayOfMonth);
      endDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    } else if (selectedTimeFrame == 'last week') {
      DateTime endOfLastWeek =
          DateTime.now().subtract(Duration(days: DateTime.now().weekday));
      DateTime startOfLastWeek = endOfLastWeek.subtract(Duration(days: 6));
      startDate = DateFormat("dd-MM-yyyy").format(startOfLastWeek);
      endDate = DateFormat("dd-MM-yyyy").format(endOfLastWeek);
    } else if (selectedTimeFrame == 'last month') {
      DateTime today = DateTime.now();
      DateTime firstDayOfCurrentMonth = DateTime(today.year, today.month, 1);
      DateTime firstDayOfLastMonth =
          firstDayOfCurrentMonth.subtract(Duration(days: 1));
      DateTime lastDayOfLastMonth = firstDayOfLastMonth
          .subtract(Duration(days: firstDayOfLastMonth.day - 1));
      startDate = DateFormat("dd-MM-yyyy").format(lastDayOfLastMonth);
      endDate = DateFormat("dd-MM-yyyy").format(firstDayOfLastMonth);
    } else if (selectedTimeFrame == 'custom') {
      startDate = DateFormat("01-MM-yyyy").format(DateTime.now());
      endDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    } else {
      startDate = DateFormat("01-MM-yyyy").format(DateTime.now());
      endDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    }

    startDateTextController.text = startDate;
    endDateTextController.text = endDate;
    transctionCurrentPage.value = 0;
    transctionItemsPerPage.value = 10;
    transctionTotalItems.value = myAffiliateTransctionList.length;

    reffralsCurrentPage.value = 0;
    reffralsItemsPerPage.value = 10;
    reffralsTotalItems.value = myAffiliateRefferalsList.length;

    await getAffiliateSummaryDetails();
    await getAffiliateSignUpDetails();
    await getMyAffiliateTransctionDetails();
    await getAffiliateOverViewDetails();
    await getAffiliateLast30DaysDataDetails();
  }

  String getUserFullName() {
    String firstName = userDetailsData.firstName ?? '';
    String lastName = userDetailsData.lastName ?? '';
    String fullName = '$firstName $lastName';
    return fullName.capitalize!;
  }

  void nextPage() {
    final lastPage =
        (transctionTotalItems.value / transctionItemsPerPage.value).ceil() - 1;

    if (transctionTotalItems.value > 0 &&
        transctionCurrentPage.value < lastPage) {
      transctionCurrentPage.value++;
      getMyAffiliateTransctionDetails();
    }
  }

  Future getAffiliateLast30DaysDataDetails() async {
    isLoading(true);
    try {
      final RepoResponse<Last30DaysAffiliateDataResponse> response =
          await repository.getAffiliateLast30DaysDetails();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          affiliateLast30daysData.value = response.data?.data ?? [];
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

  List<BarChartGroupData> getLast30daysEarningData({
    required Color totalColor,
    required Color contestColor,
    required Color tenxColor,
  }) {
    List<BarChartGroupData> barGroups = [];

    List<AffiliateLast30DaysData> dataList = affiliateLast30daysData;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barsSpace: 8,
          barRods: [
            // First rod for Total
            BarChartRodData(
              fromY: 0,
              toY: data.totalEarnings?.toDouble() ?? 0,
              width: 4,
              color: totalColor,
            ),
            // Second rod for Contest
            BarChartRodData(
              fromY: 0,
              toY: data.totalTestzoneEarnings?.toDouble() ?? 0,
              width: 4,
              color: contestColor,
            ),
            // Third rod for TenX
            BarChartRodData(
              fromY: 0,
              toY: data.totalTenxEarnings?.toDouble() ?? 0,
              width: 4,
              color: tenxColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<BarChartGroupData> getLast30DaysOrder({
    required Color barColor,
  }) {
    List<BarChartGroupData> barGroups = [];

    List<AffiliateLast30DaysData> dataList = affiliateLast30daysData;

    for (var i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barsSpace: 8,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: data.totalOrder?.toDouble() ?? 0,
              width: 4,
              color: barColor,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<AffiliateLast30DaysData> dataList = affiliateLast30daysData;

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

  void refferalsNextPage() {
    final lastPage =
        (reffralsTotalItems.value / reffralsItemsPerPage.value).ceil();
    print(
        "lastpage ${lastPage} ${reffralsTotalItems.value} ${reffralsItemsPerPage}");

    if (reffralsTotalItems.value > 0 && reffralsCurrentPage.value < lastPage) {
      reffralsCurrentPage.value++;
      getAffiliateSignUpDetails();
    }
  }

  void previousPage() {
    if (transctionCurrentPage.value > 0) {
      transctionCurrentPage.value--;
      getMyAffiliateTransctionDetails();
    }
  }

  void reffralsPreviousPage() {
    if (reffralsCurrentPage.value > 0) {
      reffralsCurrentPage.value--;
      getAffiliateSignUpDetails();
    }
  }

  bool get isPreviousButtonDisabled => transctionCurrentPage.value == 0;
  bool get isNextButtonDisabled {
    if (transctionTotalItems.value <= 0) {
      return true;
    }

    final lastPage =
        (transctionTotalItems.value / transctionItemsPerPage.value).ceil() - 1;
    return transctionCurrentPage.value == lastPage || lastPage < 1;
  }

  bool get isrefferlsPreviousButtonDisabled => reffralsCurrentPage.value == 0;
  bool get isreferralsNextButtonDisabled {
    final lastPage =
        (reffralsTotalItems.value / reffralsItemsPerPage.value).ceil() - 1;
    return reffralsCurrentPage.value == lastPage || lastPage < 1;
  }

  void showDateRangePicker(BuildContext context,
      {bool isStartDate = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      String date = DateFormat("dd-MM-yyyy").format(pickedDate);
      isStartDate
          ? startDateTextController.text = date
          : endDateTextController.text = date;
    }
  }

  Future getAffiliateSummaryDetails() async {
    try {
      Map<String, dynamic> query = {
        "startDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(startDateTextController.text),
        ),
        "endDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(endDateTextController.text),
        ),
      };
      affiliateSummaryDetails([]);
      summeryList([]);
      affiliateSignupSummeryList([]);
      summeryDetails(AffiliateSummaryDetails());
      affiliateSignupSummeryDetails(AffiliateRafferalSummeryData());

      final RepoResponse<AffiliateSummaryResponse> response =
          await repository.getAffiliateDashboardSummary(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          affiliateSummaryDetails(response.data?.data ?? []);
          affiliateSignupSummeryList(
              response.data?.affiliateRafferalSummery ?? []);
          if (affiliateSignupSummeryList.isNotEmpty) {
            affiliateSignupSummeryDetails(affiliateSignupSummeryList.first);
          }
          for (AffiliateSummaryData affiliateSummary
              in affiliateSummaryDetails) {
            summeryList(affiliateSummary.summery ?? []);
            if (summeryList.isNotEmpty) {
              summeryDetails(summeryList.first);
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
  }

  Future getMyAffiliateTransctionDetails() async {
    try {
      int skip = transctionCurrentPage.value * transctionItemsPerPage.value;
      Map<String, dynamic> query = {
        "startDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(startDateTextController.text),
        ),
        "endDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(endDateTextController.text),
        ),
        "skip": skip,
        "limit": transctionItemsPerPage.value,
      };
      print("skipdaat${skip} ${transctionItemsPerPage.value}");
      final RepoResponse<MyAffiliateTransctionListResponse> response =
          await repository.getMyAffiliateTranscationList(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          myAffiliateTransctionList(response.data?.data ?? []);
          transctionTotalItems(response.data!.count!);
          transctionItemsPerPage(10);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future getAffiliateSignUpDetails() async {
    try {
      num skip = reffralsCurrentPage.value * reffralsItemsPerPage.value;
      Map<String, dynamic> query = {
        "startDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(startDateTextController.text),
        ),
        "endDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(endDateTextController.text),
        ),
        "skip": skip,
        "limit": reffralsItemsPerPage.value,
      };
      print(
          "skipskip ${skip} ${reffralsItemsPerPage.value} ${reffralsCurrentPage.value}");
      final RepoResponse<MyAffiliateRefferalsListResponse> response =
          await repository.getMyAffiliateReferralsData(
        query,
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          myAffiliateRefferalsList(response.data?.data);
          reffralsTotalItems(response.data!.count!);
          reffralsItemsPerPage(10);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future getAffiliateOverViewDetails() async {
    try {
      final RepoResponse<AffiliateOverViewResponse> response =
          await repository.getAffiliateOverViewList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          affilateOverviewDetails(response.data?.data);
          print(
              "affilateOverview ${affilateOverviewDetails.value.lifetimeEarning}");
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }
}
