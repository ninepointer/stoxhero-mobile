import 'dart:developer';
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
  final summeryList = <AffiliateSummery>[].obs;
  final transactionList = <AffiliateTransaction>[].obs;
  final affiliateSignupSummeryList = <AffiliateRafferalSummery>[].obs;

  //  final affiliateSignUpDetails = <AffiliateRefferalsSignupData>[].obs;
  final affiliateSignUpDetails = AffiliateRefferalsSignupData().obs;

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void loadData() async {
    loadUserDetails();

    String startDate = DateFormat("01-MM-yyyy").format(DateTime.now());
    String endDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    startDateTextController.text = startDate;
    endDateTextController.text = endDate;
    getAffiliateSummaryDetails();
    getAffiliateSignUpDetails();
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

  Future getAffiliateSignUpDetails() async {
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

      final RepoResponse<AffiliateRefferralsResponse> response =
          await repository.getAffiliateSignupData(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          affiliateSignUpDetails(response.data?.data);
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
