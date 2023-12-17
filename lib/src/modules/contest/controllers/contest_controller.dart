import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/contest/views/resultView.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app.dart';

class ContestBinding implements Bindings {
  @override
  void dependencies() => Get.put(ContestController());
}

class ContestController extends BaseController<ContestRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final isLiveLoading = false.obs;
  bool get isLiveLoadingStatus => isLiveLoading.value;

  final isUpcomingLoading = false.obs;
  bool get isUpcomingLoadingStatus => isUpcomingLoading.value;

  final isCompletedLoading = false.obs;
  bool get isCompletedLoadingStatus => isCompletedLoading.value;

  final isOrdersLoading = false.obs;
  bool get isOrdersLoadingStatus => isOrdersLoading.value;

  final isLeaderboardLoading = false.obs;
  bool get isLeaderboardLoadingStatus => isLeaderboardLoading.value;

  final isCompletedLeaderboardLoading = false.obs;
  bool get isCompletedLeaderboardLoadingStatus =>
      isCompletedLeaderboardLoading.value;

  final isCompletedOrdersLoading = false.obs;
  bool get isCompletedOrdersLoadingStatus => isCompletedOrdersLoading.value;

  final isTradingOrderSheetLoading = false.obs;
  bool get isTradingOrderSheetLoadingStatus => isTradingOrderSheetLoading.value;

  final isWatchlistStateLoading = false.obs;
  bool get isWatchlistStateLoadingStatus => isWatchlistStateLoading.value;

  final isPositionStateLoading = false.obs;
  bool get isPositionStateLoadingStatus => isPositionStateLoading.value;

  final isPortfolioStateLoading = false.obs;
  bool get isPortfolioStateLoadingStatus => isPortfolioStateLoading.value;

  final isInstrumentListLoading = false.obs;
  bool get isInstrumentListLoadingStatus => isInstrumentListLoading.value;

  final isPendingOrderStateLoading = false.obs;
  bool get isPendingOrderStateLoadingStatus => isPendingOrderStateLoading.value;

  final isOrderStateLoading = false.obs;
  bool get isOrderStateLoadingStatus => isOrderStateLoading.value;

  final isExecutedOrderStateLoading = false.obs;
  bool get isExecutedOrderStateLoadingStatus =>
      isExecutedOrderStateLoading.value;

  final isMarginStateLoading = false.obs;
  bool get isMarginStateLoadingStatus => isMarginStateLoading.value;

  final isPurchaseLoading = false.obs;
  bool get isPurchaseLoadingStatus => isMarginStateLoading.value;

  final isRecentLoading = false.obs;
  bool get isRecentLoadingStatus => isRecentLoading.value;

  final selectedTabBarIndex = 0.obs;
  final selectedSecondTabBarIndex = 0.obs;

  final segmentedControlValue = 0.obs;
  final liveSegmentedControlValue = 0.obs;
  final upcomingSegmentedControlValue = 0.obs;
  final completedSegmentedControlValue = 0.obs;
  final isBuyButtonDisabled = false.obs;
  final resultPageDetails = ResultPageData().obs;

  final searchTextController = TextEditingController();
  final upComingContestList = <UpComingContest>[].obs;
  final upComingContest = UpComingContest().obs;
  final upcomingPremiumContestList = <UpComingContest>[].obs;
  final upcomingFreeContestList = <UpComingContest>[].obs;
  final tempCompletedContestList = <CompletedContest>[].obs;
  final completedContest = CompletedContest().obs;
  final completedPremiumContestList = <CompletedContest>[].obs;
  final completedFreeContestList = <CompletedContest>[].obs;
  final completedContestList = <CompletedContest>[].obs;
  final completedContestPnlList = <CompletedContestPnl>[].obs;
  final contestLeaderboardList = <ContestLeaderboard>[].obs;
  final contestChampionList = <ContestData>[].obs;
  final contestOrdersList = <ContestOrderDetails>[].obs;

  final liveContestList = <LiveContest>[].obs;
  final liveContest = LiveContest().obs;
  final livePremiumContestList = <LiveContest>[].obs;
  final liveFreeContestList = <LiveContest>[].obs;
  final contestWatchList = <ContestWatchList>[].obs;
  final contestPositionsList = <TradingPosition>[].obs;
  final contestPortfolio = ContestCreditData().obs;
  final tenxTotalPositionDetails = TenxTotalPositionDetails().obs;
  final contestRequest = ContestPlaceOrderRequest().obs;
  final tradingInstrumentTradeDetailsList =
      <TradingInstrumentTradeDetails>[].obs;
  final tradingInstruments = <TradingInstrument>[].obs;
  final tradingWatchlist = <TradingWatchlist>[].obs;
  final tradingWatchlistIds = <int>[].obs;
  final selectedStringQuantity = "0".obs;
  final stockIndexDetailsList = <StockIndexDetails>[].obs;
  final stockIndexInstrumentList = <StockIndexInstrument>[].obs;
  final marginRequired = MarginRequiredResponse().obs;
  final liveFeaturedContest = <LiveFeatured>[].obs;
  final upcomingFeaturedContest = <UpcomingFeatured>[].obs;
  final featuredCollegeContest = <FeaturedCollegeContest>[].obs;
  final featuredLiveCollegeContest = FeaturedCollegeContest().obs;
  final liveFeatured = LiveFeatured().obs;
  final upcomingFeatured = UpcomingFeatured().obs;
  final selectedWatchlistIndex = RxInt(-1);
  final walletBalance = RxNum(0);
  final selectedQuantity = 0.obs;
  final lotsValueList = <int>[0].obs;
  final selectedContest = UpComingContest().obs;
  final stopLossFormKey = GlobalKey<FormState>();
  final stopLossPriceTextController = TextEditingController();
  final stopProfitPriceTextController = TextEditingController();
  final quanitityTextController = TextEditingController();
  final limitPriceTextController = TextEditingController();
  final stopLossExecutedOrdersList = <StopLossExecutedOrdersList>[].obs;
  final stopLossPendingOrderList = <StopLossPendingOrdersList>[].obs;
  final stopLossPendingOrder = StopLossPendingOrdersList().obs;
  final stopLossPendingCancelOrder = StopLossPendingCancelOrder().obs;
  final selectedType = "".obs;
  final selectedGroupValue = 0.obs;
  final selectedContestId = ''.obs;
  final selectedContestName = ''.obs;
  final serverTime = ''.obs;
  final selectedContestEndTime = ''.obs;

  final myRank = 0.obs;

  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;
  final liveLeaderboardList = <LiveContestLeaderboard>[].obs;
  final liveLeaderboard = LiveContestLeaderboard().obs;
  final completedContestLeaderboardList =
      <CompletedContestLeaderboardList>[].obs;
  final completedContestLeaderboard = CompletedContestLeaderboardList().obs;
  final readSetting = ReadSettingResponse().obs;

  Future loadData() async {
    loadUserDetails();
    await getLiveContestList();
    await getUpComingContestList();
    await getCompletedContestList();
    await getCompletedContestPnlList();
    await getReadSetting();
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
    await getStopLossPendingOrder();
    await getStopLossExecutedOrder();
    await getContestTodaysOrderList();
    await getContestPortfolio();
    await getReadSetting();
    await socketConnection();
    socketIndexConnection();
    socketSendConnection();
    socketLeaderboardConnection();
    setupServerTimeSocketConnection();
  }

  Future loadDataAfterPaymentSuccess() async {
    await Get.find<AuthController>().getUserDetails(navigate: false);
    await loadUserDetails();
    getUpComingContestList();
    getLiveContestList();
  }

  void gotoTradingView() {
    loadTradingData();
    Get.to(() => ContestTradingView());
  }

  bool handleTextField(
      TransactionType type, int transactionLotSize, int positionLots) {
    bool isDisabled = false;

    if (type == TransactionType.buy) {
      if (transactionLotSize < 0 && transactionLotSize.abs() == positionLots) {
        isDisabled = true;
        log("BUY - Disable TextField");
      } else {
        isDisabled = false;
        log("BUY - Enable TextField");
      }
    } else if (type == TransactionType.sell) {
      if (transactionLotSize < 0 || transactionLotSize.abs() < positionLots) {
        isDisabled = false;
        log("SELL - Enable TextField");
      } else {
        isDisabled = true;
        log("SELL - Disable TextField");
      }
    }

    return isDisabled;
  }

  void handleRadioValueChanged(int newValue, String labelText) {
    selectedGroupValue.value = newValue;
    selectedType.value = labelText;
  }

  bool isUpcomingContestVisible(UpComingContest? contest) {
    DateTime startTimeDateTime;
    Duration remainingTime;
    bool isVisible = true;
    DateTime currentTime = DateTime.now();

    startTimeDateTime = DateTime.parse(contest?.contestStartTime ?? '');
    remainingTime = startTimeDateTime.isAfter(currentTime)
        ? startTimeDateTime.difference(currentTime)
        : Duration.zero;
    isVisible = remainingTime == Duration.zero;
    return isVisible;
  }

  int calculateSeatsLeft(int maxParticipants, int currentParticipants) {
    int seatsLeft = maxParticipants - currentParticipants;
    return seatsLeft;
  }

  bool isUserInterested(contest, String userId) {
    if (contest.interestedUsers != null) {
      for (InterestedUsers user in contest.interestedUsers) {
        if (user.userId?.id == userId) {
          return true;
        }
      }
    }
    return false;
  }

  num herocashadd(contest, String userId) {
    num herocash = 0;
    if (contest.participants != null) {
      for (CompletedParticipants? participant in contest.participants!) {
        if (participant?.userId == userId) {
          herocash = participant?.heroCash ?? 0;
        }
      }
    }
    return herocash;
  }

  bool canUserTrade(contest, String userId) {
    bool canParticipate = false;
    if (contest.participants != null) {
      for (Participants participant in contest.participants) {
        if (participant.userId?.id == userId) {
          canParticipate = true;
        }
      }
    }
    return canParticipate;
  }

  bool canUserFeaturedTrade(contest, String userId) {
    bool canParticipate = false;
    if (contest.participants != null) {
      for (FeaturedParticipants participant in contest.participants) {
        if (participant.userId?.id == userId) {
          canParticipate = true;
        }
      }
    }
    return canParticipate;
  }

  String getPaidCapAmount(num fees, num cap) {
    num percentage = (fees * cap) / 100;
    return FormatHelper.formatNumbers(percentage.round(), showDecimal: false);
  }

  String getStockIndexName(int instId) {
    int index = stockIndexInstrumentList
        .indexWhere((element) => element.instrumentToken == instId);
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
    var response =
        await Get.find<WalletRepository>().getWalletTransactionsList();
    var list = response.data?.data?.transactions ?? [];
    for (var e in list) amount += e.amount ?? 0;
    walletBalance(amount);
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

  num calculatePayout() {
    num livePayoutPercentage = liveContest.value.payoutPercentage ?? 0;
    num livePayoutCapPercentage = liveContest.value.payoutCapPercentage ?? 0;
    num liveEntryFee = liveContest.value.entryFee ?? 0;
    num livePortfolio = liveContest.value.portfolio?.portfolioValue ?? 0;

    num featuredPayoutPercentage = liveFeatured.value.payoutPercentage ?? 0;
    num featuredPayoutCapPercentage =
        liveFeatured.value.payoutCapPercentage ?? 0;
    num featuredEntryFee = liveFeatured.value.entryFee ?? 0;
    num featuredPortfolio = liveFeatured.value.portfolio?.portfolioValue ?? 0;

    num totalNetPNL = calculateTotalNetPNL();
    num npnl = totalNetPNL *
        (featuredPayoutPercentage != 0
            ? featuredPayoutPercentage
            : livePayoutPercentage);
    num payout = npnl <= 0 ? 0 : npnl / 100;
    num payoutCap = liveEntryFee == 0
        ? (featuredEntryFee == 0
            ? ((featuredPortfolio != 0 ? featuredPortfolio : livePortfolio) *
                (featuredPayoutCapPercentage != 0
                    ? featuredPayoutCapPercentage
                    : livePayoutCapPercentage) /
                100)
            : (featuredEntryFee != 0 ? featuredEntryFee : liveEntryFee) *
                (livePayoutCapPercentage) /
                100)
        : (liveEntryFee) * (livePayoutCapPercentage) / 100;

    num finalPayout = payout > payoutCap ? payoutCap : payout;
    return finalPayout;
  }

  num calculateUserPayout(dynamic netPnl) {
    num livePayoutPercentage = liveContest.value.payoutPercentage ?? 0;
    num livePayoutCapPercentage = liveContest.value.payoutCapPercentage ?? 0;
    num liveEntryFee = liveContest.value.entryFee ?? 0;
    num livePortfolio = liveContest.value.portfolio?.portfolioValue ?? 0;

    num featuredPayoutPercentage = liveFeatured.value.payoutPercentage ?? 0;
    num featuredPayoutCapPercentage =
        liveFeatured.value.payoutCapPercentage ?? 0;
    num featuredEntryFee = liveFeatured.value.entryFee ?? 0;
    num featuredPortfolio = liveFeatured.value.portfolio?.portfolioValue ?? 0;

    num reward = netPnl *
        (featuredPayoutPercentage != 0
            ? featuredPayoutPercentage
            : livePayoutPercentage);
    num payout = reward <= 0 ? 0 : reward / 100;
    num payoutCap = liveEntryFee == 0
        ? (featuredEntryFee == 0
            ? ((featuredPortfolio != 0 ? featuredPortfolio : livePortfolio) *
                (featuredPayoutCapPercentage != 0
                    ? featuredPayoutCapPercentage
                    : livePayoutCapPercentage) /
                100)
            : (featuredEntryFee != 0 ? featuredEntryFee : liveEntryFee) *
                (livePayoutCapPercentage) /
                100)
        : (liveEntryFee) * (livePayoutCapPercentage) / 100;

    num finalPayout = payout > payoutCap ? payoutCap : payout;
    return finalPayout;
  }

  num calculateUserReward(dynamic rank) {
    var rewards = liveContest.value.rewards;
    var numericRank = num.tryParse(rank) ?? 0;
    for (var reward in rewards ?? []) {
      if (numericRank >= reward.rankStart && numericRank <= reward.rankEnd) {
        return reward.prize;
      }
    }
    return 0;
  }

  num calculateTotalReward(rankRewards) {
    num totalReward = 0;
    for (var reward in rankRewards) {
      num numberOfRanks = reward.rankEnd - reward.rankStart + 1;
      totalReward += numberOfRanks * reward.prize;
    }
    return totalReward;
  }

  num getRewardCapAmount(num fees, num cap, num payoutPercentage) {
    num capValue = (fees * cap) / 100;
    num netPNL = calculateTotalNetPNL();
    num tempReward = netPNL * payoutPercentage / 100;
    num reward = tempReward > capValue ? capValue : tempReward;
    return reward > 0 ? reward : 0;
  }

  num resultrewardCapAmount(num fees, num cap, num payoutPercentage) {
    num capValue = (fees * cap) / 100;
    num netPNL = resultPageDetails.value.npnl ?? 0;
    num tempReward = netPNL * payoutPercentage / 100;
    num reward = tempReward > capValue ? capValue : tempReward;

    return reward > 0 ? reward : 0;
  }

  num calculateTDS() {
    num tds = readSetting.value.tdsPercentage ?? 0;
    num rewardAmount = getRewardCapAmount(
        liveContest.value.entryFee == 0
            ? liveContest.value.portfolio?.portfolioValue ?? 0
            : liveContest.value.entryFee ?? 0,
        liveContest.value.payoutCapPercentage ?? 0,
        liveContest.value.payoutPercentage ?? 0);

    num winingAmount = rewardAmount - liveContest.value.entryFee!;
    num tdsAmount = winingAmount * tds / 100;

    return tdsAmount > 0 ? tdsAmount : 0;
  }

  num calculatefinalPayout() {
    num finalPayout = calculatePayout() - calculateTDS();
    return finalPayout;
  }

  void changeTabBarIndex(int val) => selectedTabBarIndex.value = val;

  int getOpenPositionCount() {
    int openCount = 0;
    for (var position in contestPositionsList) {
      if (position.id?.isLimit ?? false) {
      } else if (position.lots != 0) {
        openCount++;
      }
    }
    return openCount;
  }

  int getClosePositionCount() {
    int closeCount = 0;
    for (var position in contestPositionsList) {
      if (position.id?.isLimit ?? false) {
      } else if (position.lots == 0) {
        closeCount++;
      }
    }
    return closeCount;
  }

  void gotoSearchInstrument() {
    searchTextController.text = '';
    searchInstruments(searchTextController.text);
    Get.toNamed(AppRoutes.contestSearchSymbol);
  }

  bool checkIfPurchased(contest, String userId) {
    bool isPurchased = false;
    for (Participants? user in contest?.participants ?? []) {
      if (user?.userId?.id == userId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  bool checkIfLivePurchased(LiveContest? contest, String userId) {
    bool isPurchased = false;
    for (Participants? user in contest?.participants ?? []) {
      if (user?.userId?.id == userId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  bool checkIfLiveFeaturedPurchased(LiveFeatured? contest, String userId) {
    bool isPurchased = false;
    for (FeaturedParticipants? user in contest?.participants ?? []) {
      if (user?.userId?.id == userId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  num calculateGrossPNL(num amount, int lots, num ltp) {
    if (ltp == 0) return 0;
    num pnl = 0;
    num value = (amount + (lots * ltp));
    pnl += value;
    return pnl;
  }

  void calculateTotalPositionValues() {
    int totalLots = 0;
    num totalBrokerage = 0;
    num totalGross = 0;
    num totalNet = 0;

    for (var position in contestPositionsList) {
      if (position.id?.isLimit ?? false) {
      } else {
        totalLots += position.lots ?? 0;
        totalBrokerage += position.brokerage ?? 0;
        totalGross += position.lastaverageprice ?? 0;
        totalNet += position.amount ?? 0;
      }
      // totalLots += position.lots ?? 0;
      // totalBrokerage += position.brokerage ?? 0;
      // totalGross += position.lastaverageprice ?? 0;
      // totalNet += position.amount ?? 0;
    }
    tenxTotalPositionDetails(
      TenxTotalPositionDetails(
        lots: totalLots,
        brokerage: totalBrokerage,
        gross: totalGross,
        net: totalNet,
      ),
    );
  }

  num calculateTotalGrossPNL() {
    num totalGross = 0;
    // print('contestposition $contestPositionsList');

    for (var position in contestPositionsList) {
      print('position $position');
      if (position.id?.isLimit != true) {
        // Check if isLimit is not true
        num avg = position.amount ?? 0;
        int lots = position.lots?.toInt() ?? 0;
        num ltp = getInstrumentLastPrice(
          position.id?.instrumentToken ?? 0,
          position.id?.exchangeInstrumentToken ?? 0,
        );

        if (ltp == 0) return 0;
        num value = (avg + (lots) * ltp);
        totalGross += value;
      }
    }
    return totalGross.round();
  }

  num calculateTotalNetPNL() {
    num totalNetPNL = 0;
    for (var position in contestPositionsList) {
      print('contest $contestPositionsList');
      if (position.id?.isLimit != true) {
        num avg = position.amount ?? 0;
        int lots = position.lots?.toInt() ?? 0;
        num ltp = getInstrumentLastPrice(
          position.id?.instrumentToken ?? 0,
          position.id?.exchangeInstrumentToken ?? 0,
        );
        if (ltp == 0) return 0;
        num value = (avg + (lots) * ltp);
        num brokerage = position.brokerage ?? 0;
        num broker = value - brokerage;
        totalNetPNL += broker;
      }
    }
    return totalNetPNL.round();
  }

  num calculateMargin() {
    //   num lots = 0;
    //   num margin = 0;
    //   num amount = 0;
    //  num limitmargin = 0;
    //   for (var position in contestPositionsList) {
    //     if (position.lots != 0) {
    //       lots += position.lots ?? 0;
    //       margin += position.margin ?? 0;
    //     }
    //      if (position.id.isLimit) {
    //   margin += position.margin;
    // } else {
    //   amount += (position.amount - position.brokerage);
    // }
    //   }
    num lots = 0;
    num margin = 0;
    num amount = 0;
    num limitMargin = 0; // Changed to camelCase for consistency

    for (var position in contestPositionsList) {
      if (position.lots != 0) {
        lots += position.lots ?? 0;
        margin += position.margin ?? 0;
      }

      if (position.id?.isLimit == true) {
        limitMargin += position.margin ?? 0;
      } else {
        amount += ((position.amount ?? 0) - (position.brokerage ?? 0));
      }
    }

    num openingBalance = 0;
    num totalFund = contestPortfolio.value.totalFund ?? 0;

    if (contestPortfolio.value.openingBalance != null) {
      openingBalance = contestPortfolio.value.openingBalance ?? 0;
    } else {
      openingBalance = totalFund;
    }
    num availableMargin = (calculateTotalNetPNL() < 0)
        ? (lots == 0
            ? (openingBalance - margin + calculateTotalNetPNL())
            : (openingBalance - (amount.abs() + limitMargin)))
        : (openingBalance - margin);
    return availableMargin;
  }

  num calculateUnRealisedPNL() {
    num pnl = calculateTotalNetPNL();
    if (pnl >= 0) {
      return pnl;
    } else {
      return 0;
    }
  }

  num getInstrumentLastPrice(int instID, int exchID) {
    num priceValue = 0;
    if (tradingInstrumentTradeDetailsList.isNotEmpty) {
      int index = tradingInstrumentTradeDetailsList.indexWhere(
        (stock) =>
            stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) {
        int index = instrumentLivePriceList.indexWhere(
          (stock) =>
              stock.instrumentToken == instID ||
              stock.instrumentToken == exchID,
        );
        if (index == -1) {
          priceValue = 0;
        } else {
          priceValue = instrumentLivePriceList[index].lastPrice ?? 0;
        }
      } else {
        priceValue = tradingInstrumentTradeDetailsList[index].lastPrice ?? 0;
      }
    }
    return priceValue;
  }

  String getInstrumentChanges(int instID, int exchID) {
    if (tradingInstrumentTradeDetailsList.isNotEmpty) {
      int index = tradingInstrumentTradeDetailsList.indexWhere(
        (stock) =>
            stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) return FormatHelper.formatNumbers('00');
      String? price =
          tradingInstrumentTradeDetailsList[index].change?.toString();
      return FormatHelper.formatNumbers(price, showSymbol: false);
    } else {
      return '${FormatHelper.formatNumbers('00', showSymbol: false)}%';
    }
  }

  Future placeContestOrder(TransactionType type, TradingInstrument inst) async {
    isTradingOrderSheetLoading(true);
    if (type == TransactionType.exit) {
      if (selectedStringQuantity.value.contains('-')) {
        type = TransactionType.buy;
      } else {
        type = TransactionType.sell;
      }
    } else {
      if (selectedStringQuantity.value.contains('-')) {
        if (type == TransactionType.buy) {
          type = TransactionType.sell;
        } else {
          type = TransactionType.buy;
        }
      }
    }
    ContestPlaceOrderRequest data = ContestPlaceOrderRequest(
      exchange: inst.exchange,
      symbol: inst.tradingsymbol,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      quantity: selectedQuantity.value,
      product: "NRML",
      orderType: selectedType.value,
      stopLoss: "",
      stopLossPrice: double.tryParse(stopLossPriceTextController.text),
      stopProfitPrice: double.tryParse(stopProfitPriceTextController.text),
      price: double.tryParse(limitPriceTextController.text),
      uId: Uuid().v4(),
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      validity: "DAY",
      variety: "regular",
      createdBy: userDetails.value.name,
      userId: userDetails.value.email,
      trader: userDetails.value.sId,
      orderId: Uuid().v4(),
      paperTrade: false,
      subscriptionId: liveFeatured.value.id ?? liveContest.value.id,
      battleId: liveFeatured.value.id ?? liveContest.value.id,
      contestId: liveFeatured.value.id ?? liveContest.value.id,
      marginxId: liveFeatured.value.id ?? liveContest.value.id,
      triggerPrice: "",
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    log('placeContestTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response =
          await repository.placeContestOrder(
        data.toJson(),
      );
      Get.back();
      log(response.data.toString());
      if (response.data?.status == "Complete") {
        SnackbarHelper.showSnackbar('Trade Successful');
        await getContestPositions();
        await getStopLossPendingOrder();
        await getContestTodaysOrderList();
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
    isTradingOrderSheetLoading(false);
  }

  Future getUpComingContestList() async {
    isUpcomingLoading(true);
    upcomingFreeContestList.clear();
    upcomingPremiumContestList.clear();
    try {
      final RepoResponse<UpComingContestListResponse> response =
          await repository.getUpComingContestList();
      if (response.data != null) {
        upComingContestList(response.data?.data ?? []);
        if (upComingContestList.isNotEmpty) {
          upComingContestList.forEach((contest) {
            (contest.entryFee == null || contest.entryFee == 0)
                ? upcomingFreeContestList.add(contest)
                : upcomingPremiumContestList.add(contest);
          });
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isUpcomingLoading(false);
  }

  Future getCompletedContestList() async {
    isCompletedLoading(true);
    completedFreeContestList.clear();
    completedPremiumContestList.clear();
    await getCompletedContestPnlList();
    try {
      final RepoResponse<CompletedContestListResponse> response =
          await repository.getCompletedContestList();
      if (response.data != null) {
        tempCompletedContestList(response.data?.data ?? []);
        if (tempCompletedContestList.isNotEmpty) {
          tempCompletedContestList.forEach((contest) {
            (contest.entryFee == null || contest.entryFee == 0)
                ? completedFreeContestList.add(contest)
                : completedPremiumContestList.add(contest);
          });
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isCompletedLoading(false);
  }

  Future getCompletedContestPnlList() async {
    isLoading(true);
    try {
      final RepoResponse<CompletedContestPnlListResponse> response =
          await repository.getCompletedContestPnlList();
      if (response.data != null) {
        List<CompletedContest> tempList = [];
        completedContestPnlList(response.data?.data ?? []);
        if (tempCompletedContestList.isNotEmpty &&
            completedContestPnlList.isNotEmpty) {
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

  Future getPaidContestChampionList() async {
    try {
      final RepoResponse<LastPaidTestZoneTopPerformerListResponse> response =
          await repository.getPaidContestChampionList();
      if (response.data != null) {
        contestChampionList(response.data!.data?.cast<ContestData>() ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Leaderboard: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  Future getContestLeaderboardList() async {
    isLeaderboardLoading(true);
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
    isLeaderboardLoading(false);
  }

  Future getContestOrderList(String? id) async {
    isLoading(true);
    contestOrdersList.clear();
    try {
      final RepoResponse<ContestOrderResponse> response =
          await repository.getContestOrderList(id);
      if (response.data != null) {
        contestOrdersList(response.data?.data ?? []);
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
    isLiveLoading(true);
    liveContestList.clear();
    try {
      final RepoResponse<LiveContestListResponse> response =
          await repository.getLiveContestList();
      if (response.data != null) {
        liveContestList(response.data?.data ?? []);
        liveFreeContestList.clear();
        livePremiumContestList.clear();
        if (liveContestList.isNotEmpty) {
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
    isLiveLoading(false);
  }

  Future getContestPortfolio() async {
    isPortfolioStateLoading(true);
    try {
      final String? contestId = liveFeatured.value.id ?? liveContest.value.id;
      final RepoResponse<ContestPortfolioResponse> response =
          await repository.getContestPortfolio(contestId);
      if (response.data != null) {
        contestPortfolio(response.data?.data);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPortfolioStateLoading(false);
  }

  Future getContestWatchList() async {
    isWatchlistStateLoading(true);
    try {
      final RepoResponse<TradingWatchlistResponse> response =
          await repository.getContestWatchList(
        liveFeatured.value.isNifty ?? liveContest.value.isNifty,
        liveFeatured.value.isBankNifty ?? liveContest.value.isBankNifty,
        liveFeatured.value.isFinNifty ?? liveContest.value.isFinNifty,
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
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future getContestPositions() async {
    isPositionStateLoading(true);
    try {
      final String? contestId = liveFeatured.value.id ?? liveContest.value.id;
      final RepoResponse<TradingPositionListResponse> response =
          await repository.getContestPositions(contestId);
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
    isPositionStateLoading(false);
  }

  Future getCompletedContestOrders(String? id) async {
    isCompletedOrdersLoading(true);
    contestOrdersList.clear();
    try {
      final RepoResponse<ContestOrderResponse> response =
          await repository.getCompletedContestOrders(
        id,
      );
      if (response.data != null) {
        contestOrdersList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isCompletedOrdersLoading(false);
  }

  Future searchInstruments(String? value, {bool showShimmer = true}) async {
    showShimmer ? isInstrumentListLoading(true) : isWatchlistStateLoading(true);
    try {
      final RepoResponse<TradingInstrumentListResponse> response =
          await repository.searchInstruments(
        value,
        liveFeatured.value.isNifty ?? liveContest.value.isNifty,
        liveFeatured.value.isBankNifty ?? liveContest.value.isBankNifty,
        liveFeatured.value.isFinNifty ?? liveContest.value.isFinNifty,
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
    showShimmer
        ? isInstrumentListLoading(false)
        : isWatchlistStateLoading(false);
  }

  Future removeInstrument(int? instToken) async {
    isWatchlistStateLoading(true);
    try {
      await repository.removeInstrument(instToken ?? 0);
      selectedWatchlistIndex(-1);
      // if (response.data != null) {
      // tradingWatchlist.clear();
      // tradingInstruments.clear();
      await getContestWatchList();
      await searchInstruments(searchTextController.text, showShimmer: false);
      SnackbarHelper.showSnackbar('Instrument Remove');
      // } else {
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future addInstrument(TradingInstrument inst) async {
    isWatchlistStateLoading(true);
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

    log('addInstrument : ${data.contractDate}');

    try {
      final RepoResponse<GenericResponse> response =
          await repository.addInstrument(
        data.toJson(),
      );
      if (response.data?.message == "Instrument Added") {
        await getContestWatchList();
        await searchInstruments(searchTextController.text, showShimmer: false);
        SnackbarHelper.showSnackbar("Instrument Added");
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future getInstrumentLivePriceList() async {
    isLoading(true);
    try {
      final RepoResponse<InstrumentLivePriceListResponse> response =
          await repository.getInstrumentLivePrices();
      if (response.data != null) {
        if (response.data?.data! != null) {
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
      socketService.socket.on('tick-room', (data) {
        tempList =
            TradingInstrumentTradeDetailsListResponse.fromJson(data).data ?? [];
        tempList?.forEach((element) {
          if (tradingInstrumentTradeDetailsList
              .any((obj) => obj.instrumentToken == element.instrumentToken)) {
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
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> pollForData(String contestId) async {
    await Future.delayed(Duration(seconds: 2));

    try {
      final RepoResponse<ContestResultPageResponse> response =
          await repository.getContestResultPageData(contestId);
      if (response.data != null) {
        resultPageDetails(response.data?.data);

        if (resultPageDetails.value.npnl == null) {
          Future.delayed(Duration(seconds: 3));
          pollForData(contestId);
        } else {
          Get.to(ResultPage());
        }
      } else {
        pollForData(contestId);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
  }

  bool hasContestEnded(String serverTimeStr, String contestEndTimeStr) {
    DateTime serverTime = DateTime.parse(serverTimeStr);
    DateTime contestEndTime = DateTime.parse(contestEndTimeStr);
    return serverTime.toUtc().isAfter(contestEndTime);
  }

  Future setupServerTimeSocketConnection() async {
    try {
      socketService.socket.on('serverTime', (data) {
        serverTime(data);

        if (hasContestEnded(
            data.toString(), liveContest.value.contestEndTime.toString())) {
          socketService.socket.off("serverTime");
          Get.back();
          Future.delayed(Duration(seconds: 5));
          pollForData(liveContest.value.id.toString());
          Get.to(ResultPage());
        }
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getStockIndexInstrumentsList() async {
    isLoading(true);
    try {
      final RepoResponse<StockIndexInstrumentListResponse> response =
          await repository.getStockIndexInstrumentsList();
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
      socketService.socket.on(
        'index-tick',
        (data) {
          stockTemp = StockIndexDetailsListResponse.fromJson(data).data ?? [];
          for (var element in stockTemp ?? []) {
            if (stockIndexDetailsList
                .any((obj) => obj.instrumentToken == element.instrumentToken)) {
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
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future purchaseContest(Map<String, dynamic> data) async {
    isPurchaseLoading(true);
    try {
      final RepoResponse<GenericResponse> response =
          await repository.purchaseContest(
        data,
      );
      if (response.data != null) {
        SnackbarHelper.showSnackbar(response.data?.message ?? 'Success');
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
      loadDataAfterPaymentSuccess();
    } catch (e) {
      log('Purchase Contest: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPurchaseLoading(false);
  }

  Future socketLeaderboardConnection() async {
    try {
      var rankData = {
        "employeeId": userDetails.value.employeeid,
        "userId": userDetails.value.sId,
        "id": liveFeatured.value.id ?? liveContest.value.id,
      };
      log('Socket Emit RankData : $rankData');
      socketService.socket.emit('dailyContestLeaderboard', rankData);
      socketService.socket.on(
        'contest-myrank${userDetails.value.sId}${liveFeatured.value.id ?? liveContest.value.id}',
        (data) {
          log('Socket MyRank : contest-myrank${userDetails.value.sId}${liveFeatured.value.id ?? liveContest.value.id} : $data');
          myRank(data);
        },
      );
      socketService.socket.on(
        'contest-leaderboardData${liveFeatured.value.id ?? liveContest.value.id}',
        (data) {
          log('Socket Leaderboard : contest-leaderboardData${liveFeatured.value.id ?? liveContest.value.id} $data');
          liveLeaderboardList.value =
              LiveContestLeaderboardReponse.fromJson(data).data ?? [];
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> getShareContest(bool isUpcoming) async {
    try {
      await repository.getShareContest(
          isUpcoming ? upComingContest.value.id : liveContest.value.id);

      // if (isUpcoming) {
      //   getUpComingContestList();
      // } else {
      //   getLiveContestList();
      // }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
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

  Future participate(LiveContest? contest) async {
    isLoading(true);
    try {
      final response = await repository.participate(liveContest.value.id);
      if (response.data?.status?.toLowerCase() == "success") {
        loadTradingData();
        Get.to(() => ContestTradingView());
      } else if (response.error != null) {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future featuredParticipate(LiveFeatured? contest) async {
    isLoading(true);
    try {
      final response =
          await repository.featuredParticipate(liveFeatured.value.id);
      if (response.data?.status?.toLowerCase() == "success") {
        loadTradingData();
        Get.to(() => ContestTradingView());
      } else if (response.error != null) {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getCompletedContestLeaderboardList(String? id) async {
    isCompletedLeaderboardLoading(true);
    completedContestLeaderboardList.clear();
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
    isCompletedLeaderboardLoading(false);
  }

  int calculateQuantity(
      TransactionType type, int tradingLots, int selectQuantity) {
    if (type == TransactionType.sell || type == TransactionType.exit) {
      if (tradingLots == selectQuantity ||
          tradingLots.abs() >= selectQuantity) {
        return 0;
      } else if (tradingLots.abs() <= selectQuantity) {
        return selectQuantity - tradingLots.abs();
      }
    }
    return selectQuantity;
  }

  Future getMarginRequired(TransactionType type, TradingInstrument inst) async {
    isMarginStateLoading(true);

    MarginRequiredRequest data = MarginRequiredRequest(
      exchange: inst.exchange,
      symbol: inst.tradingsymbol,
      buyOrSell: inst.lotSize.toString().contains('-')
          ? type == TransactionType.buy
              ? 'SELL'
              : 'BUY'
          : type == TransactionType.buy
              ? 'BUY'
              : 'SELL',
      quantity:
          calculateQuantity(type, inst.lotSize ?? 0, selectedQuantity.value),
      product: "NRML",
      orderType: selectedType.value,
      validity: "DAY",
      variety: "regular",
      price: limitPriceTextController.text,
      lastPrice: inst.lastPrice.toString(),
    );

    try {
      final RepoResponse<MarginRequiredResponse> response =
          await repository.getMarginRequired(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          marginRequired(response.data);
        } else {
          SnackbarHelper.showSnackbar(response.error?.message);
        }
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isMarginStateLoading(false);
    }
  }

  Future getContestTodaysOrderList() async {
    isOrderStateLoading(true);
    try {
      final RepoResponse<ContestOrderResponse> response =
          await repository.getContestOrderList(
        liveFeatured.value.id ?? liveContest.value.id,
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          contestOrdersList(response.data?.data ?? []);
        } else {
          SnackbarHelper.showSnackbar(response.error?.message);
        }
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    } finally {
      isOrderStateLoading(false);
    }
  }

  Future getStopLossExecutedOrder() async {
    isExecutedOrderStateLoading(true);
    try {
      final RepoResponse<StopLossExecutedOrdersListResponse> response =
          await repository.getStopLossExecutedOrder(
        liveFeatured.value.id ?? liveContest.value.id,
      );
      if (response.data?.status?.toLowerCase() == "success") {
        stopLossExecutedOrdersList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isExecutedOrderStateLoading(false);
  }

  Future getStopLossPendingOrder() async {
    isPendingOrderStateLoading(true);
    try {
      final RepoResponse<StopLossPendingOrdersListResponse> response =
          await repository.getStopLossPendingOrder(
        liveFeatured.value.id ?? liveContest.value.id,
      );
      if (response.data?.status?.toLowerCase() == "success") {
        stopLossPendingOrderList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
  }

  Future getStopLossPendingCancelOrder(String? id) async {
    isPendingOrderStateLoading(true);
    try {
      await repository.getStopLossPendingCancelOrder(id ?? '');
      await getStopLossPendingOrder();
      await getContestPortfolio();
      await getStopLossExecutedOrder();
      loadData();
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
  }

  Future pendingOrderModify(
      TransactionType type, TradingInstrument inst) async {
    isPendingOrderStateLoading(true);
    if (type == TransactionType.exit) {
      if (selectedStringQuantity.value.contains('-')) {
        type = TransactionType.buy;
      } else {
        type = TransactionType.sell;
      }
    } else {
      if (selectedStringQuantity.value.contains('-')) {
        if (type == TransactionType.buy) {
          type = TransactionType.sell;
        } else {
          type = TransactionType.buy;
        }
      }
    }
    PendingOrderModifyRequest data = PendingOrderModifyRequest(
      exchange: inst.exchange,
      buyOrSell: type == TransactionType.buy ? "BUY" : "SELL",
      quantity: selectedQuantity.value,
      product: "NRML",
      orderType: "SL/SP-M",
      exchangeInstrumentToken: inst.exchangeToken,
      instrumentToken: inst.instrumentToken,
      stopLossPrice: stopLossPriceTextController.text,
      stopProfitPrice: stopProfitPriceTextController.text,
      symbol: inst.tradingsymbol,
      validity: "DAY",
      id: liveFeatured.value.id ?? liveContest.value.id,
      lastPrice: inst.lastPrice.toString(),
      variety: "regular",
      from: "Daily Contest",
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    print('PendingOrderModifyRequest : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response =
          await repository.pendingOrderModify(
        data.toJson(),
      );
      Get.back();
      print(response.data.toString());
      if (response.data?.status == "Success") {
        SnackbarHelper.showSnackbar(response.data?.message);
        await getStopLossPendingOrder();
        await getContestTodaysOrderList();
      } else if (response.data?.status == "Failed") {
        print(response.error!.message!.toString());
        SnackbarHelper.showSnackbar(response.error?.message);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
  }

  Future getStopLossEditOrder(String? id, String? type) async {
    isPendingOrderStateLoading(true);
    PendingEditOrderRequest data = PendingEditOrderRequest(
      executionPrice: type == "StopLoss"
          ? stopLossPriceTextController.text
          : (type == "StopProfit"
              ? stopProfitPriceTextController.text
              : (type == "Limit" ? limitPriceTextController.text : '0')),
    );
    try {
      final response = await repository.getStopLossEditOrder(
        id,
        data.toJson(),
      );
      Get.back();
      getStopLossPendingOrder();
      if (response.data?.status?.toLowerCase() == "Success") {
        getStopLossPendingOrder();
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isPendingOrderStateLoading(false);
  }

  Future socketSendConnection() async {
    isPendingOrderStateLoading(true);
    try {
      socketService.socket.off('sendOrderResponse${userDetails.value.sId}');
      socketService.socket.on(
        'sendOrderResponse${userDetails.value.sId}',
        (data) {
          print('sendOrderResponse${userDetails.value.sId} $data');
          if (data.containsKey("message")) {
            String message = data["message"];
            SnackbarHelper.showSnackbar(message);
          }
          getContestPositions();
          getStopLossPendingOrder();
          getStopLossExecutedOrder();
          getContestTodaysOrderList();
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    isPendingOrderStateLoading(false);
  }

  Future getFeaturedContest() async {
    isLoading(true);
    try {
      final RepoResponse<FeaturedContestResponse> response =
          await repository.getFeaturedContest();
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          liveFeaturedContest(response.data?.liveFeatured ?? []);
          upcomingFeaturedContest(response.data?.upcomingFeatured ?? []);
          featuredCollegeContest(response.data?.collegeContest ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      // SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future getReadSetting() async {
    isRecentLoading(true);
    try {
      final RepoResponse<ReadSettingResponse> response =
          await repository.readSetting();
      readSetting(response.data);
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isRecentLoading(false);
  }
}
