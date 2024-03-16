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
  final courseOverview = CourseOverViewData().obs;
  final userCourseOverview = CourseOverViewData().obs;
  final suggestionTextController = TextEditingController();
  final userAllCourses = <InfluencerCourseData>[].obs;
  final userMyCourses = <UserMyCoursesData>[].obs;
  final currentRating = 0.obs;
  final videoapi = ''.obs;

  final selectedTabIndex = 0.obs;
  final selectedUserTabIndex = 0.obs;

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
      if (currentPage.value >= lastPage) {
        isLoadingMore.value = true;
      } else {
        getInfluencerAwaitingapprovalCourseDetails(isPagination: true);
        getInfluencerPublishCourseDetails(isPagination: true);
        getInfluencerUnpublishCourseDetails(isPagination: true);
        getInfluencerPendingadminapprovalCourseDetails(isPagination: true);
      }
    }
  }

  Future getInfluencerPublishCourseDetails({bool isPagination = false}) async {
    try {
      isLoadingMore.value = true;
      int skip = currentPage.value * itemsPerPage.value;
      Map<String, dynamic> query = {
        "skip": skip,
        // "limit": 10,
        "limit": itemsPerPage.value,
      };
      final RepoResponse<InfluencerCourseResponse> response =
          await repository.getInfluencerPublishCourse(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          if (isPagination == false) {
            publishInflunceCourseList.clear();
          }
          publishInflunceCourseList.addAll(response.data?.data ?? []);
          totalItems(response.data?.count);
          itemsPerPage(10);
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

  Future getInfluencerUnpublishCourseDetails(
      {bool isPagination = false}) async {
    try {
      isLoadingMore.value = true;
      int skip = currentPage.value * itemsPerPage.value;
      Map<String, dynamic> query = {
        "skip": skip,
        "limit": itemsPerPage.value,
        // "limit": 10,
      };
      final RepoResponse<InfluencerCourseResponse> response =
          await repository.getInfluencerUnpublishCourse(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          if (isPagination == false) {
            unPublishInflunceCourseList.clear();
          }
          unPublishInflunceCourseList.addAll(response.data?.data ?? []);
          totalItems(response.data?.count);
          itemsPerPage(10);
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

  Future getInfluencerPendingadminapprovalCourseDetails(
      {bool isPagination = false}) async {
    try {
      isLoadingMore.value = true;
      int skip = currentPage.value * itemsPerPage.value;
      Map<String, dynamic> query = {
        "skip": skip,
        "limit": itemsPerPage.value,
        // "limit": 10,
      };
      final RepoResponse<InfluencerCourseResponse> response =
          await repository.getInfluencerPendingAdminApprovalCourse(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          if (isPagination == false) {
            pendingadminapprovalInflunceCourseList.clear();
          }
          pendingadminapprovalInflunceCourseList
              .addAll(response.data?.data ?? []);
          totalItems(response.data?.count);
          itemsPerPage(10);
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

  Future getInfluencerAwaitingapprovalCourseDetails(
      {bool isPagination = false}) async {
    try {
      isLoadingMore.value = true;
      int skip = currentPage.value * itemsPerPage.value;
      print("cuuu ${currentPage.value} ${itemsPerPage.value}");
      Map<String, dynamic> query = {
        "skip": skip,
        "limit": itemsPerPage.value,
        //"limit": 10,
      };
      final RepoResponse<InfluencerCourseResponse> response =
          await repository.getInfluencerAwaitingApprovalCourse(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          if (isPagination == false) {
            awaitingapprovalInflunceCourseList.clear();
          }

          awaitingapprovalInflunceCourseList.addAll(response.data?.data ?? []);
          totalItems(response.data?.count);
          itemsPerPage(10);
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

  Future getInfluncerApprovalDetails(String id) async {
    try {
      final RepoResponse<GenericResponse> response =
          await repository.getAdminApproval(id);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          SnackbarHelper.showSnackbar(response.data?.message);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future patchsuggestchangeDetails(String id, BuildContext context) async {
    Map<String, dynamic> data = {
      "change": suggestionTextController.text,
    };
    try {
      final RepoResponse<GenericResponse> response =
          await repository.suggestChanges(id, data);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          SnackbarHelper.showSnackbar(response.data?.message);
          Navigator.of(context).pop();
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future getCourseOverviewDetails(String id) async {
    try {
      final RepoResponse<CourseOverviewResponse> response =
          await repository.getCourseOverview(id);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          courseOverview(response.data?.data);
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

  Future getUserAllCourses() async {
    try {
      final RepoResponse<InfluencerCourseResponse> response =
          await repository.getUserAllCourses();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          userAllCourses(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future getUserCourseOverviewDetails(String id) async {
    try {
      final RepoResponse<CourseOverviewResponse> response =
          await repository.getUserCourseOverview(id);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          userCourseOverview(response.data?.data);
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

  Future getUserMyCoursesDetails() async {
    try {
      final RepoResponse<UserMyCoursesResponse> response =
          await repository.getUserMyCourses();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          userMyCourses(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future purchaseCourseApi(Map<String, dynamic> data) async {
    try {
      final RepoResponse<GenericResponse> response =
          await repository.purchaseCourse(data);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {}
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future courseRatingApi(
      Map<String, dynamic> data, String? courseId, Function onSuccess) async {
    try {
      final RepoResponse<GenericResponse> response =
          await repository.ratingCourse(data, courseId);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          onSuccess.call();
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
