import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

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
  final summeryList = <AffiliateSummery>[].obs;
  final transactionList = <AffiliateTransaction>[].obs;
  final myAffiliateTransctionList = <MyTranscationListData>[].obs;
  final affiliateSignupSummeryList = <AffiliateRafferalSummery>[].obs;

  final myAffiliateRefferalsList = <MyAffiliateRefferal>[].obs;

  final transctionCurrentPage = 0.obs;
  final transctionItemsPerPage = 0.obs;
  final transctionTotalItems = 0.obs;

  final reffralsCurrentPage = 0.obs;
  final reffralsItemsPerPage = 0.obs;
  final reffralsTotalItems = 0.obs;

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void loadData() async {
    loadUserDetails();

    String startDate = DateFormat("01-MM-yyyy").format(DateTime.now());
    String endDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
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
    isLoading(true);
    try {
      Map<String, dynamic> query = {
        "startDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(startDateTextController.text),
        ),
        "endDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(endDateTextController.text),
        ),
      };

      final RepoResponse<AffiliateSummaryResponse> response =
          await repository.getAffiliateDashboardSummary(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          affiliateSummaryDetails(response.data?.data ?? []);
          affiliateSignupSummeryList(
              response.data?.affiliateRafferalSummery ?? []);
          for (AffiliateSummaryData affiliateSummary
              in affiliateSummaryDetails) {
            summeryList(affiliateSummary.summery ?? []);
            transactionList(affiliateSummary.transaction ?? []);
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
}
