import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/base/base.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stoxhero/src/modules/modules.dart';
import 'package:uuid/uuid.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';

class TenxTradingBinding implements Bindings {
  @override
  void dependencies() => Get.put(TenxTradingController());
}

class TenxTradingController extends BaseController<TenxTradingRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final searchTextController = TextEditingController();
  final selectedSubscriptionId = ''.obs;
  final selectedSubscription = TenxActiveSubscription().obs;
  final selectedQuantity = 50.obs;
  final walletBalance = RxNum(0);
  final selectedWatchlistIndex = RxInt(-1);
  final isLivePriceLoaded = false.obs;

  final tenxActiveSub = <TenxActiveSubscription>[].obs;
  final tenxWatchlist = <TenxTradingWatchlist>[].obs;
  final tenxInstruments = <TenxTradingInstrument>[].obs;
  final tenxInstrumentTradeDetailsList = <TenxTradingInstrumentTradeDetails>[].obs;
  final tenxPositionsList = <TenxTradingPosition>[].obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final tenxWatchlistIds = <int>[].obs;
  final tenxPortfolioDetails = TenxTradingPortfolioDetails().obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final userSubscriptionsIds = <String>[].obs;

  void loadUserDetails() {
    userDetails.value = AppStorage.getUserDetails();
  }

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getTenxTradingActiveSubs();
    await getTenxTradingWatclist();
    await getTenxPositionsList();
    await getTenxTradingPortfolioDetails();
    await getInstrumentLivePriceList();
    await socketConnection();
  }

  void calculateUserWalletAmount() async {
    num amount = 0;
    var response = await Get.find<WalletRepository>().getWalletTransactionsList();
    var list = response.data?.data?.transactions ?? [];
    for (var e in list) amount += e.amount ?? 0;
    walletBalance(amount);
  }

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.tenxSearchSymbol);
  }

  void calculateTotalPositionValues() {
    num totalLots = 0;
    num totalBrokerage = 0;

    for (var data in tenxPositionsList) {
      log('data : ${data.toJson()}');
      totalLots += data.lots ?? 0;
      totalBrokerage += data.brokerage ?? 0;
    }
    tenxTotalPositionDetails(TenxTotalPositionDetails(
      lots: totalLots,
      brokerage: totalBrokerage,
    ));
    log('tenxTotalPositionDetails : ${tenxTotalPositionDetails.toJson()}');
  }

  Color getValueColor(dynamic value) {
    if (value != null) {
      num number = value is int || value is double ? value : num.parse(value);
      if (number > 0) {
        return AppColors.success;
      } else if (number < 0) {
        return AppColors.danger;
      } else if (number == 0) {
        return AppColors.white;
      }
    }
    return AppColors.white;
  }

  String getInstrumentLastPrice(int instID, int exchID) {
    if (tenxInstrumentTradeDetailsList.isNotEmpty) {
      int index = tenxInstrumentTradeDetailsList.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price = tenxInstrumentTradeDetailsList[index].lastPrice?.toString();
      return FormatHelper.formatNumbers(price);
    } else {
      return FormatHelper.formatNumbers('00');
    }
  }

  String getInstrumentChanges(int instID, int exchID) {
    if (tenxInstrumentTradeDetailsList.isNotEmpty) {
      int index = tenxInstrumentTradeDetailsList.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price = tenxInstrumentTradeDetailsList[index].change?.toString();
      return FormatHelper.formatNumbers(price);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future socketConnection() async {
    List<TenxTradingInstrumentTradeDetails>? tempList = [];
    try {
      IO.Socket socket;

      socket = IO.io(AppUrls.baseURL, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
      });
      socket.connect();
      socket.onConnect((_) {
        log('Socket : Connected');
        socket.emit('userId', userDetails.value.sId);
        socket.emit('user-ticks', userDetails.value.sId);
      });
      socket.on('index-tick', (data) {
        print(data);
        log('Socket : index-tick $data');
      });
      socket.on('tick-room', (data) {
        // log('Socket : tick-room $data');
        tempList = TenxTradingInstrumentTradeDetailsListResponse.fromJson(data).data ?? [];
        tempList?.forEach((element) {
          if (tenxInstrumentTradeDetailsList.any((obj) => obj.instrumentToken == element.instrumentToken)) {
            int index = tenxInstrumentTradeDetailsList.indexWhere(
              (stock) => stock.instrumentToken == element.instrumentToken,
            );
            tenxInstrumentTradeDetailsList.removeAt(index);
            tenxInstrumentTradeDetailsList.insert(index, element);
          } else {
            tenxInstrumentTradeDetailsList.add(element);
          }
        });
      });
      socket.onDisconnect((_) => log('Socket : Disconnect'));
      socket.onConnectError((err) => log(err));
      socket.onError((err) => log(err));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future purchaseIntent() async {
    var data = {
      "purchase_intent_by": userDetails.value.sId,
      "tenXSubscription": selectedSubscriptionId.value,
    };

    try {
      await repository.postPurchaseIntent(data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future getTenxTradingActiveSubs() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingActiveResponse> response = await repository.getTenxActiveSubscriptions();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          tenxActiveSub.clear();
          userSubscriptionsIds.clear();
          tenxActiveSub(response.data?.data ?? []);
          for (var userSub in userDetails.value.subscription!) {
            if (userSub.subscriptionId != null) {
              userSubscriptionsIds.add(userSub.subscriptionId!.sId!);
            }
          }
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

  Future getTenxTradingWatclist() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingWatchlistResponse> response = await repository.getTenxWatchlist();
      if (response.data != null) {
        if (response.data?.data! != null) {
          tenxWatchlist.clear();
          tenxWatchlistIds.clear();
          tenxWatchlist(response.data?.data ?? []);
          for (var element in tenxWatchlist) {
            tenxWatchlistIds.add(element.instrumentToken ?? element.exchangeInstrumentToken ?? 0);
          }
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

  Future searchInstruments(String? value) async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingInstrumentListResponse> response = await repository.searchInstruments(value);
      if (response.data != null) {
        if (response.data?.data! != null) {
          tenxInstruments.clear();
          tenxInstruments(response.data?.data ?? []);
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

  Future getTenxPositionsList() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingPositionListResponse> response = await repository.getTenxPositions(
        selectedSubscriptionId.value,
      );
      if (response.data != null) {
        if (response.data?.data! != null) {
          tenxPositionsList(response.data?.data ?? []);
          calculateTotalPositionValues();
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

  Future getInstrumentLivePriceList() async {
    isLoading(true);
    try {
      final RepoResponse<InstrumentLivePriceListResponse> response = await repository.getInstrumentLivePrices();
      if (response.data != null) {
        if (response.data?.data! != null) {
          isLivePriceLoaded(true);
          instrumentLivePriceList(response.data?.data ?? []);
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

  Future getTenxTradingPortfolioDetails() async {
    isLoading(true);
    try {
      final RepoResponse<TenxTradingPortfolioDetailsResponse> response = await repository.getTenxPortfolioDetails(
        selectedSubscriptionId.value,
      );
      if (response.data?.data != null) {
        log('getTenxTradingPortfolioDetails');
        tenxPortfolioDetails(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getUserWalletTransactionsList() async {
    isLoading(true);
    try {
      final RepoResponse<InstrumentLivePriceListResponse> response = await repository.getInstrumentLivePrices();
      if (response.data != null) {
        if (response.data?.data! != null) {
          isLivePriceLoaded(true);
          instrumentLivePriceList(response.data?.data ?? []);
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

  Future placeTenxTradingOrder(TransactionType type, TenxTradingInstrument inst) async {
    Get.back();
    isLoading(true);
    TenxTradingPlaceOrderRequest data = TenxTradingPlaceOrderRequest(
      exchange: inst.exchange,
      symbol: inst.tradingsymbol,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      quantity: selectedQuantity.value,
      price: "",
      product: "NRML",
      orderType: "MARKET",
      triggerPrice: "",
      stopLoss: "",
      uId: Uuid().v4(),
      exchangeInstrumentToken: inst.exchangeToken,
      validity: "DAY",
      variety: "regular",
      createdBy: userDetails.value.name,
      orderId: Uuid().v4(),
      subscriptionId: selectedSubscriptionId.value,
      userId: userDetails.value.email,
      instrumentToken: inst.instrumentToken,
      trader: userDetails.value.sId,
      paperTrade: false,
      tenxTraderPath: true,
    );
    log('placeTenxTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.placeOrder(
        data.toJson(),
      );
      log(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successfull');
        await getTenxPositionsList();
        await getTenxTradingPortfolioDetails();
      } else if (response.data?.status == "Failed") {
        log(response.error!.message!.toString());
        SnackbarHelper.showSnackbar(response.error?.message);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future addInstrument(TenxTradingInstrument inst) async {
    isLoading(true);
    AddInstrumentRequest data = AddInstrumentRequest(
      instrument: inst.name,
      exchange: inst.exchange,
      status: inst.status,
      symbol: inst.tradingsymbol,
      lotSize: 25,
      instrumentToken: inst.instrumentToken,
      uId: Uuid().v4(),
      contractDate: inst.expiry,
      maxLot: 900,
      from: "TenX Trader",
      exchangeSegment: inst.segment,
      exchangeInstrumentToken: inst.exchangeToken,
    );

    log('addInstrument : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.addInstrument(
        data.toJson(),
      );
      // if (response.data?.message == "Instrument Added") {
      tenxWatchlist.clear();
      tenxInstruments.clear();
      await getTenxTradingWatclist();
      await searchInstruments(searchTextController.text);
      // } else {
      //   SnackbarHelper.showSnackbar(response.error?.message);
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future removeInstrument(int? instToken) async {
    isLoading(true);
    try {
      final RepoResponse<GenericResponse> response = await repository.removeInstrument(
        instToken ?? 0,
      );
      // if (response.data != null) {
      selectedWatchlistIndex(-1);
      tenxWatchlist.clear();
      tenxInstruments.clear();
      await getTenxTradingWatclist();
      await searchInstruments(searchTextController.text);
      log('getTenxTradingWatclist : ${tenxWatchlist.length}');
      // } else {
      //   SnackbarHelper.showSnackbar(response.error?.message);
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future purchaseSubscription() async {
    isLoading(true);
    var data = {
      "subscriptionAmount": selectedSubscription.value.discountedPrice,
      "subscriptionName": selectedSubscription.value.planName,
      "subscribedId": selectedSubscription.value.sId,
    };
    log(data.toString());
    try {
      final RepoResponse<GenericResponse> response = await repository.purchaseSubscription(
        data,
      );
      if (response.data?.status == "success") {
        Get.back();
        await Get.find<AuthController>().getUserDetails(navigate: false);
        loadUserDetails();
        await getTenxTradingActiveSubs();
        SnackbarHelper.showSnackbar('Transaction Successfull');
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
