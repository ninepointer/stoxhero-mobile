import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/models/response/contest_instrument_list_response.dart';
import 'package:uuid/uuid.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../data/models/response/contest_instrument_trade_details_list_response.dart';

class ContestBinding implements Bindings {
  @override
  void dependencies() => Get.put(ContestController());
}

class ContestController extends BaseController<ContestRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final segmentedControlValue = 0.obs;

  final searchTextController = TextEditingController();
  final upComingContestList = <UpComingContest>[].obs;
  final premiumContestList = <UpComingContest>[].obs;
  final freeContestList = <UpComingContest>[].obs;
  final tempCompletedContestList = <CompletedContest>[].obs;
  final premiumCompletedContestList = <CompletedContest>[].obs;
  final freeCompletedContestList = <CompletedContest>[].obs;
  final completedContestList = <CompletedContest>[].obs;
  final completedContestPnlList = <CompletedContestPnl>[].obs;
  final contestLeaderboardList = <ContestLeaderboard>[].obs;
  final contestTodaysOrdersList = <ContestOrderList>[].obs;
  final completedContestOrdersList = <CompletedContestOrder>[].obs;
  final liveContestList = <LiveContest>[].obs;
  final livePremiumContestList = <LiveContest>[].obs;
  final liveFreeContestList = <LiveContest>[].obs;
  final contestWatchList = <ContestWatchList>[].obs;
  final contestPositionsList = <ContestPosition>[].obs;
  final contestPortfolio = ContestCreditData().obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;

  final contestInstruments = <ContestInstrument>[].obs;

  final contestInstrumentTradeDetails = <ContestInstrumentTradeDetails>[].obs;
  final contestWatchlistIds = <int>[].obs;
  final selectedWatchlistIndex = RxInt(-1);
  final walletBalance = RxNum(0);
  final selectedQuantity = 0.obs;
  final lotsValueList = <int>[0].obs;
  final selectedContest = UpComingContest().obs;
  final selectedContestId = ''.obs;
  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getUpComingContestList();
    await getCompletedContestList();
    await getCompletedContestPnlList();
    await getLiveContestList();
  }

  Future loadTradingData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getLiveContestList();
    await socketConnection();
  }

  num calculateGrossPNL(num ltp, num avg, int lots) {
    num position = ltp - avg;
    num grossPNL = position * lots;
    return grossPNL;
  }

  List<int> generateLotsList({String? type}) {
    List<int> result = [];
    switch (type) {
      case 'NIFTY50':
        for (int i = 50; i <= 1800; i += 50) result.add(i);
        break;
      case 'BANKNIFTY':
        for (int i = 15; i <= 900; i += 15) result.add(i);
        break;
      case 'FINNIFTY':
        for (int i = 40; i <= 880; i += 40) result.add(i);
        break;
    }
    selectedQuantity.value = result[0];
    lotsValueList.assignAll(result);
    return result;
  }

  void calculateUserWalletAmount() async {
    num amount = 0;
    var response = await Get.find<WalletRepository>().getWalletTransactionsList();
    var list = response.data?.data?.transactions ?? [];
    for (var e in list) amount += e.amount ?? 0;
    walletBalance(amount);
  }

  void calculateTotalPositionValues() {
    int totalLots = 0;
    num totalBrokerage = 0;
    num totalGross = 0;
    num totalNet = 0;

    for (var position in contestPositionsList) {
      log('postion : ${position.toJson()}');
      totalLots += position.lots ?? 0;
      totalBrokerage += position.brokerage ?? 0;
      totalGross += position.amount ?? 0;
      totalNet += position.amount ?? 0;
    }

    tenxTotalPositionDetails(TenxTotalPositionDetails(
      lots: totalLots,
      brokerage: totalBrokerage,
      gross: totalGross,
      net: totalNet,
    ));

    log('ContestTotalPositionDetails : ${tenxTotalPositionDetails.toJson()}');
  }

  Color getValueColor(dynamic value) {
    if (value != null) {
      num number = value is int || value is double ? value : num.parse(value);
      if (number < 0) {
        return AppColors.success;
      } else if (number > 0) {
        return AppColors.danger;
      } else if (number == 0) {
        return AppColors.black;
      }
    }
    return AppColors.white;
  }

  void handleSegmentChange(int val) {
    changeSegment(val);
  }

  void changeSegment(int val) {
    segmentedControlValue.value = val;
  }

  void gotoSearchInstrument() {
    searchTextController.text = 'Nifty';
    Get.toNamed(AppRoutes.tenxSearchSymbol);
  }

  num getInstrumentLastPrice(int instID, int exchID) {
    if (contestInstrumentTradeDetails.isNotEmpty) {
      int index = contestInstrumentTradeDetails.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return 0;
      num price = contestInstrumentTradeDetails[index].lastPrice ?? 0;

      return price;
    } else {
      return 0;
    }
  }

  String getInstrumentChanges(int instID, int exchID) {
    if (contestInstrumentTradeDetails.isNotEmpty) {
      int index = contestInstrumentTradeDetails.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price = contestInstrumentTradeDetails[index].change?.toString();
      // log('Price ${contestInstrumentTradeDetails[index].lastPrice!.toString()}');
      return FormatHelper.formatNumbers(price);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future socketConnection() async {
    List<ContestInstrumentTradeDetails>? tempList = [];
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
        // print(data);
        // log('Socket : index-tick $data');
      });
      socket.on('tick-room', (data) {
        // log('Socket : tick-room $data');
        tempList = ContestInstrumentTradeDetailsListResponse.fromJson(data).data ?? [];
        tempList?.forEach((element) {
          if (contestInstrumentTradeDetails
              .any((obj) => obj.instrumentToken == element.instrumentToken)) {
            int index = contestInstrumentTradeDetails.indexWhere(
              (stock) => stock.instrumentToken == element.instrumentToken,
            );
            contestInstrumentTradeDetails.removeAt(index);
            contestInstrumentTradeDetails.insert(index, element);
          } else {
            contestInstrumentTradeDetails.add(element);
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

  Future placeContestOrder(TransactionType type, ContestInstrument inst) async {
    Get.back();
    isLoading(true);
    ContestPlaceOrderRequest data = ContestPlaceOrderRequest(
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
      userId: userDetails.value.email,
      instrumentToken: inst.instrumentToken,
      trader: userDetails.value.sId,
      paperTrade: false,
      contestId: inst.sId,
    );
    log('placeContestOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.placeOrder(
        data.toJson(),
      );
      log(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successfull');
        await getContestPositions(contestPositionsList[0].iId?.toString());
        await getContestPortfolio(contestPortfolio.value.batch);
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

  Future getUpComingContestList() async {
    isLoading(true);
    try {
      final RepoResponse<UpComingContestListResponse> response =
          await repository.getUpComingContestList();
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
      final RepoResponse<CompletedContestListResponse> response =
          await repository.getCompletedContestList();
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

  Future getContestLeaderboardList() async {
    isLoading(true);
    try {
      final RepoResponse<ContestLeaderboardResponse> response =
          await repository.getContestLeaderboardList();
      if (response.data != null) {
        contestLeaderboardList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Leaderboard: ${e.toString()}');
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

  Future getLiveContestList() async {
    isLoading(true);
    try {
      final RepoResponse<LiveContestListResponse> response = await repository.getLiveContestList();
      if (response.data != null) {
        liveContestList(response.data?.data ?? []);
        if (liveContestList.isNotEmpty) {
          liveFreeContestList.clear();
          livePremiumContestList.clear();

          liveContestList.forEach((contest) {
            (contest.entryFee == null || contest.entryFee == 0)
                ? liveFreeContestList.add(contest)
                : livePremiumContestList.add(contest);
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

  Future getContestPortfolio(String? id) async {
    isLoading(true);
    try {
      final RepoResponse<ContestPortfolioResponse> response =
          await repository.getContestPortfolio(id);
      if (response.data != null) {
        contestPortfolio(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log("port ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getContestWatchList(bool? isNifty, bool? isBankNifty, bool? isFinNifty) async {
    isLoading(true);
    try {
      final RepoResponse<ContestWatchListResponse> response =
          await repository.getContestWatchList(isNifty, isBankNifty, isFinNifty);
      if (response.data != null) {
        if (response.data?.data! != null) {
          contestWatchList.clear();
          contestWatchlistIds.clear();
          contestWatchList(response.data?.data ?? []);
          for (var element in contestWatchList) {
            contestWatchlistIds
                .add(element.instrumentToken ?? element.exchangeInstrumentToken ?? 0);
          }
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log("watch ${e.toString()}");
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getContestPositions(String? id) async {
    isLoading(true);
    try {
      final RepoResponse<ContestPositionListResponse> response =
          await repository.getContestPositions(id);
      if (response.data != null) {
        if (response.data?.data! != null) {
          contestPositionsList(response.data?.data ?? []);
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

  Future getCompletedContestOrders(String? id) async {
    isLoading(true);
    try {
      final RepoResponse<CompletedContestOrdersResponse> response =
          await repository.getCompletedContestOrders(
        id,
      );
      if (response.data != null) {
        completedContestOrdersList(response.data?.data ?? []);
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
      final RepoResponse<ContestInstrumentListResponse> response =
          await repository.searchInstruments(value);
      if (response.data != null) {
        if (response.data?.data! != null) {
          contestInstruments.clear();
          contestInstruments(response.data?.data ?? []);
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

  Future removeInstrument(int? instToken) async {
    isLoading(true);
    try {
      await repository.removeInstrument(instToken ?? 0);
      // if (response.data != null) {
      selectedWatchlistIndex(-1);
      contestWatchList.clear();
      contestInstruments.clear();
      await getContestWatchList(
        liveContestList[0].isNifty,
        liveContestList[0].isBankNifty,
        liveContestList[0].isFinNifty,
      );
      await searchInstruments(searchTextController.text);
      log('getVirtualTradingWatchlist : ${contestWatchList.length}');
      // } else {
      SnackbarHelper.showSnackbar('Instrument Remove');
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }
}
