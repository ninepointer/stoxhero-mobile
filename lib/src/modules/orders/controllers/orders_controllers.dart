import 'dart:developer';

import 'package:get/get.dart';
import 'package:stoxhero/src/base/base.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';

class OrdersBinding implements Bindings {
  @override
  void dependencies() => Get.put(OrdersController());
}

class OrdersController extends BaseController<OrdersRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final segmentedControlValue = 0.obs;

  final infinityTradeTodaysOrdersList = <InfinityTradeOrder>[].obs;
  final infinityTradeAllOrdersList = <InfinityTradeOrder>[].obs;

  final tenxTradeTodaysOrdersList = <TenxTradeOrder>[].obs;
  final tenxTradeAllOrdersList = <TenxTradeOrder>[].obs;
  final tenxTrade = TenxTradeOrder().obs;
  final virtualTradeTodaysOrdersList = <VirtualTradeOrder>[].obs;
  final virtualTradeAllOrdersList = <VirtualTradeOrder>[].obs;
  final tenXSubscription = <TenXSubscription>[].obs;
  final tenXSub = TenXSubscription().obs;
  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void changeSegment(int val) {
    segmentedControlValue.value = val;
  }

  void handleSegmentChange(int val) {
    changeSegment(val);
  }

  void loadData() async {
    loadUserDetails();
    if (userDetailsData.designation == AppConstants.equityTraderType) {
      await getInfinityTradeTodaysOrdersList();
      await getInfinityTradeAllOrdersList();
    } else {
      await getTenxTradeTodaysOrdersList();
      await getTenxTradeAllOrdersList();
      await getTenXSubscriptionList();
    }

    await getVirtualTradeTodaysOrdersList();
    await getVirtualTradeAllOrdersList();
  }

  Future getInfinityTradeTodaysOrdersList() async {
    isLoading(true);
    try {
      final RepoResponse<InfinityTradeOrdersListResponse> response =
          await repository.getInfinityTradeTodaysOrdersList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          infinityTradeTodaysOrdersList(response.data?.data ?? []);
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

  Future getInfinityTradeAllOrdersList() async {
    isLoading(true);
    try {
      final RepoResponse<InfinityTradeOrdersListResponse> response =
          await repository.getInfinityTradeAllOrdersList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          infinityTradeAllOrdersList(response.data?.data ?? []);
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

  Future getTenxTradeTodaysOrdersList() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradeOrdersListResponse> response =
          await repository.getTenxTradeTodaysOrdersList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxTradeTodaysOrdersList(response.data?.data ?? []);
        } else {
          SnackbarHelper.showSnackbar(response.error?.message);
        }
      } else {
        // Data not found, display a message
        SnackbarHelper.showSnackbar("Data is not available");
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

  Future getTenxTradeAllOrdersList() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradeOrdersListResponse> response =
          await repository.getTenxTradeAllOrdersList(
        tenxTrade.value.sId,
        tenXSub.value.userPurchaseDetail?[0].subscribedOn,
        tenXSub.value.userPurchaseDetail?[0].expiredBy,
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxTradeAllOrdersList(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log("Tenx: ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getVirtualTradeTodaysOrdersList() async {
    isLoading(true);
    try {
      final RepoResponse<VirtualTradeOrdersListResponse> response =
          await repository.getVirtualTradeTodaysOrdersList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          virtualTradeTodaysOrdersList(response.data?.data ?? []);
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

  Future getVirtualTradeAllOrdersList() async {
    isLoading(true);
    try {
      final RepoResponse<VirtualTradeOrdersListResponse> response =
          await repository.getVirtualTradeAllOrdersList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          virtualTradeAllOrdersList(response.data?.data ?? []);
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

  Future getTenXSubscriptionList() async {
    isLoading(true);
    try {
      final RepoResponse<TenXSubscriptionResponse> response =
          await repository.getTenXSubscriptionList();
      if (response.data != null) {
        if (response.data?.message?.toLowerCase() == "success") {
          tenXSubscription(response.data?.data ?? []);
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
}
