import 'dart:developer';

import '../../../app/app.dart';

class ContestProfileBinding implements Bindings {
  @override
  void dependencies() => Get.put(ContestProfileController());
}

class ContestProfileController
    extends BaseController<ContestProfileRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final isProfileLoading = false.obs;
  bool get isProfileLoadingStatus => isProfileLoading.value;

  final isWeeklyLoading = false.obs;
  bool get isWeeklyLoadingStatus => isWeeklyLoading.value;

  final contestProfileDataList = <ContestProfile>[].obs;
  final contestProfileData = ContestProfile().obs;

  final weeklyTopPerformer = <WeeklyTopPerformers>[].obs;
  final weeklyTopPerformerFullList = <WeeklyTopPerformers>[].obs;

  final startOfWeek = ''.obs;
  final endOfWeek = ''.obs;

  void loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getWeeklyTopPerformer();
    // await getWeeklyTopPerformerFullList();
  }

  Future getContestProfileData(String? id) async {
    isProfileLoading(true);
    contestProfileDataList.clear();
    contestProfileData(ContestProfile());
    final RepoResponse<ContestProfileResponse> response =
        await repository.getContestProfile(
      id,
    );
    try {
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          contestProfileDataList(response.data?.data ?? []);
          contestProfileData(response.data?.data?.first);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isProfileLoading(false);
  }

  Future getWeeklyTopPerformer() async {
    isWeeklyLoading(true);
    final RepoResponse<WeeklyTopPerformersListResponse> response =
        await repository.getWeeklyTopPerformer();
    try {
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          weeklyTopPerformer(response.data?.data ?? []);
          log('weeklytopperfomer $weeklyTopPerformer');
          startOfWeek(response.data?.startOfWeek);
          endOfWeek(response.data?.endOfWeek);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWeeklyLoading(false);
  }

  Future getWeeklyTopPerformerFullList() async {
    isWeeklyLoading(true);
    final RepoResponse<WeeklyTopPerformersListResponse> response =
        await repository.getWeeklyTopPerformerFullList();
    try {
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          weeklyTopPerformerFullList(response.data?.data ?? []);
          startOfWeek(response.data?.startOfWeek);
          endOfWeek(response.data?.endOfWeek);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWeeklyLoading(false);
  }

  num getArenasPlayed() {
    num arenasPlayed = 0;
    arenasPlayed = contestProfileDataList.length;
    return arenasPlayed;
  }

  num getArenasWon() {
    num arenasWon = 0;
    contestProfileDataList.forEach((contest) {
      if (contest.payout! > 0) {
        arenasWon += 1;
      }
    });
    return arenasWon;
  }

  num getEarnings() {
    num earnings = 0;
    contestProfileDataList.forEach((contest) {
      if (contest.payout! > 0) {
        earnings += contest.finalPayout!;
      }
    });

    return earnings;
  }

  num getStrikeRate() {
    num strikeRate = 0;
    num contestsWon = getArenasWon();
    num totalContests = getArenasPlayed();
    strikeRate = contestsWon / totalContests * 100;
    return strikeRate;
  }
}
