import '../../../main.dart';

class AppUrls {
  static const String baseURL = isTesting ? 'http://43.204.7.180' : 'https://stoxhero.com';
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

  static const String earnings = "$apiURL/earnings";
  static const String referralsActive = "$apiURL/referrals/active";
  static const String referralsLeaderboard = "$apiURL/referrals/leaderboard";
  static const String referralsMyRank = "$apiURL/referrals/myrank";
  static const String myReferrals = "$apiURL/myreferrals";
  static const String tenxActive = "$apiURL/tenx/active";

  static const String infinityTradeTodaysOrders = "$apiURL/infinityTrade/my/todayorders";
  static const String infinityTradeAllOrders = "$apiURL/infinityTrade/my/historyorders";

  static const String tenxTradeTodaysOrders = "$apiURL/tenx/my/todayorders";
  static const String tenxTradeAllOrders = "$apiURL/tenx/my/historyorders";

  static const String paperTradeTodaysOrders = "$apiURL/paperTrade/my/todayorders";
  static const String paperTradeAllOrders = "$apiURL/paperTrade/my/historyorders";

  static const String userWalletTransactions = "$apiURL/userwallet/my";

  static const String virtualTradingAnalyticsOverView = "$apiURL/analytics/papertrade/myoverview";
  static const String tenxTradingAnalyticsOverView = "$apiURL/analytics/stoxhero/myoverview";
  static const String infinityTradingAnalyticsOverView = "$apiURL/analytics/infinity/myoverview";

  static const String virtualTradingDateWiseAnalytics = "$apiURL/analytics/papertrade/mystats";
  static const String tenxTradingDateWiseAnalytics = "$apiURL/analytics/stoxhero/mystats";
  static const String infinityTradingDateWiseAnalytics = "$apiURL/analytics/infinity/mystats";

  static const String tenxTradingSearchInstruments = "$apiURL/tradableInstruments";
  static const String tenxTradingWatchlist = "$apiURL/instrumentDetails";
  static const String getliveprice = "$apiURL/getliveprice";

  static const String tenxTradingPlacingOrder = "$apiURL/tenxPlacingOrder";
  static const String addInstrument = "$apiURL/addInstrument";
  static const String inActiveInstrument = "$apiURL/inactiveInstrument";
  static const String purchaseIntent = "$tenx/capturepurchaseintent";
  static const String purchaseSubscription = "$apiURL/userwallet/deduct";

  static const String upComingContests = "$apiURL/dailycontest/contests/upcoming";
  static const String completedContests = "$apiURL/dailycontest/contests/completed";
  static const String allContestPnl = "$apiURL/dailycontest/trade/allcontestPnl";
}
