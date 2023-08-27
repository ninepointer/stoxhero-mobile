import 'dart:developer';

import 'package:get/get.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class ContestBinding implements Bindings {
  @override
  void dependencies() => Get.put(ContestController());
}

class ContestController extends BaseController<ContestRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final upComingContestList = <UpComingContest>[].obs;
  final premiumContestList = <UpComingContest>[].obs;
  final freeContestList = <UpComingContest>[].obs;
  final tempCompletedContestList = <CompletedContest>[].obs;
  final completedContestList = <CompletedContest>[].obs;
  final completedContestPnlList = <CompletedContestPnl>[].obs;

  Future loadData() async {
    await getUpComingContestList();
    await getCompletedContestList();
    await getCompletedContestPnlList();
  }

  Future getUpComingContestList() async {
    isLoading(true);
    try {
      final RepoResponse<UpComingContestListResponse> response = await repository.getUpComingContestList();
      if (response.data != null) {
        upComingContestList(response.data?.data ?? []);
        if (upComingContestList.isNotEmpty) {
          freeContestList.clear();
          premiumContestList.clear();

          upComingContestList.forEach((contest) {
            (contest.entryFee == null || contest.entryFee == 0)
                ? freeContestList.add(contest)
                : premiumContestList.add(contest);
          });
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

  Future getCompletedContestList() async {
    isLoading(true);
    try {
      final RepoResponse<CompletedContestListResponse> response = await repository.getCompletedContestList();
      if (response.data != null) {
        tempCompletedContestList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getCompletedContestPnlList() async {
    isLoading(true);
    try {
      final RepoResponse<CompletedContestPnlListResponse> response = await repository.getCompletedContestPnlList();
      if (response.data != null) {
        List<CompletedContest> tempList = [];
        completedContestPnlList(response.data?.data ?? []);
        if (tempCompletedContestList.isNotEmpty && completedContestPnlList.isNotEmpty) {
          for (var pnl in completedContestPnlList) {
            for (var contest in tempCompletedContestList) {
              if (pnl.contestId == contest.id) tempList.add(contest);
            }
          }
        }
        completedContestList(tempList);
        log('tempCompletedContestList : ${completedContestList.length.toString()}');
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
