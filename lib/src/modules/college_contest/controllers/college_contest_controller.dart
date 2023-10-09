import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stoxhero/src/data/models/response/trading_instrument_trade_details_list_response.dart';
import 'package:stoxhero/src/data/models/response/upcoming_college_contest_list_response.dart';

import '../../../app/app.dart';

class CollegeContestBinding implements Bindings {
  @override
  void dependencies() => Get.put(CollegeContestController());
}

class CollegeContestController extends BaseController<CollegeContestRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final segmentedControlValue = 0.obs;

  final isOtpVisible = false.obs;

  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final collegeNameTextController = TextEditingController();
  final otpTextController = TextEditingController();
  final linkedInProfileTextController = TextEditingController();

  final searchTextController = TextEditingController();
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
  final livePremiumCollegeContestList = <LiveCollegeContest>[].obs;
  final liveFreeCollegeContestList = <LiveCollegeContest>[].obs;
  final liveCollegeContest = LiveCollegeContest().obs;
  final contestPositionsList = <ContestPosition>[].obs;
  final contestPortfolio = ContestCreditData().obs;
  final contestWatchList = <ContestWatchList>[].obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final tradingInstrumentTradeDetailsList = <TradingInstrumentTradeDetails>[].obs;
  final tradingInstruments = <TradingInstrument>[].obs;
  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;

  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;

  final selectedWatchlistIndex = RxInt(-1);
  final walletBalance = RxNum(0);
  final selectedQuantity = 0.obs;
  final lotsValueList = <int>[0].obs;
  final selectedContest = UpComingContest().obs;
  final selectedContestId = ''.obs;

  final isLivePriceLoaded = false.obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;

  String? experienceSelectedValue;
  String? hearAboutSelectedValue;

  final List<String> experienceDropdown = ['Yes', 'No'];
  final List<String> hearAboutDropdown = [
    'LinkedIn',
    'Facebook',
    'Instagram',
    'Twitter',
    'Google',
    'Friend',
    'Others',
  ];
  final selectedDOBDateTime = ''.obs;

  void showDateRangePicker(BuildContext context, {bool isStartDate = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      String date = DateFormat("dd-MM-yyyy").format(pickedDate);
      dobTextController.text = date;
      selectedDOBDateTime(pickedDate.toString());
    }
  }

  Future loadData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getCompletedCollegeContestList();
    await getUpComingCollegeContestList();
    await getCompletedContestPnlList();
    await getLiveCollegeContestList();
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
  }

  Future loadRegisterData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getLiveCollegeContestList();
  }

  String getStockIndexName(int instId) {
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

  num calculatePayout() {
    num npnl = calculateTotalNetPNL() * liveCollegeContest.value.payoutPercentage!;
    num payout = npnl < 0 ? 0 : npnl / 100;
    return payout;
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
    return AppColors.grey;
  }

  int calculateSeatsLeft(int maxParticipants, int currentParticipants) {
    int seatsLeft = maxParticipants - currentParticipants;
    return seatsLeft;
  }

  void handleSegmentChange(int val) => changeSegment(val);

  void changeSegment(int val) => segmentedControlValue.value = val;

  void gotoSearchInstrument() {
    searchTextController.text = '';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.collegeContestSearchSymbol);
  }

  bool checkIfPurchased(UpComingCollegeContest? contest) {
    bool isPurchased = false;
    for (Participants? user in contest?.participants ?? []) {
      if (user?.userId?.sId == userDetails.value.sId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  bool checkIfLivePurchased(LiveCollegeContest? contest) {
    bool isPurchased = false;
    for (CollegeParticipants? user in contest?.participants ?? []) {
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

  Future getContestPortfolio() async {
    isLoading(true);
    try {
      final RepoResponse<ContestPortfolioResponse> response =
          await repository.getContestPortfolio(liveCollegeContest.value.id);
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
        liveCollegeContest.value.isNifty,
        liveCollegeContest.value.isBankNifty,
        liveCollegeContest.value.isFinNifty,
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
          await repository.getContestPositions(liveCollegeContest.value.id);
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

  Future placeContestOrder(TransactionType type, TradingInstrument inst) async {
    Get.back();
    isLoading(true);
    ContestPlaceOrderRequest data = ContestPlaceOrderRequest(
      orderType: "MARKET",
      price: "",
      product: "NRML",
      quantity: selectedQuantity.value,
      triggerPrice: "",
      battleId: liveCollegeContest.value.id,
      buyOrSell: type == TransactionType.exit
          ? type == TransactionType.buy
              ? "BUY"
              : "SELL"
          : type == TransactionType.exit
              ? "SELL"
              : "BUY",
      contestId: liveCollegeContest.value.id,
      createdBy: userDetailsData.name,
      exchange: inst.exchange,
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      marginxId: liveCollegeContest.value.id,
      orderId: Uuid().v4(),
      paperTrade: false,
      stopLoss: "",
      subscriptionId: liveCollegeContest.value.id,
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

  Future searchInstruments(
    String? value,
  ) async {
    isLoading(true);
    try {
      final RepoResponse<TradingInstrumentListResponse> response = await repository.searchInstruments(
        value,
        liveCollegeContest.value.isNifty,
        liveCollegeContest.value.isBankNifty,
        liveCollegeContest.value.isFinNifty,
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
        await searchInstruments(searchTextController.text);
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
      socket.on(
        'index-tick',
        (data) {
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
      final RepoResponse<CompletedContestPnlListResponse> response = await repository.getCompletedContestPnlList();
      if (response.data != null) {
        List<CompletedCollegeContest> tempList = [];
        completedContestPnlList(response.data?.data ?? []);
        if (tempCompletedContestList.isNotEmpty && completedContestPnlList.isNotEmpty) {}
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
      final RepoResponse<LiveCollegeContestListResponse> response = await repository.getLiveCollegeContestList();
      if (response.data != null) {
        liveCollegeContestList(response.data?.data ?? []);
        if (liveCollegeContestList.isNotEmpty) {
          liveFreeCollegeContestList.clear();
          livePremiumCollegeContestList.clear();

          liveCollegeContestList.forEach((contest) {
            (contest.entryFee == null || contest.entryFee == 0)
                ? liveFreeCollegeContestList.add(contest)
                : livePremiumCollegeContestList.add(contest);
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
      getUpComingCollegeContestList();
      getLiveCollegeContestList();
    } catch (e) {
      log('Purchase Contest: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  void validateCollegeContestOtp(String? contestId) async {
    isLoading(true);
    if (otpTextController.text.isNotEmpty) {
      FocusScope.of(Get.context!).unfocus();

      CollegeContestFormRequest data = CollegeContestFormRequest(
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        email: emailTextController.text,
        mobile: mobileTextController.text,
        collegeName: collegeNameTextController.text,
        dob: selectedDOBDateTime.value,
        source: hearAboutSelectedValue,
        contest: contestId,
      );

      try {
        final RepoResponse response = await repository.validateCollegeContestOtp(
          data.toJson(),
        );
        if (response.data != null) {
          Get.back();
          SnackbarHelper.showSnackbar(response.data['info']);
        }
      } catch (e) {
        log(e.toString());
        SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
      }
    }
    isLoading(false);
  }

  void submitCollegeContestForm(String? contestId) async {
    isLoading(true);

    FocusScope.of(Get.context!).unfocus();

    CollegeContestFormRequest data = CollegeContestFormRequest(
      firstName: firstNameTextController.text,
      lastName: lastNameTextController.text,
      email: emailTextController.text,
      mobile: mobileTextController.text,
      collegeName: collegeNameTextController.text,
      dob: selectedDOBDateTime.value,
      source: hearAboutSelectedValue,
      contest: contestId,
    );

    try {
      final RepoResponse response = await repository.generateCollegeContestOtp(
        data.toJson(),
      );
      if (response.data != null) {
        SnackbarHelper.showSnackbar(response.data['info']);
        isOtpVisible(true);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }
}
