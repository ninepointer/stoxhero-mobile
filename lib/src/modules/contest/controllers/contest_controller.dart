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
  final completedContestList = <CompletedContest>[].obs;

  Future loadData() async {
    await getUpComingContestList();
    await getCompletedContestList();
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

        log('freeContestList : ${freeContestList.length}');
        log('premiumContestList : ${premiumContestList.length}');
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
        completedContestList(response.data?.data ?? []);
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
