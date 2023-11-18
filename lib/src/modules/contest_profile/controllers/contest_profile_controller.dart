import 'dart:developer';

import '../../../app/app.dart';

class ContestProfileBinding implements Bindings {
  @override
  void dependencies() => Get.put(ContestProfileController());
}

class ContestProfileController extends BaseController<ContestProfileRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final contestProfileDataList = <ContestProfile>[].obs;
  final weeklyTopPerformer = <WeeklyTopPerformers>[].obs;

  void loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    // await getContestProfileData();
    await getWeeklyTopPerformer();
  }

  Future getContestProfileData(String? id) async {
    final RepoResponse<ContestProfileResponse> response = await repository.getContestProfile(id);
    try {
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          contestProfileDataList(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future getWeeklyTopPerformer() async {
    final RepoResponse<WeeklyTopPerformersListResponse> response = await repository.getWeeklyTopPerformer();
    try {
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          weeklyTopPerformer(response.data?.data ?? []);
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
