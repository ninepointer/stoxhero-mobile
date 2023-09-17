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
  final segmentedControlValue = 0.obs;

  final Rx<ActiveReferral?> activeReferrals = ActiveReferral().obs;
  final referralsLeaderboardList = <LeaderboardUserDetails>[].obs;
  final earnings = EarningData().obs;
  final myReferralsList = <MyReferralData>[].obs;

  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  void loadData() async {
    loadUserDetails();
    getMyEarnings();
    getActiveReferrals();
    getMyReferrals();
    getReferralsLeaderboard();
  }

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void changeSegment(int val) {
    segmentedControlValue.value = val;
  }

  void handleSegmentChange(int val) {
    changeSegment(val);
  }

  Future getMyEarnings() async {
    isLoading(true);
    try {
      final RepoResponse<EarningsResponse> response = await repository.getMyEarnings();
      if (response.data != null) {
        earnings(response.data?.data ?? EarningData());
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
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

  Future getMyReferrals() async {
    isLoading(true);
    try {
      var userDetails = AppStorage.getUserDetails();
      final RepoResponse<MyReferralsResponse> response =
          await repository.getMyReferrals(userDetails.sId ?? '');
      if (response.data != null) {
        myReferralsList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getReferralsLeaderboard() async {
    isLoading(true);
    try {
      final RepoResponse<ReferralsLeaderboardResponse> response =
          await repository.getReferralsLeaderboard();
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
