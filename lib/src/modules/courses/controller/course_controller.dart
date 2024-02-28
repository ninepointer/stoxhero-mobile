import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/app.dart';

class CourseBinding implements Bindings {
  @override
  void dependencies() => Get.put(CourseController());
}

class CourseController extends BaseController<CourseRespository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;
  final batchNameTextController = TextEditingController();
  final batchStartDateTextController = TextEditingController();

  final publishInflunceCourseList = <InfluencerCourseData>[].obs;
  final unPublishInflunceCourseList = <InfluencerCourseData>[].obs;
  final pendingadminapprovalInflunceCourseList = <InfluencerCourseData>[].obs;
  final awaitingapprovalInflunceCourseList = <InfluencerCourseData>[].obs;

  final selectedTabIndex = 0.obs;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final selectedDOBDateTime = ''.obs;

  final currentPage = 0.obs;
  final totalItems = 0.obs;
  final itemsPerPage = 0.obs;
  final isLoadingMore = false.obs;

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void loadData() async {
    loadUserDetails();
    await getInfluencerPublishCourseDetails();
    await getInfluencerUnpublishCourseDetails();
    await getInfluencerPendingadminapprovalCourseDetails();
    await getInfluencerAwaitingapprovalCourseDetails();
  }

  void showDateRangePicker(BuildContext context,
      {bool isStartDate = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );

    if (pickedDate != null) {
      String date = DateFormat("dd-MM-yyyy").format(pickedDate);
      batchStartDateTextController.text = date;
      selectedDOBDateTime(pickedDate.toString());
    }
  }

  void loadMoreOrders() {
    if (!isLoadingMore.value) {
      isLoadingMore.value = true;
      currentPage.value++;
      if (itemsPerPage.value == 0) {
        isLoadingMore.value = false;
        return;
      }
      final lastPage = (totalItems.value / itemsPerPage.value).ceil();
      print("lastpage ${lastPage} ${totalItems.value} ${itemsPerPage.value}");
      if (currentPage.value >= lastPage) {
        isLoadingMore.value = true;
      } else {
        getInfluencerPublishCourseDetails();
      }
    }
  }

  Future getInfluencerPublishCourseDetails() async {
    try {
      isLoadingMore.value = true;
      int skip = currentPage.value * itemsPerPage.value;
      Map<String, dynamic> query = {
        "skip": skip,
        "limit": 10,
      };
      final RepoResponse<InfluencerCourseResponse> response =
          await repository.getInfluencerPublishCourse(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          publishInflunceCourseList.clear();
          publishInflunceCourseList.addAll(response.data?.data ?? []);
          totalItems(response.data?.count);
          itemsPerPage(20);
          int remainingItem =
              (response.data?.count ?? 0) - (publishInflunceCourseList.length);
          if (remainingItem < itemsPerPage.value) {
            itemsPerPage(remainingItem);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future getInfluencerUnpublishCourseDetails() async {
    try {
      isLoadingMore.value = true;
      int skip = currentPage.value * itemsPerPage.value;
      Map<String, dynamic> query = {
        "skip": skip,
        // "limit": itemsPerPage.value,
        "limit": 10,
      };
      final RepoResponse<InfluencerCourseResponse> response =
          await repository.getInfluencerUnpublishCourse(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          unPublishInflunceCourseList.clear();
          unPublishInflunceCourseList.addAll(response.data?.data ?? []);
          totalItems(response.data?.count);
          itemsPerPage(20);
          int remainingItem = (response.data?.count ?? 0) -
              (unPublishInflunceCourseList.length);
          if (remainingItem < itemsPerPage.value) {
            itemsPerPage(remainingItem);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future getInfluencerPendingadminapprovalCourseDetails() async {
    try {
      isLoadingMore.value = true;
      int skip = currentPage.value * itemsPerPage.value;
      Map<String, dynamic> query = {
        "skip": skip,
        // "limit": itemsPerPage.value,
        "limit": 10,
      };
      final RepoResponse<InfluencerCourseResponse> response =
          await repository.getInfluencerPendingAdminApprovalCourse(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          pendingadminapprovalInflunceCourseList.clear();
          pendingadminapprovalInflunceCourseList
              .addAll(response.data?.data ?? []);
          totalItems(response.data?.count);
          itemsPerPage(20);
          int remainingItem = (response.data?.count ?? 0) -
              (pendingadminapprovalInflunceCourseList.length);
          if (remainingItem < itemsPerPage.value) {
            itemsPerPage(remainingItem);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future getInfluencerAwaitingapprovalCourseDetails() async {
    try {
      isLoadingMore.value = true;
      int skip = currentPage.value * itemsPerPage.value;
      Map<String, dynamic> query = {
        "skip": skip,
        // "limit": itemsPerPage.value,
        "limit": 10,
      };
      final RepoResponse<InfluencerCourseResponse> response =
          await repository.getInfluencerAwaitingApprovalCourse(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          awaitingapprovalInflunceCourseList.clear();
          awaitingapprovalInflunceCourseList.addAll(response.data?.data ?? []);
          totalItems(response.data?.count);
          itemsPerPage(20);
          int remainingItem = (response.data?.count ?? 0) -
              (awaitingapprovalInflunceCourseList.length);
          if (remainingItem < itemsPerPage.value) {
            itemsPerPage(remainingItem);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isLoadingMore.value = false;
    }
  }
}
