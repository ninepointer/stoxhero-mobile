import '../../../main.dart';

class AppUrls {
  static const String baseURL = isProd ? 'https://stoxhero.com' : 'http://43.204.7.180';
  static const String apiURL = '$baseURL/api/v1';

  static const String tenx = '$apiURL/tenX';

  static const String signup = "$apiURL/signup";
  static const String phoneLogin = "$apiURL/phonelogin";
  static const String verifyPhoneLogin = "$apiURL/verifyphonelogin";
  static const String verifyOtp = "$apiURL/verifyotp";
  static const String resendSigninOtp = "$apiURL/resendmobileotp";
  static const String resendSignupOtp = "$apiURL/resendotp";
  static const String loginDetails = "$apiURL/loginDetail";
  static const String updateUserDetails = "$apiURL/userdetail/me";
  static const String myPortfolio = "$apiURL/portfolio/myPortfolio";
  static const String myTenx = "$apiURL/portfolio/myTenx";
  static const String virtualTradingPortfolio = "$apiURL/paperTrade/margin";

  static const String earnings = "$apiURL/earnings";
  static const String referralsActive = "$apiURL/referrals/active";
  static const String referralsLeaderboard = "$apiURL/referrals/leaderboard";
  static const String referralsMyRank = "$apiURL/referrals/myrank";
  static const String myReferrals = "$apiURL/myreferrals";
  static const String tenxActive = "$apiURL/tenx/active";
  static const String stockIndex = "$apiURL/stockindex";
  static const String infinityTradeTodaysOrders = "$apiURL/infinityTrade/my/todayorders";
  static const String infinityTradeAllOrders = "$apiURL/infinityTrade/my/historyorders";

  static const String tenxTradeTodaysOrders = "$apiURL/tenx/my/todayorders";
  static const String tenxTradeAllOrders = "$apiURL/tenx/my/historyorders";

  static const String paperTradeTodaysOrders = "$apiURL/paperTrade/my/todayorders";
  static const String paperTradeAllOrders = "$apiURL/paperTrade/my/historyorders";
  static const String paperTradePosition = "$apiURL/paperTrade/pnl";
  static const String paperTradePlacingOrder = "$apiURL/paperTrade";

  static const String userWalletTransactions = "$apiURL/userwallet/my";

  static const String virtualTradingAnalyticsOverView = "$apiURL/analytics/papertrade/myoverview";
  static const String tenxTradingAnalyticsOverView = "$apiURL/analytics/stoxhero/myoverview";
  static const String infinityTradingAnalyticsOverView = "$apiURL/analytics/infinity/myoverview";
  // static String analyticsExpectedPnL(String? trade) =>
  //     "$apiURL/userdashboard/expectedpnl?tradeType=$trade";
  static const String analyticsExpectedPnL = "$apiURL/userdashboard/expectedpnl?tradeType=virtual";
  static const String analyticsVirtualMonthlyPnL = "$apiURL/analytics/papertrade/mymonthlypnl";

  static const String virtualTradingDateWiseAnalytics = "$apiURL/analytics/papertrade/mystats";
  static const String tenxTradingDateWiseAnalytics = "$apiURL/analytics/stoxhero/mystats";
  static const String infinityTradingDateWiseAnalytics = "$apiURL/analytics/infinity/mystats";

  static const String tradingInstruments = "$apiURL/tradableInstruments";
  static const String tradingInstrumentWatchlist = "$apiURL/instrumentDetails";
  static const String getliveprice = "$apiURL/getliveprice";

  static const String tenxTradingPlacingOrder = "$apiURL/tenxPlacingOrder";
  static const String addInstrument = "$apiURL/addInstrument";
  static const String inActiveInstrument = "$apiURL/inactiveInstrument";
  static const String purchaseIntent = "$tenx/capturepurchaseintent";
  static const String purchaseSubscription = "$apiURL/userwallet/deduct";

  static const String liveContests = "$apiURL/dailycontest/contests/userlive";
  static const String upComingContests = "$apiURL/dailycontest/contests/upcoming";
  static const String completedContests = "$apiURL/dailycontest/contests/completed";
  static const String allContestPnl = "$apiURL/dailycontest/trade/allcontestPnl";
  static const String contestLeaderboard = "$apiURL/contestscoreboard/scoreboard";
  static const String contestTodaysOrders = "$apiURL/dailycontest/dailycontest/trade/my/todayorders";

  static const String liveCollageContests = "$apiURL/dailycontest/collagecontest/userlive";
  static const String upComingCollegeContests = "$apiURL/dailycontest/collegecontests/userupcoming";
  static const String completedCollegeContests = "$apiURL/dailycontest/contests/collegecompleted";
  static const String collegeContestLeaderboard = "$apiURL/contestscoreboard/collegescoreboard";
  static const String liveCollegeContests = "$apiURL/dailycontest/collegecontests/userlive";
  static String contestWatchList(bool? isNifty, bool? isBankNifty, bool? isFinNifty) =>
      "$apiURL/instrumentDetails?isNifty=$isNifty&isBankNifty=$isBankNifty&isFinNifty=$isFinNifty&dailyContest=true";
  static String contestCreditData(String? id) => "$apiURL/dailycontest/trade/$id/myPnlandCreditData";
  static String contestPosition(String? id) => "$apiURL/dailycontest/trade/$id/pnl";
  static const String contestPlacingOrder = "$apiURL/placingOrderDailyContest";

  static const String returnSummary = "$apiURL/userdashboard/summary";
  static const String dashboardCarousel = "$apiURL/carousels/home";
  static const String tutorial = "$apiURL/tutorialcategory/";

  static const String upComingMarginX = "$apiURL/marginx/userupcoming";
  static const String liveMarginx = "$apiURL/marginx/userlive";
  static const String completedMarginx = "$apiURL/marginx/usercompleted";

  static String completedContestOrders(String? id) => '$apiURL/dailycontest/trade/$id/my/todayorders';

  static String performance(String? tradeType, String? timeFrame) =>
      "$apiURL/userdashboard/stats?tradeType=$tradeType&timeframe=$timeFrame";

  static String careers(String? type) => "$apiURL/career?type=$type";

  static String completedMarginXOrders(String? id) => "$apiURL/marginxtrade/$id/my/allorders";
}
