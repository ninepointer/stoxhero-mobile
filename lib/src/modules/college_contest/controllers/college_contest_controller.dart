import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
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
  bool get isCompletedLeaderboardLoadingStatus => isCompletedLeaderboardLoading.value;

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

  final isMarginStateLoading = false.obs;
  bool get isMarginStateLoadingStatus => isMarginStateLoading.value;

  final isPendingOrderStateLoading = false.obs;
  bool get isPendingOrderStateLoadingStatus => isPendingOrderStateLoading.value;

  final isOrderStateLoading = false.obs;
  bool get isOrderStateLoadingStatus => isOrderStateLoading.value;

  final isExecutedOrderStateLoading = false.obs;
  bool get isExecutedOrderStateLoadingStatus => isExecutedOrderStateLoading.value;
  final selectedTabBarIndex = 0.obs;
  final selectedSecondTabBarIndex = 0.obs;

  final segmentedControlValue = 0.obs;
  final liveSegmentedControlValue = 0.obs;
  final upcomingSegmentedControlValue = 0.obs;
  final completedSegmentedControlValue = 0.obs;
  final isOtpVisible = false.obs;

  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final collegeNameTextController = TextEditingController();
  final otpTextController = TextEditingController();
  final linkedInProfileTextController = TextEditingController();
  final collegeCodeTextController = TextEditingController();
  final searchTextController = TextEditingController();
  final upComingContestList = <UpComingCollegeContest>[].obs;
  final upComingCollegeContest = UpComingCollegeContest().obs;
  final tempCompletedContestList = <CompletedCollegeContest>[].obs;
  final completedPremiumCollegeContestList = <CompletedCollegeContest>[].obs;
  final completedFreeCollegeContestList = <CompletedCollegeContest>[].obs;
  final collegeContestLeaderboardList = <CollegeContestLeaderboard>[].obs;
  final completedCollegeContestList = <CompletedCollegeContest>[].obs;
  final completedCollegeContest = CompletedCollegeContest().obs;
  final upcomingPremiumCollegeContestList = <UpComingCollegeContest>[].obs;
  final upcomingFreeCollegeContestList = <UpComingCollegeContest>[].obs;
  final completedContestPnlList = <CompletedContestPnl>[].obs;
  final contestOrdersList = <ContestOrderDetails>[].obs;
  final liveCollegeContestList = <LiveCollegeContest>[].obs;
  final livePremiumCollegeContestList = <LiveCollegeContest>[].obs;
  final liveFreeCollegeContestList = <LiveCollegeContest>[].obs;
  final liveCollegeContest = LiveCollegeContest().obs;
  final contestPositionsList = <TradingPosition>[].obs;
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
  final selectedStringQuantity = "0".obs;
  final instrumentLivePriceList = <InstrumentLivePrice>[].obs;

  final myRank = 0.obs;
  final liveLeaderboardList = <LiveContestLeaderboard>[].obs;
  final liveLeaderboard = LiveContestLeaderboard().obs;

  final completedContestLeaderboardList = <CompletedContestLeaderboardList>[].obs;
  final completedContestLeaderboard = CompletedContestLeaderboardList().obs;
  final marginRequired = MarginRequiredResponse().obs;
  final featuredCollegeContest = FeaturedCollegeContest().obs;

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
    await getLiveCollegeContestList();
    await getUpComingCollegeContestList();
    await getCompletedCollegeContestList();
    await getCompletedContestPnlList();
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
    socketConnection();
    socketIndexConnection();
    socketLeaderboardConnection();
    socketSendConnection();
  }

  Future loadDataAfterPaymentSuccess() async {
    await Get.find<AuthController>().getUserDetails(navigate: false);
    await loadUserDetails();
    getUpComingCollegeContestList();
    getLiveCollegeContestList();
  }

  Future loadRegisterData() async {
    userDetails.value = AppStorage.getUserDetails();
    await getUpComingCollegeContestList();
  }

  void gotoTradingView() {
    loadTradingData();
    Get.to(() => CollegeContestTradingView());
  }

  bool handleTextField(TransactionType type, int transactionLotSize, int positionLots) {
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

  void downloadFile() async {
    Directory dir = await getApplicationDocumentsDirectory();

    String path = dir.path;
    String docsFolderPath = '$path/StoxHero/docs';
    String filePath = '$docsFolderPath/Certificate.pdf';
    String apiUrl = '${AppUrls.completedCollegeContestCertificate(completedCollegeContest.value.id)}';

    await File(filePath).create(recursive: true);
    Get.find<NetworkService>().downloadFile(path: apiUrl, filePath: filePath);
    await OpenFilex.open(filePath);
  }

  bool isUserInterested(contest, userId) {
    if (contest.interestedUsers != null) {
      for (InterestedUserss user in contest.interestedUsers) {
        if (user.userId?.id == userId) {
          return true;
        }
      }
    }
    return false;
  }

  bool participateUser(contest, userId) {
    if (contest.participants != null) {
      for (CollegeParticipants user in contest.participants) {
        if (user.userId?.sId == userId) {
          return true;
        }
      }
    }
    return false;
  }

  String getPaidCapAmount(num fees, num cap) {
    num percentage = (fees * cap) / 100;
    return FormatHelper.formatNumbers(percentage, showDecimal: false);
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
    num livePayoutPercentage = liveCollegeContest.value.payoutPercentage ?? 0;
    num featuredPayoutPercentage = featuredCollegeContest.value.payoutPercentage ?? 0;
    num totalNetPNL = calculateTotalNetPNL();
    num npnl = totalNetPNL * (featuredPayoutPercentage != 0 ? featuredPayoutPercentage : livePayoutPercentage);
    num payout = npnl <= 0 ? 0 : npnl / 100;
    return payout;
  }

  num calculateUserPayout(dynamic netPnl) {
    num livePayoutPercentage = liveCollegeContest.value.payoutPercentage ?? 0;
    num featuredPayoutPercentage = featuredCollegeContest.value.payoutPercentage ?? 0;
    num reward = netPnl * (featuredPayoutPercentage != 0 ? featuredPayoutPercentage : livePayoutPercentage);
    num payout = reward <= 0 ? 0 : reward / 100;
    return payout;
  }

  Future calculateUserWalletAmount() async {
    num amount = 0;
    var response = await Get.find<WalletRepository>().getWalletTransactionsList();
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
    return AppColors.grey;
  }

  int calculateSeatsLeft(int maxParticipants, int currentParticipants) {
    int seatsLeft = maxParticipants - currentParticipants;
    return seatsLeft;
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
    Get.toNamed(AppRoutes.collegeContestSearchSymbol);
  }

  bool checkIfPurchased(UpComingCollegeContest? contest) {
    bool isPurchased = false;
    for (UpcomingCollegeParticipants? user in contest?.participants ?? []) {
      if (user?.userId?.id == userDetails.value.sId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  bool checkIfLivePurchased(contest) {
    bool isPurchased = false;
    for (CollegeParticipants? user in contest?.participants) {
      if (user?.userId?.sId == userDetails.value.sId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  bool checkIfLiveFeaturedPurchased(FeaturedCollegeContest? contest, String userId) {
    bool isPurchased = false;
    for (FeaturedParticipants? user in contest?.participants ?? []) {
      if (user?.userId?.id == userId) {
        isPurchased = true;
      }
    }
    return isPurchased;
  }

  bool canUserTrade(contest) {
    bool canParticipate = false;
    if (contest.participants != null) {
      for (CollegeParticipants participant in contest.participants) {
        if (participant.userId?.sId == userDetails.value.sId) {
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

  num calculateGrossPNL(num amount, int lots, num ltp) {
    if (ltp == 0) return 0;
    num pnl = 0;
    num value = (amount + (lots * ltp));
    pnl += value;
    return pnl;
  }

  num calculateTotalGrossPNL() {
    num totalGross = 0;
    for (var position in contestPositionsList) {
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
    num lots = 0;
    num margin = 0;
    for (var position in contestPositionsList) {
      if (position.lots != 0) {
        lots += position.lots ?? 0;
        margin += position.margin ?? 0;
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
        ? (lots == 0 ? (openingBalance - margin + calculateTotalNetPNL()) : (openingBalance - margin))
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
        (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
      );
      if (index == -1) {
        int index = instrumentLivePriceList.indexWhere(
          (stock) => stock.instrumentToken == instID || stock.instrumentToken == exchID,
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
    isPortfolioStateLoading(true);
    try {
      final RepoResponse<ContestPortfolioResponse> response =
          await repository.getContestPortfolio(featuredCollegeContest.value.id ?? liveCollegeContest.value.id);
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
      final RepoResponse<TradingWatchlistResponse> response = await repository.getContestWatchList(
        featuredCollegeContest.value.isNifty ?? liveCollegeContest.value.isNifty,
        featuredCollegeContest.value.isBankNifty ?? liveCollegeContest.value.isBankNifty,
        featuredCollegeContest.value.isFinNifty ?? liveCollegeContest.value.isFinNifty,
      );
      if (response.data != null) {
        if (response.data?.data! != null) {
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
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isWatchlistStateLoading(false);
  }

  Future getContestPositions() async {
    isPositionStateLoading(true);
    try {
      final RepoResponse<TradingPositionListResponse> response =
          await repository.getContestPositions(featuredCollegeContest.value.id ?? liveCollegeContest.value.id);
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
      subscriptionId: featuredCollegeContest.value.id ?? liveCollegeContest.value.id,
      battleId: featuredCollegeContest.value.id ?? liveCollegeContest.value.id,
      contestId: featuredCollegeContest.value.id ?? liveCollegeContest.value.id,
      marginxId: featuredCollegeContest.value.id ?? liveCollegeContest.value.id,
      triggerPrice: "",
      deviceDetails: DeviceDetails(
        deviceType: 'Mobile',
        platformType: Platform.isAndroid ? 'Android' : 'iOS',
      ),
    );
    log('placeContestTradingOrder : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.placeContestOrder(
        data.toJson(),
      );
      log(response.data.toString());
      Get.back();
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

  Future searchInstruments(String? value, {bool showShimmer = true}) async {
    showShimmer ? isInstrumentListLoading(true) : isWatchlistStateLoading(true);
    try {
      final RepoResponse<TradingInstrumentListResponse> response = await repository.searchInstruments(
        value,
        featuredCollegeContest.value.isNifty ?? liveCollegeContest.value.isNifty,
        featuredCollegeContest.value.isBankNifty ?? liveCollegeContest.value.isBankNifty,
        featuredCollegeContest.value.isFinNifty ?? liveCollegeContest.value.isFinNifty,
      );
      if (response.data != null) {
        if (response.data?.data != null) {
          tradingInstruments.clear();
          tradingInstruments(response.data?.data ?? []);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    showShimmer ? isInstrumentListLoading(false) : isWatchlistStateLoading(false);
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

    log('addInstrument : ${data.toJson()}');
    try {
      final RepoResponse<GenericResponse> response = await repository.addInstrument(
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
      final RepoResponse<InstrumentLivePriceListResponse> response = await repository.getInstrumentLivePrices();
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
      socketService.socket.on(
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
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getCollegeContestLeaderboardList() async {
    isLeaderboardLoading(true);
    collegeContestLeaderboardList.clear();
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
    isLeaderboardLoading(false);
  }

  Future getCompletedCollegeContestList() async {
    isCompletedLoading(true);
    completedFreeCollegeContestList.clear();
    completedPremiumCollegeContestList.clear();
    try {
      final RepoResponse<CompletedCollegeContestListResponse> response =
          await repository.getCompletedCollegeContestList();
      if (response.data != null) {
        tempCompletedContestList(response.data?.data ?? []);
        if (tempCompletedContestList.isNotEmpty) {
          tempCompletedContestList.forEach((contest) {
            (contest.entryFee == null || contest.entryFee == 0)
                ? completedFreeCollegeContestList.add(contest)
                : completedPremiumCollegeContestList.add(contest);
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
      final RepoResponse<CompletedContestPnlListResponse> response = await repository.getCompletedContestPnlList();
      if (response.data != null) {
        List<CompletedCollegeContest> tempList = [];
        completedContestPnlList(response.data?.data ?? []);
        if (tempCompletedContestList.isNotEmpty && completedContestPnlList.isNotEmpty) {}
        completedCollegeContestList(tempList);
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
    isUpcomingLoading(true);
    upcomingFreeCollegeContestList.clear();
    upcomingPremiumCollegeContestList.clear();
    try {
      final RepoResponse<UpComingCollegeContestListResponse> response =
          await repository.getUpComingCollegeContestList();
      if (response.data != null) {
        upComingContestList(response.data?.data ?? []);
        if (upComingContestList.isNotEmpty) {
          upComingContestList.forEach((contest) {
            (contest.entryFee == null || contest.entryFee == 0)
                ? upcomingFreeCollegeContestList.add(contest)
                : upcomingPremiumCollegeContestList.add(contest);
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

  Future getContestOrderList(String? id) async {
    isCompletedOrdersLoading(true);
    try {
      final RepoResponse<ContestOrderResponse> response = await repository.getContestOrderList(id);
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

  Future getLiveCollegeContestList() async {
    isLiveLoading(true);
    liveFreeCollegeContestList.clear();
    livePremiumCollegeContestList.clear();
    try {
      final RepoResponse<LiveCollegeContestListResponse> response = await repository.getLiveCollegeContestList();
      if (response.data != null) {
        liveCollegeContestList(response.data?.data ?? []);
        if (liveCollegeContestList.isNotEmpty) {
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
    isLiveLoading(false);
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
      loadDataAfterPaymentSuccess();
    } catch (e) {
      log(e.toString());
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

  Future socketLeaderboardConnection() async {
    try {
      var rankData = {
        "employeeId": userDetails.value.employeeid,
        "userId": userDetails.value.sId,
        "id": featuredCollegeContest.value.id ?? liveCollegeContest.value.id,
      };
      log('Socket Emit RankData : $rankData');

      socketService.socket.emit('dailyContestLeaderboard', rankData);

      socketService.socket.on(
        'contest-myrank${userDetails.value.sId}${featuredCollegeContest.value.id ?? liveCollegeContest.value.id}',
        (data) {
          log('Socket MyRank : contest-myrank${userDetails.value.sId}${featuredCollegeContest.value.id ?? liveCollegeContest.value.id} : $data');
          myRank(data);
        },
      );

      socketService.socket.on(
        'contest-leaderboardData${featuredCollegeContest.value.id ?? liveCollegeContest.value.id}',
        (data) {
          log('Socket Leaderboard : contest-leaderboardData${featuredCollegeContest.value.id ?? liveCollegeContest.value.id} $data');
          liveLeaderboardList.value = LiveContestLeaderboardReponse.fromJson(data).data ?? [];
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> getShareContest(bool isUpcoming) async {
    isLoading(true);

    try {
      await repository.getShareContest(isUpcoming
          ? upComingCollegeContest.value.id
          : featuredCollegeContest.value.id ?? liveCollegeContest.value.id);

      if (isUpcoming) {
        getUpComingCollegeContestList();
      } else {
        getLiveCollegeContestList();
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
      await repository.getNotified(upComingCollegeContest.value.id);
      getUpComingCollegeContestList();
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future verifyAndParticipate(LiveCollegeContest? contest) async {
    isLoading(true);
    CollegeContestCodeRequest data = CollegeContestCodeRequest(
      collegeCode: collegeCodeTextController.text.trim(),
    );
    try {
      final response = await repository.verifyAndParticipate(
        liveCollegeContest.value.id,
        data.toJson(),
      );
      if (response.data?.status?.toLowerCase() == "success") {
        getLiveCollegeContestList();
        collegeCodeTextController.clear();
        loadTradingData();
        Get.to(() => CollegeContestTradingView());
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future verifyAndFeatureParticipate(FeaturedCollegeContest? contest) async {
    isLoading(true);
    CollegeContestCodeRequest data = CollegeContestCodeRequest(
      collegeCode: collegeCodeTextController.text.trim(),
    );
    try {
      final response = await repository.verifyAndParticipate(
        featuredCollegeContest.value.id,
        data.toJson(),
      );
      if (response.data?.status?.toLowerCase() == "success") {
        Get.find<ContestController>().getFeaturedContest();
        collegeCodeTextController.clear();
        loadTradingData();
        Get.to(() => CollegeContestTradingView());
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      print(e.toString());
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
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isCompletedLeaderboardLoading(false);
  }

  int calculateQuantity(TransactionType type, int tradingLots, int selectQuantity) {
    if (type == TransactionType.sell || type == TransactionType.exit) {
      if (tradingLots == selectQuantity || tradingLots.abs() >= selectQuantity) {
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
      quantity: calculateQuantity(type, inst.lotSize ?? 0, selectedQuantity.value),
      product: "NRML",
      orderType: selectedType.value,
      validity: "DAY",
      variety: "regular",
      price: limitPriceTextController.text,
      lastPrice: inst.lastPrice.toString(),
    );

    try {
      final RepoResponse<MarginRequiredResponse> response = await repository.getMarginRequired(
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
      final RepoResponse<ContestOrderResponse> response = await repository.getContestOrderList(
        featuredCollegeContest.value.id ?? liveCollegeContest.value.id,
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
      final RepoResponse<StopLossExecutedOrdersListResponse> response = await repository.getStopLossExecutedOrder(
        featuredCollegeContest.value.id ?? liveCollegeContest.value.id,
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
      final RepoResponse<StopLossPendingOrdersListResponse> response = await repository.getStopLossPendingOrder(
        featuredCollegeContest.value.id ?? liveCollegeContest.value.id,
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

  Future pendingOrderModify(TransactionType type, TradingInstrument inst) async {
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
      id: featuredCollegeContest.value.id ?? liveCollegeContest.value.id,
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
      final RepoResponse<GenericResponse> response = await repository.pendingOrderModify(
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
}
