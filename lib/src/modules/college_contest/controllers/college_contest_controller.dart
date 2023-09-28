import 'dart:developer';

import 'package:get/get.dart';
import 'package:stoxhero/src/data/models/response/upcoming_college_contest_list_response.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../data/models/response/completed_college_contest_list_response.dart';

class CollegeContestBinding implements Bindings {
  @override
  void dependencies() => Get.put(CollegeContestController());
}

class CollegeContestController extends BaseController<ContestRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final segmentedControlValue = 0.obs;

  final upComingContestList = <UpComingCollegeContest>[].obs;
  final tempCompletedContestList = <CompletedCollegeContest>[].obs;
  final premiumCompletedContestList = <CompletedCollegeContest>[].obs;
  final freeCompletedContestList = <CompletedCollegeContest>[].obs;
  final collegeContestLeaderboardList = <CollegeContestLeaderboard>[].obs;
  final completedCollegeContestList = <CompletedCollegeContest>[].obs;
  final premiumContestList = <UpComingCollegeContest>[].obs;
  final freeContestList = <UpComingCollegeContest>[].obs;
  final completedContestPnlList = <CompletedContestPnl>[].obs;
  final contestTodaysOrdersList = <ContestOrderList>[].obs;
  final liveCollegeContestList = <LiveCollegeContest>[].obs;

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getCollegeContestLeaderboardList();
    await getCompletedCollegeContestList();
    await getUpComingCollegeContestList();
    await getCompletedContestPnlList();
    await getLiveCollegeContestList();
  }

  void handleSegmentChange(int val) {
    changeSegment(val);
  }

  void changeSegment(int val) {
    segmentedControlValue.value = val;
  }

  Future getCollegeContestLeaderboardList() async {
    isLoading(true);
    try {
      final RepoResponse<CollegeContestLeaderboardResponse> response =
          await repository.getCollegeContestLeaderboardList();
      if (response.data != null) {
        collegeContestLeaderboardList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('College Leaderboard: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  // Future getCompletedCollegeContestList() async {
  //   isLoading(true);
  //   try {
  //     final RepoResponse<CompletedCollegeContestListResponse> response =
  //         await repository.getCompletedCollegeContestList();
  //     if (response.data != null) {
  //       completedCollegeContestList(response.data?.data ?? []);
  //     } else {
  //       SnackbarHelper.showSnackbar(response.error?.message);
  //     }
  //   } catch (e) {
  //     log('Completed college contest: ${e.toString()}');
  //     SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
  //   }
  //   isLoading(false);
  // }

  Future getCompletedCollegeContestList() async {
    isLoading(true);
    try {
      final RepoResponse<CompletedCollegeContestListResponse> response =
          await repository.getCompletedCollegeContestList();
      if (response.data != null) {
        tempCompletedContestList(response.data?.data ?? []);
        if (tempCompletedContestList.isNotEmpty) {
          freeCompletedContestList.clear();
          premiumCompletedContestList.clear();

          tempCompletedContestList.forEach((contest) {
            (contest.entryFee == null || contest.entryFee == 0)
                ? freeCompletedContestList.add(contest)
                : premiumCompletedContestList.add(contest);
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

  Future getCompletedContestPnlList() async {
    isLoading(true);
    try {
      final RepoResponse<CompletedContestPnlListResponse> response =
          await repository.getCompletedContestPnlList();
      if (response.data != null) {
        List<CompletedCollegeContest> tempList = [];
        completedContestPnlList(response.data?.data ?? []);
        if (tempCompletedContestList.isNotEmpty && completedContestPnlList.isNotEmpty) {
          // for (var pnl in completedContestPnlList) {
          //   for (var contest in tempCompletedContestList) {}
          // }
        }
        completedCollegeContestList(tempList);
        log('tempCompletedContestList : ${completedCollegeContestList.length.toString()}');
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getUpComingCollegeContestList() async {
    isLoading(true);
    try {
      final RepoResponse<UpComingCollegeContestListResponse> response =
          await repository.getUpComingCollegeContestList();
      if (response.data != null) {
        upComingContestList(response.data?.data ?? []);
        log('upComingContestList : ${upComingContestList.length}');
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

  Future getContestOrderList(String? id) async {
    isLoading(true);
    try {
      final RepoResponse<ContestOrderResponse> response = await repository.getContestOrderList(id);
      if (response.data != null) {
        contestTodaysOrdersList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Orders: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getLiveCollegeContestList() async {
    isLoading(true);
    try {
      final RepoResponse<LiveCollegeContestListResponse> response =
          await repository.getLiveCollegeContestList();
      if (response.data != null) {
        liveCollegeContestList(response.data?.data ?? []);
        log('liveCollegeContestList : ${liveCollegeContestList.length}');
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
