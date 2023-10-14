import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../app/app.dart';
import '../../../data/models/response/trading_instrument_trade_details_list_response.dart';

class ContestBinding implements Bindings {
  @override
  void dependencies() => Get.put(ContestController());
}

class ContestController extends BaseController<ContestRepository> {
  late IO.Socket socket;
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final segmentedControlValue = 0.obs;
  final liveSegmentedControlValue = 0.obs;
  final upcomingSegmentedControlValue = 0.obs;
  final completedSegmentedControlValue = 0.obs;

  final searchTextController = TextEditingController();
  final upComingContestList = <UpComingContest>[].obs;
  final upComingContest = UpComingContest().obs;
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
  final liveContest = LiveContest().obs;
  final livePremiumContestList = <LiveContest>[].obs;
  final liveFreeContestList = <LiveContest>[].obs;
  final contestWatchList = <ContestWatchList>[].obs;
  final contestPositionsList = <ContestPosition>[].obs;
  final contestPortfolio = ContestCreditData().obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final contestRequest = ContestPlaceOrderRequest().obs;
  final tradingInstrumentTradeDetailsList = <TradingInstrumentTradeDetails>[].obs;
  final tradingInstruments = <TradingInstrument>[].obs;
  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;
  final selectedStringQuantity = "0".obs;
  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;

  final selectedWatchlistIndex = RxInt(-1);
  final walletBalance = RxNum(0);
  final selectedQuantity = 0.obs;
  final lotsValueList = <int>[0].obs;
  final selectedContest = UpComingContest().obs;
  final selectedContestId = ''.obs;

  final myRank = 0.obs;

  final isLivePriceLoaded = false.obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final liveLeaderboardList = <LiveContestLeaderboard>[].obs;
  final liveLeaderboard = LiveContestLeaderboard().obs;
  final completedContestLeaderboardList = <CompletedContestLeaderboardList>[].obs;
  final completedContestLeaderboard = CompletedContestLeaderboardList().obs;

  Future loadData() async {
    loadUserDetails();
    await getLiveContestList();
    await getUpComingContestList();
    await getCompletedContestList();
    await getCompletedContestPnlList();
    initSocketConnection();
  }

  Future loadUserDetails() async {
    userDetails.value = AppStorage.getUserDetails();
  }

  Future loadTradingData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getInstrumentLivePriceList();
    await getStockIndexInstrumentsList();
    await getContestWatchList();
    await getContestPositions();
    await getContestPortfolio();
    await socketIndexConnection();
    await socketConnection();
    await socketLeaderboardConnection();
    // await socketMyRankConnection();
  }

  bool isUserInterested(contest, userId) {
    if (contest.interestedUsers != null) {
      for (InterestedUsers user in contest.interestedUsers) {
        if (user.userId?.id == userId) {
          return true;
        }
      }
    }
    return false;
  }

  bool participateUser(contest, userId) {
    if (contest.participants != null) {
      for (Participants user in contest.participants) {
        if (user.userId?.sId == userId) {
          return true;
        }
      }
    }
    return false;
  }

  Future initSocketConnection() async {
    log('Socket : initSocketConnection');
    socket = IO.io(AppUrls.baseURL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    }).connect();

    socket.onConnect((_) {
      log('Socket : Connected');
      socket.emit('userId', userDetails.value.sId);
      socket.emit('user-ticks', userDetails.value.sId);
    });

    socket.onConnectError((e) => print(e));

    log('Socket Status : ${socket.connected}');
  }

  String getStockIndexName(int instId) {
    // log('instToken : $instId');
    int index = stockIndexInstrumentList.indexWhere((element) => element.instrumentToken == instId);
    return stockIndexInstrumentList[index].displayName ?? '-';
  }

  List<int> generateLotsList({String? type}) {
    List<int> result = [];

    if (type?.contains('BANK') ?? false) {
      for (int i = 15; i <= 900; i += 15) result.add(i);
    } else if (type?.contains('FIN') ?? false) {
      for (int i = 40; i <= 1800; i += 40) result.add(i);
    } else {
      for (int i = 50; i <= 1800; i += 50) result.add(i);
    }

    selectedQuantity.value = result[0];
    lotsValueList.assignAll(result);
    return result;
  }

  Future calculateUserWalletAmount() async {
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
      if (value is String) {
        if (value.contains('-')) {
          return AppColors.danger;
        } else if (value == '0') {
          return AppColors.success;
        }
      } else {
        num number = value is int || value is double ? value : num.parse(value);
        if (number > 0) {
          return AppColors.success;
        } else if (number < 0) {
          return AppColors.danger;
        } else if (number == 0) {
          return AppColors.success;
        }
      }
    }
    return AppColors.success;
  }

  int calculateSeatsLeft(int maxParticipants, int currentParticipants) {
    int seatsLeft = maxParticipants - currentParticipants;
    return seatsLeft;
  }

  num calculatePayout() {
    num npnl = calculateTotalNetPNL() * liveContest.value.payoutPercentage!;
    num payout = npnl <= 0 ? 0 : npnl / 100;
    return payout;
  }

  num calculateUserPayout(dynamic netPnl) {
    num reward = netPnl * liveContest.value.payoutPercentage!;
    num payout = reward <= 0 ? 0 : reward / 100;
    return payout;
  }

  void handleSegmentChange(int val) => changeSegment(val);
  void changeSegment(int val) => segmentedControlValue.value = val;

  void handleLiveSegmentChange(int val) => liveChangeSegment(val);
  void liveChangeSegment(int val) => liveSegmentedControlValue.value = val;

  void handleUpcomingSegmentChange(int val) => upcomingChangeSegment(val);
  void upcomingChangeSegment(int val) => upcomingSegmentedControlValue.value = val;

  void handleCompletedSegmentChange(int val) => completedChangeSegment(val);
  void completedChangeSegment(int val) => completedSegmentedControlValue.value = val;

  void gotoSearchInstrument() {
    searchTextController.text = '';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.contestSearchSymbol);
  }

  bool checkIfPurchased(UpComingContest? contest) {
    bool isPurchased = false;
    for (Participants? user in contest?.participants ?? []) {
      if (user?.userId?.sId == userDetails.value.sId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  bool checkIfLivePurchased(LiveContest? contest) {
    bool isPurchased = false;
    for (Participants? user in contest?.participants ?? []) {
      if (user?.userId?.sId == userDetails.value.sId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  num calculateGrossPNL(num avg, int lots, num ltp) {
    num pnl = 0;
    num value = (avg + (lots) * ltp);
    pnl += value;
    return pnl;
  }

  num calculateTotalGrossPNL() {
    num totalGross = 0;
    for (var position in contestPositionsList) {
      num avg = position.amount!;
      int lots = position.lots!.toInt();
      num ltp = getInstrumentLastPrice(
        position.id!.instrumentToken!,
        position.id!.exchangeInstrumentToken!,
      );

      num pnl = 0;
      num value = (avg + (lots) * ltp);
      pnl += value;
      totalGross += pnl;
    }
    return totalGross.round();
  }

  num calculateTotalNetPNL() {
    num totalNetPNL = 0;
    for (var position in contestPositionsList) {
      num avg = position.amount!;
      int lots = position.lots!.toInt();
      num ltp = getInstrumentLastPrice(
        position.id!.instrumentToken!,
        position.id!.exchangeInstrumentToken!,
      );
      num value = (avg + (lots) * ltp);
      num brokerage = position.brokerage!;
      num broker = value - brokerage;
      totalNetPNL += broker;
    }
    return totalNetPNL.round();
  }

  num calculateMargin() {
    num pnl = 0;
    num amount = 0;
    num lots = 0;
    for (var position in contestPositionsList) {
      amount += position.amount ?? 0;
      lots += position.lots ?? 0;
    }
    num openingBalance = contestPortfolio.value.totalFund ?? 0;
    pnl += openingBalance + amount;
    if (lots == 0) {
      num margin = openingBalance + calculateTotalNetPNL();
      return margin;
    } else {
      return pnl;
    }
  }

  num getInstrumentLastPrice(int instID, int exchID) {
    if (tradingInstrumentTradeDetailsList.isNotEmpty) {
      int index = tradingInstrumentTradeDetailsList.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return 0;
      num price = tradingInstrumentTradeDetailsList[index].lastPrice ?? 0;
      return price;
    } else {
      return 0;
    }
  }

  String getInstrumentChanges(int instID, int exchID) {
    if (tradingInstrumentTradeDetailsList.isNotEmpty) {
      int index = tradingInstrumentTradeDetailsList.indexWhere(
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price = tradingInstrumentTradeDetailsList[index].change?.toString();
      return FormatHelper.formatNumbers(price, showSymbol: false);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future placeContestOrder(TransactionType type, TradingInstrument inst) async {
    Get.back();
    isLoading(true);
    if (type == TransactionType.exit) {
      if (selectedStringQuantity.value.contains('-')) {
        type = TransactionType.buy;
      } else {
        type = TransactionType.sell;
      }
    }
    ContestPlaceOrderRequest data = ContestPlaceOrderRequest(
      orderType: "MARKET",
      price: "",
      product: "NRML",
      quantity: selectedQuantity.value,
      triggerPrice: "",
      battleId: liveContest.value.id,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      contestId: liveContest.value.id,
      createdBy: userDetailsData.name,
      exchange: inst.exchange,
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      marginxId: liveContest.value.id,
      orderId: Uuid().v4(),
      paperTrade: false,
      stopLoss: "",
      subscriptionId: liveContest.value.id,
      symbol: inst.tradingsymbol,
      trader: userDetailsData.sId,
      uId: Uuid().v4(),
      userId: userDetailsData.email,
      validity: "DAY",
      variety: "regular",
    );
    log('placeContestTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.placeContestOrder(
        data.toJson(),
      );
      log(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successfull');
        await getContestPositions();
        await getContestPortfolio();
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
      final RepoResponse<CompletedContestPnlListResponse> response = await repository.getCompletedContestPnlList();
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
        log('completedContestList : ${completedContestList.length.toString()}');
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
      final RepoResponse<ContestLeaderboardResponse> response = await repository.getContestLeaderboardList();
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
        contestTodaysOrdersList.clear();
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

  Future getContestPortfolio() async {
    isLoading(true);
    try {
      final RepoResponse<ContestPortfolioResponse> response =
          await repository.getContestPortfolio(liveContest.value.id);
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

  Future getContestWatchList() async {
    isLoading(true);
    try {
      final RepoResponse<TradingWatchlistResponse> response = await repository.getContestWatchList(
        liveContest.value.isNifty,
        liveContest.value.isBankNifty,
        liveContest.value.isFinNifty,
      );
      if (response.data != null) {
        if (response.data?.data! != null) {
          tradingWatchlist.clear();
          tradingWatchlistIds.clear();
          tradingWatchlist(response.data?.data ?? []);
          for (var element in tradingWatchlist) {
            tradingWatchlistIds.add(
              element.instrumentToken ?? element.exchangeInstrumentToken ?? 0,
            );
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

  Future getContestPositions() async {
    isLoading(true);
    try {
      final RepoResponse<ContestPositionListResponse> response =
          await repository.getContestPositions(liveContest.value.id);
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
      final RepoResponse<CompletedContestOrdersResponse> response = await repository.getCompletedContestOrders(
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

  Future searchInstruments(
    String? value,
  ) async {
    isLoading(true);
    try {
      final RepoResponse<TradingInstrumentListResponse> response = await repository.searchInstruments(
        value,
        liveContest.value.isNifty,
        liveContest.value.isBankNifty,
        liveContest.value.isFinNifty,
      );
      if (response.data != null) {
        if (response.data?.data != null) {
          tradingInstruments.clear();
          tradingInstruments.addAll(response.data?.data ?? []);
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
      tradingInstruments.clear();
      await getContestWatchList();
      await searchInstruments(
        searchTextController.text,
      );
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

  Future addInstrument(TradingInstrument inst) async {
    isLoading(true);
    AddInstrumentRequest data = AddInstrumentRequest(
      instrument: inst.name,
      exchange: inst.exchange,
      status: inst.status,
      symbol: inst.tradingsymbol,
      lotSize: inst.lotSize,
      instrumentToken: inst.instrumentToken,
      uId: Uuid().v4(),
      contractDate: inst.expiry,
      maxLot: 1800,
      from: "paperTrade",
      chartInstrument: inst.chartInstrument,
      exchangeSegment: inst.segment,
      exchangeInstrumentToken: inst.exchangeToken,
    );

    log('addInstrument : ${data.toJson()}');

    try {
      final RepoResponse<GenericResponse> response = await repository.addInstrument(
        data.toJson(),
      );
      if (response.data?.message == "Instrument Added") {
        tradingWatchlist.clear();
        tradingInstruments.clear();
        await getContestWatchList();
        await searchInstruments(
          searchTextController.text,
        );
        SnackbarHelper.showSnackbar("Instrument Added");
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

  Future socketConnection() async {
    List<TradingInstrumentTradeDetails>? tempList = [];
    try {
      socket.on('tick-room', (data) {
        tempList = TradingInstrumentTradeDetailsListResponse.fromJson(data).data ?? [];
        tempList?.forEach((element) {
          if (tradingInstrumentTradeDetailsList.any((obj) => obj.instrumentToken == element.instrumentToken)) {
            int index = tradingInstrumentTradeDetailsList.indexWhere(
              (stock) => stock.instrumentToken == element.instrumentToken,
            );
            tradingInstrumentTradeDetailsList.removeAt(index);
            tradingInstrumentTradeDetailsList.insert(index, element);
          } else {
            tradingInstrumentTradeDetailsList.add(element);
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

  Future getStockIndexInstrumentsList() async {
    isLoading(true);
    try {
      final RepoResponse<StockIndexInstrumentListResponse> response = await repository.getStockIndexInstrumentsList();
      if (response.data != null) {
        stockIndexInstrumentList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('car ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future socketIndexConnection() async {
    List<StockIndexDetails>? stockTemp = [];
    try {
      socket.on(
        'index-tick',
        (data) {
          // log('Stock Socket : index-tick $data');
          stockTemp = StockIndexDetailsListResponse.fromJson(data).data ?? [];
          for (var element in stockTemp ?? []) {
            if (stockIndexDetailsList.any((obj) => obj.instrumentToken == element.instrumentToken)) {
              int index = stockIndexDetailsList.indexWhere(
                (stock) => stock.instrumentToken == element.instrumentToken,
              );
              stockIndexDetailsList.removeAt(index);
              stockIndexDetailsList.insert(index, element);
            } else {
              stockIndexDetailsList.add(element);
            }
          }
        },
      );
      socket.onDisconnect((_) => log('Socket : Disconnect'));
      socket.onConnectError((err) => log(err));
      socket.onError((err) => log(err));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future purchaseContest(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final RepoResponse<GenericResponse> response = await repository.purchaseContest(
        data,
      );
      if (response.data != null) {
        SnackbarHelper.showSnackbar(response.data?.message ?? 'Success');
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
      await Get.find<AuthController>().getUserDetails(navigate: false);
      await loadUserDetails();
      getUpComingContestList();
      getLiveContestList();
    } catch (e) {
      log('Purchase Contest: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future socketLeaderboardConnection() async {
    try {
      var rankData = {
        "employeeId": userDetails.value.employeeid,
        "userId": userDetails.value.sId,
        "id": liveContest.value.id,
      };
      log('Socket Emit RankData : $rankData');

      socket.emit('dailyContestLeaderboard', rankData);

      socket.on(
        'contest-myrank${userDetails.value.sId}${liveContest.value.id}',
        (data) {
          log('Socket MyRank : contest-myrank${userDetails.value.sId}${liveContest.value.id} : $data');
          myRank(data);
        },
      );

      socket.on(
        'contest-leaderboardData${liveContest.value.id}',
        (data) {
          log('Socket Leaderboard : contest-leaderboardData${liveContest.value.id} $data');
          liveLeaderboardList.value = LiveContestLeaderboardReponse.fromJson(data).data ?? [];
        },
      );
      socket.onDisconnect((_) => log('Socket : Disconnect'));
      socket.onConnectError((err) => log(err));
      socket.onError((err) => log(err));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> getShareContest(bool isUpcoming) async {
    isLoading(true);

    try {
      await repository.getShareContest(isUpcoming ? upComingContest.value.id : liveContest.value.id);

      if (isUpcoming) {
        getUpComingContestList();
      } else {
        getLiveContestList();
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }

    isLoading(false);
  }

  Future getNotified() async {
    isLoading(true);
    try {
      await repository.getNotified(upComingContest.value.id);
      getUpComingContestList();
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future participate() async {
    isLoading(true);
    try {
      await repository.participate(
        liveContest.value.id,
      );
      getLiveContestList();
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getCompletedContestLeaderboardList(String? id) async {
    isLoading(true);
    try {
      final RepoResponse<CompletedContestLeaderboardListResponse> response =
          await repository.getCompletedContestLeaderboardList(id);
      if (response.data != null) {
        completedContestLeaderboardList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Leaderboard: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }
}
