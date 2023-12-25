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
  final myAffiliateTransctionList = <MyTranscationListData>[].obs;
  final affiliateSignupSummeryList = <AffiliateRafferalSummery>[].obs;

  final myAffiliateRefferalsList = <MyAffiliateRefferal>[].obs;

  final currentPage = 0.obs;
  final itemsPerPage = 0.obs;
  final totalItems = 0.obs;

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void loadData() async {
    loadUserDetails();

    String startDate = DateFormat("01-MM-yyyy").format(DateTime.now());
    String endDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    startDateTextController.text = startDate;
    endDateTextController.text = endDate;

    currentPage(0);
    itemsPerPage(0);
    totalItems(0);

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
    print('nextPage');
    final lastPage = totalItems.value ~/ itemsPerPage.value - 1;
    if (totalItems.value > 0 && currentPage.value < lastPage) {
      currentPage.value++;
      getMyAffiliateTransctionDetails();
    }
  }

  void previousPage() {
    print('previousPage');
    totalItems(totalItems.value - 2);
    if (currentPage.value > 0) {
      currentPage.value--;
      getMyAffiliateTransctionDetails();
    }
  }

  bool get isPreviousButtonDisabled => currentPage.value == 0;
  bool get isNextButtonDisabled {
    if (totalItems.value <= 0) {
      return true;
    }

    final lastPage = totalItems.value ~/ itemsPerPage.value - 1;
    return currentPage.value == lastPage || lastPage < 1;
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

      final RepoResponse<AffiliateSummaryResponse> response = await repository.getAffiliateDashboardSummary(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          affiliateSummaryDetails(response.data?.data ?? []);
          affiliateSignupSummeryList(response.data?.affiliateRafferalSummery ?? []);
          for (AffiliateSummaryData affiliateSummary in affiliateSummaryDetails) {
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
    isLoading(true);
    try {
      int skip = currentPage.value * itemsPerPage.value;
      Map<String, dynamic> query = {
        "startDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(startDateTextController.text),
        ),
        "endDate": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MM-yyyy').parse(endDateTextController.text),
        ),
        "skip": skip,
        "limit": totalItems,
      };

      final RepoResponse<MyAffiliateTransctionListResponse> response =
          await repository.getMyAffiliateTranscationList(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          myAffiliateTransctionList(response.data?.data ?? []);
          totalItems(response.data!.count!);
          itemsPerPage(response.data!.count! - 5);
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

      final RepoResponse<MyAffiliateRefferalsListResponse> response = await repository.getMyAffiliateReferralsData(
        query,
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          myAffiliateRefferalsList(response.data?.data);
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
