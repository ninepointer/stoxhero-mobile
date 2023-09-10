import 'dart:developer';

import 'package:get/get.dart';
import 'package:stoxhero/src/data/repositories/marginx_respository.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../data/models/response/live_marginx_list_response.dart';
import '../../../data/models/response/upcoming_marginx_list_response.dart';

class MarginxBinding implements Bindings {
  @override
  void dependencies() => Get.put(MarginxController());
}

class MarginxController extends BaseController<MarginXRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final segmentedControlValue = 0.obs;

  final upComingMarginXList = <UpcomingMarginX>[].obs;
  final liveMarginXList = <LiveMarginx>[].obs;
  final completedMarginXList = <CompletedMarginx>[].obs;

  Future loadData() async {
    await getUpComingMarginXList();
    await getLiveMarginXList();
    await getCompletedMarginXList();
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
}
