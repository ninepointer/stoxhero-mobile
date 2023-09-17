import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class MarginXBinding implements Bindings {
  @override
  void dependencies() => Get.put(MarginXController());
}

class MarginXController extends BaseController<MarginXRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final segmentedControlValue = 0.obs;

  final upComingMarginXList = <UpcomingMarginX>[].obs;
  final liveMarginXList = <LiveMarginX>[].obs;
  final completedMarginXList = <CompletedMarginX>[].obs;
  final completedMarginXOrdersList = <CompletedMarginXOrders>[].obs;
  final selectedQuantity = 50.obs;
  final contestWatchlistIds = <int>[].obs;
  final selectedWatchlistIndex = RxInt(-1);
  Future loadData() async {
    await getUpComingMarginXList();
    await getLiveMarginXList();
    await getCompletedMarginXList();
  }

  Color getValueColor(dynamic value) {
    if (value != null) {
      num number = value is int || value is double ? value : num.parse(value);
      if (number > 0) {
        return AppColors.success;
      } else if (number < 0) {
        return AppColors.danger;
      } else if (number == 0) {
        return AppColors.white;
      }
    }
    return AppColors.white;
  }

  void handleSegmentChange(int val) {
    changeSegment(val);
  }

  void changeSegment(int val) {
    segmentedControlValue.value = val;
  }

  Future getUpComingMarginXList() async {
    isLoading(true);
    try {
      final RepoResponse<UpComingMarginXListResponse> response =
          await repository.getUpComingMarginXList();
      if (response.data != null) {
        upComingMarginXList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getLiveMarginXList() async {
    isLoading(true);
    try {
      final RepoResponse<LiveMarginxListResponse> response = await repository.getLiveMarginXList();
      if (response.data != null) {
        liveMarginXList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getCompletedMarginXList() async {
    isLoading(true);
    try {
      final RepoResponse<CompletedMarginxListResponse> response =
          await repository.getCompletedMarginXList();
      if (response.data != null) {
        completedMarginXList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getCompletedMarginXOrders(String? id) async {
    isLoading(true);
    try {
      final RepoResponse<CompletedMarginXOrdersResponse> response =
          await repository.getCompletedMarginXOrders(id);
      if (response.data != null) {
        completedMarginXOrdersList(response.data?.data ?? []);
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
