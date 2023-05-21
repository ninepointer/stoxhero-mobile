import 'dart:developer';

import 'package:get/get.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

class ReferralsBinding implements Bindings {
  @override
  void dependencies() => Get.put(ReferralsController());
}

class ReferralsController extends BaseController<ReferralsRepository> {
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final Rx<ActiveReferral?> activeReferrals = ActiveReferral().obs;
  final referralsLeaderboardList = <LeaderboardUserDetails>[].obs;

  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void loadData() async {
    loadUserDetails();
    getActiveReferrals();
    getMyReferrals();
    getReferralsLeaderboard();
  }

  Future getActiveReferrals() async {
    isLoading(true);
    try {
      final RepoResponse<ActiveReferralResponse> response = await repository.getActiveReferrals();
      if (response.data != null) {
        activeReferrals((response.data?.data?[0] ?? []) as ActiveReferral?);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getMyReferrals() async {}

  Future getReferralsLeaderboard() async {
    isLoading(true);
    try {
      final RepoResponse<ReferralsLeaderboardResponse> response = await repository.getReferralsLeaderboard();
      if (response.data != null) {
        referralsLeaderboardList(response.data?.data ?? []);
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
