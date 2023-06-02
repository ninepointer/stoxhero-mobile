class AppUrls {
  static const String baseURL = 'https://stoxhero.com/api/v1';

  static const String signup = "$baseURL/signup";
  static const String phoneLogin = "$baseURL/phonelogin";
  static const String verifyPhoneLogin = "$baseURL/verifyphonelogin";
  static const String verifyOtp = "$baseURL/verifyotp";
  static const String resendSigninOtp = "$baseURL/resendmobileotp";
  static const String resendSignupOtp = "$baseURL/resendotp";
  static const String loginDetails = "$baseURL/loginDetail";
  static const String updateUserDetails = "$baseURL/userdetail/me";
  static const String myPortfolio = "$baseURL/portfolio/myPortfolio";

  static const String referralsActive = "$baseURL/referrals/active";
  static const String referralsLeaderboard = "$baseURL/referrals/leaderboard";
  static const String referralsMyRank = "$baseURL/referrals/myrank";
  static const String tenxActive = "$baseURL/tenx/active";

  static const String infinityTradeTodaysOrders = "$baseURL/infinityTrade/my/todayorders";
  static const String infinityTradeAllOrders = "$baseURL/infinityTrade/my/historyorders";

  static const String tenxTradeTodaysOrders = "$baseURL/tenx/my/todayorders";
  static const String tenxTradeAllOrders = "$baseURL/tenx/my/historyorders";

  static const String paperTradeTodaysOrders = "$baseURL/paperTrade/my/todayorders";
  static const String paperTradeAllOrders = "$baseURL/paperTrade/my/historyorders";

  static const String userWalletTransactions = "$baseURL/userwallet/my";

  static const String virtualTradingAnalyticsOverView = "$baseURL/analytics/papertrade/myoverview";
  static const String tenxTradingAnalyticsOverView = "$baseURL/analytics/stoxhero/myoverview";
  static const String infinityTradingAnalyticsOverView = "$baseURL/analytics/infinity/myoverview";

  static const String virtualTradingDateWiseAnalytics = "$baseURL/analytics/papertrade/mystats";
  static const String tenxTradingDateWiseAnalytics = "$baseURL/analytics/stoxhero/mystats";
  static const String infinityTradingDateWiseAnalytics = "$baseURL/analytics/infinity/mystats";
}
