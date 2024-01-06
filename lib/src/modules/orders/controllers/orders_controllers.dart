import 'dart:developer';

import 'package:get/get.dart';
import 'package:stoxhero/src/base/base.dart';
import 'package:intl/intl.dart';
import '../../../core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/data.dart';

class OrdersBinding implements Bindings {
  @override
  void dependencies() => Get.put(OrdersController());
}

class OrdersController extends BaseController<OrdersRepository> {
  final ScrollController _scrollController = ScrollController();
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  // final startDateTextController = TextEditingController();
  // final endDateTextController = TextEditingController();

  final currentPage = 0.obs;
  final totalItems = 0.obs;
  final itemsPerPage = 0.obs;
  final isLoadingMore = false.obs;

  final stockCurrentPage = 0.obs;
  final stockTotalItems = 0.obs;
  final stockItemsPerPage = 0.obs;
  final isStockLoadingMore = false.obs;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final selectedTabBarIndex = 0.obs;
  final selectedSecondTabBarIndex = 0.obs;
  final segmentedControlValue = 0.obs;
  final equitySegmentedControlValue = 0.obs;
  final selectedItem1 = ''.obs;
  final selectedItem2 = ''.obs;
  final dropdownItems1 = <String>[].obs;
  final dropdownItems2 = <String>[].obs;

  final tenxTradeTodaysOrdersList = <TenxTradeOrder>[].obs;
  final tenxTradeAllOrdersList = <TenxTradeOrder>[].obs;
  final tenxTrade = TenxTradeOrder().obs;
  final virtualTradeTodaysOrdersList = <VirtualTradeOrder>[].obs;
  final virtualTradeAllOrdersList = <VirtualTradeOrder>[].obs;
  final stocksTradeAllOrdersList = <StocksAllOrderData>[].obs;
  final stocksTradeTodayOrdersList = <StocksAllOrderData>[].obs;
  final tenXSubscription = <TenXSubscription>[].obs;
  final selectedTenXSub = TenXSubscription().obs;
  final selectedTenxSubDate = UserPurchaseDetail().obs;
  final selectedTenxSubDatesList = <UserPurchaseDetail>[].obs;

  void loadUserDetails() {
    userDetails(AppStorage.getUserDetails());
  }

  void changeSegment(int val) => segmentedControlValue.value = val;
  void handleSegmentChange(int val) => changeSegment(val);

  void equityChangeSegment(int val) => equitySegmentedControlValue.value = val;
  void equityHandleSegmentChange(int val) => equityChangeSegment(val);

  void changeTabBarIndex(int val) => selectedTabBarIndex.value = val;

  void loadData() async {
    loadUserDetails();
    // await getTenxTradeAllOrdersList();
    // await getTenxTradeTodaysOrdersList();
    await getTenXSubscriptionList();
    await getVirtualTradeTodaysOrdersList();
    await getVirtualTradeAllOrdersList();
    await getStocksTradeAllOrdersList();
    await getStocksTradeTodaysOrdersList();
  }

  void loadMoreOrders() {
    if (!isLoadingMore.value) {
      isLoadingMore.value = true;
      currentPage.value++;
      if (itemsPerPage.value == 0) {
        isLoadingMore.value = false;
        return;
      }
      final lastPage = (totalItems.value / itemsPerPage.value).ceil();
      print("lastpage ${lastPage} ${totalItems.value} ${itemsPerPage.value}");
      if (currentPage.value >= lastPage) {
        isLoadingMore.value = true;
      } else {
        getVirtualTradeAllOrdersList();
      }
    }
  }

  void stocksLoadMoreOrders() {
    if (!isStockLoadingMore.value) {
      isStockLoadingMore.value = true;
      stockCurrentPage.value++;
      if (stockItemsPerPage.value == 0) {
        isStockLoadingMore.value = false;
        return;
      }

      final lastPage = (stockTotalItems.value / stockItemsPerPage.value).ceil();
      if (stockCurrentPage.value < lastPage) {
        getStocksTradeAllOrdersList();
      } else {
        isStockLoadingMore.value = false;
      }
    }
  }

  void updateTenxSubDateList() {
    selectedTenxSubDatesList.clear();
    selectedTenxSubDatesList
        .addAll(selectedTenXSub.value.userPurchaseDetail?.toList() ?? []);
    if (selectedTenxSubDatesList.isNotEmpty)
      selectedTenxSubDate(selectedTenxSubDatesList.first);
  }

  List<String> populateDropdownItems(List<TenXSubscription> tenXSub) {
    List<String> result = [];
    for (var sub in tenXSub) {
      dropdownItems1.add(sub.subscriptionName.toString());
    }
    dropdownItems1.assignAll(result);
    return result;
  }

  Future getTenxTradeTodaysOrdersList() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradeOrdersListResponse> response =
          await repository.getTenxTradeTodaysOrdersList(
        selectedTenXSub.value.subscriptionId,
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxTradeTodaysOrdersList(response.data?.data ?? []);
        } else {
          SnackbarHelper.showSnackbar(response.error?.message);
        }
      } else {
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
    print(selectedTenXSub.toJson());
    isLoading(true);
    try {
      final RepoResponse<TenxTradeOrdersListResponse> response =
          await repository.getTenxTradeAllOrdersList(
        selectedTenXSub.value.subscriptionId,
        selectedTenXSub.value.userPurchaseDetail?[0].subscribedOn,
        selectedTenXSub.value.userPurchaseDetail?[0].expiredOn,
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
    try {
      isLoadingMore.value = true;
      int skip = currentPage.value * itemsPerPage.value;
      print("skipskip ${skip} ${itemsPerPage.value} ${currentPage.value}");
      Map<String, dynamic> query = {
        "skip": skip,
        "limit": itemsPerPage.value,
      };
      final RepoResponse<VirtualTradeOrdersListResponse> response =
          await repository.getVirtualTradeAllOrdersList(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          virtualTradeAllOrdersList.addAll(response.data?.data ?? []);
          totalItems(response.data?.count);
          itemsPerPage(20);
          int remainingItem =
              (response.data?.count ?? 0) - (virtualTradeAllOrdersList.length);
          if (remainingItem < itemsPerPage.value) {
            itemsPerPage(remainingItem);
          }
          print(
              "tottalitems ${totalItems.value} ${virtualTradeAllOrdersList.length}");
          print(
              "virtualTradeAllOrdersList ${virtualTradeAllOrdersList.toJson()}");
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isLoadingMore.value = false;
    }
  }

//gdrsgdr
//rhtrh
  Future getStocksTradeTodaysOrdersList() async {
    isLoading(true);
    try {
      final RepoResponse<StocksAllOrderResponse> response =
          await repository.getStocksTradeTodaysOrdersList();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          stocksTradeTodayOrdersList(response.data?.data ?? []);
          print("stocksTradeOrdersList ${stocksTradeTodayOrdersList.toJson()}");
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

  Future getStocksTradeAllOrdersList() async {
    try {
      isStockLoadingMore.value = true;
      int skip = stockCurrentPage.value * stockItemsPerPage.value;
      Map<String, dynamic> query = {
        "skip": skip,
        "limit": stockItemsPerPage.value,
      };
      final RepoResponse<StocksAllOrderResponse> response =
          await repository.getStocksTradeAllOrdersList(query);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          stocksTradeAllOrdersList.addAll(response.data?.data ?? []);

          stockTotalItems(response.data?.count);
          stockItemsPerPage(10);
          int remainingItem =
              (response.data?.count ?? 0) - (stocksTradeAllOrdersList.length);
          if (remainingItem < stockItemsPerPage.value) {
            stockItemsPerPage(remainingItem);
            isStockLoadingMore.value = false;
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isStockLoadingMore.value = false;
    }
  }
//rhrreh
//rhrhbg

  Future getTenXSubscriptionList() async {
    isLoading(true);
    try {
      final RepoResponse<TenXSubscriptionResponse> response =
          await repository.getTenXSubscriptionList();
      if (response.data != null) {
        tenXSubscription.clear();
        tenXSubscription(response.data?.data ?? []);
        if (tenXSubscription.isNotEmpty)
          selectedTenXSub(tenXSubscription.first);
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
