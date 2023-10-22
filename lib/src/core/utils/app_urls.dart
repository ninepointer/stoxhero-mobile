import '../../../main.dart';

class AppUrls {
  static const String baseURL = isProd ? 'https://stoxhero.com' : 'http://43.204.7.180';
  static const String apiURL = '$baseURL/api/v1';

  static const String tenxYoutubeVideoLink = 'https://www.youtube.com/watch?v=a3_bmjv5tXQ';

  static const String appVersion = '$apiURL/mobileappversion';

  static const String tenx = '$apiURL/tenX';
  static const String tradeMarginDetails = 'trade/marginDetail';

  static const String stockIndex = "$apiURL/stockindex";

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
  static String tenxPortfolio(String? id) => "$apiURL/tenX/$id/trade/marginDetail";
  static const String earnings = "$apiURL/earnings";
  static const String referralsActive = "$apiURL/referrals/active";
  static const String referralsLeaderboard = "$apiURL/referrals/leaderboard";
  static const String referralsMyRank = "$apiURL/referrals/myrank";
  static const String myReferrals = "$apiURL/myreferrals";
  static const String tenxActive = "$apiURL/tenx/active";
  static const String tenxSubscription = "$apiURL/tenX/mySubscription";
  static const String withdrawal = "$apiURL/withdrawals";
  static const String infinityTradeTodaysOrders = "$apiURL/infinityTrade/my/todayorders";
  static const String infinityTradeAllOrders = "$apiURL/infinityTrade/my/historyorders";

  static String tenxTradeTodaysOrders(String? subscriptionId) => "$apiURL/tenX/my/todayorders/$subscriptionId";
  static String tenxTradeAllOrders(String? subId, String? subscribedOn, String? expiredOn) =>
      "$apiURL/tenX/my/historyorders/$subId/$subscribedOn/$expiredOn";

  static const String paperTradeTodaysOrders = "$apiURL/paperTrade/my/todayorders";
  static const String paperTradeAllOrders = "$apiURL/paperTrade/my/historyorders";

  static const String paperTradePosition = "$apiURL/paperTrade/pnl";
  static const String paperTradePlacingOrder = "$apiURL/paperTrade";

  static const String userWalletTransactions = "$apiURL/userwallet/my";

  static const String virtualTradingAnalyticsOverView = "$apiURL/analytics/papertrade/myoverview";
  static const String tenxTradingAnalyticsOverView = "$apiURL/analytics/stoxhero/myoverview";
  static const String infinityTradingAnalyticsOverView = "$apiURL/analytics/infinity/myoverview";
  static const String virtualAnalyticsExpectedPnL = "$apiURL/userdashboard/expectedpnl?tradeType=virtual";
  static const String tenXAnalyticsExpectedPnL = "$apiURL/userdashboard/expectedpnl?tradeType=tenX";
  static const String infinityAnalyticsExpectedPnL = "$apiURL/userdashboard/expectedpnl?tradeType=infinity";
  static const String analyticsVirtualMonthlyPnL = "$apiURL/analytics/papertrade/mymonthlypnl";
  static const String analyticsTenXMonthlyPnl = "$apiURL/analytics/stoxhero/mymonthlypnl";
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

  static const String purchaseContestIntent = "$apiURL/dailycontest/purchaseintent/";
  static const String purchaseContest = "$apiURL/dailycontest/feededuct";
  static const String upComingContests = "$apiURL/dailycontest/contests/userupcoming";
  static const String liveContests = "$apiURL/dailycontest/contests/userlive";
  static const String completedContests = "$apiURL/dailycontest/contests/completed";
  static const String allContestPnl = "$apiURL/dailycontest/trade/allcontestPnl";
  static const String contestLeaderboard = "$apiURL/contestscoreboard/scoreboard";
  static const String contestPlacingOrder = "$apiURL/placingOrderDailyContest";
  static const String contestTodaysOrders = "$apiURL/dailycontest/dailycontest/trade/my/todayorders";
  static String completedContestLeaderboard(String? id) => "$apiURL/dailycontest/contestleaderboard/$id";
  static String completedContestOrders(String? id) => '$apiURL/dailycontest/trade/$id/my/todayorders';
  static String completedCollegeContestCertificate(String? id) => "$apiURL/dailycontest/download/$id";
  static String contestInstrumentWatchList(bool? isNifty, bool? isBankNifty, bool? isFinNifty) =>
      "$apiURL/instrumentDetails?isNifty=$isNifty&isBankNifty=$isBankNifty&isFinNifty=$isFinNifty&dailyContest=true";

  static String contestCreditData(String? id) => "$apiURL/dailycontest/trade/$id/myPnlandCreditData";

  static String contestPosition(String? id) => "$apiURL/dailycontest/trade/$id/pnl";

  static String contestsTradingInstruments(bool? isNifty, bool? isBankNifty, bool? isFinNifty) =>
      "$apiURL/tradableInstruments?isNifty=$isNifty&isBankNifty=$isBankNifty&isFinNifty=$isFinNifty&dailyContest=Daily Contest";

  static const String upComingCollegeContests = "$apiURL/dailycontest/collegecontests/userupcoming";
  static const String liveCollegeContests = "$apiURL/dailycontest/collegecontests/userlive";
  static const String completedCollegeContests = "$apiURL/dailycontest/contests/collegecompleted";
  static const String collegeContestLeaderboard = "$apiURL/contestscoreboard/collegescoreboard";
  static const String generateCollegeContestOtp = "$apiURL/dailycontest/generateotp";
  static const String confirmCollegeContestOtp = "$apiURL/dailycontest/confirmotp";
  static String shareContest(String? id) => "$apiURL/dailycontest/contest/$id/share";
  static String getNotified(String? id) => "$apiURL/dailycontest/contest/$id/register";
  static String participate(String? id) => "$apiURL/dailycontest/contest/$id/participate";
  static const String returnSummary = "$apiURL/userdashboard/summary";
  static const String dashboardCarousel = "$apiURL/carousels/home";
  static const String tutorial = "$apiURL/tutorialcategory/";

  static const String liveMarginx = "$apiURL/marginx/userlive";
  static const String upComingMarginX = "$apiURL/marginx/userupcoming";
  static const String completedMarginx = "$apiURL/marginx/usercompleted";
  static String marginXPosition(String? id) => "$apiURL/marginxtrade/$id/pnl";
  static String marginXCreditData(String? id) => "$apiURL/marginxtrade/$id/myPnlandCreditData";
  static String marginXInstrumentWatchList(bool? isNifty, bool? isBankNifty, bool? isFinNifty) =>
      "$apiURL/instrumentDetails?isNifty=$isNifty&isBankNifty=$isBankNifty&isFinNifty=$isFinNifty&dailyContest=true";
  static String marginXTradingInstruments(bool? isNifty, bool? isBankNifty, bool? isFinNifty) =>
      "$apiURL/tradableInstruments?isNifty=$isNifty&isBankNifty=$isBankNifty&isFinNifty=$isFinNifty&dailyContest=true";

  static const String marginXPlaceOrder = "$apiURL/placingOrderMarginx";
  static const String purchaseMarginX = "$apiURL/marginx/feededuct";
  static String completedMarginXOrders(String? id) => "$apiURL/marginxtrade/$id/my/allorders";

  static String performance(String? tradeType, String? timeFrame) =>
      "$apiURL/userdashboard/stats?tradeType=$tradeType&timeframe=$timeFrame";

  static String careers(String? type) => "$apiURL/career/live?type=$type";
  static const String generateCareerOtp = "$apiURL/career/generateotp";
  static const String confirmCareerOtp = "$apiURL/career/confirmotp";

  static const String internshipBatch = "$apiURL/internbatch/currentinternship";
  static const String internshipPlaceOrder = "$apiURL/internPlacingOrder";
  static String internshipPosition(String? id) => "$apiURL/internship/pnl/$id";
  static String internshipOverview(String? id) => "$apiURL/analytics/internship/myoverview/$id";
  static String internshipMonthlyPNL(String? id) => "$apiURL/analytics/internship/mymonthlypnl/$id";
  static String internshipDateWisePNL(String? id) => "$apiURL/analytics/internship/mystats/$id";
  static String internshipBatchPortfolio(String? id) => "$apiURL/internship/marginDetail/$id";
  static const String internshipAllOrders = "$apiURL/internship/my/historyorders";
  static const String internshipTodayOrders = "$apiURL/internship/my/todayorders";
  static String tenxCountTradingDays(String? id) => "$apiURL/tenX/$id/trade/countTradingDays";
  static String shareMarginX(String? id) => "$apiURL/marginx/share/$id";
  static String tenxSubscriberCount(String? id) => "$apiURL/tenX/subscribercount/$id";
  static const String tenxMyActiveSubscribed = "$apiURL/tenX/myactivesubs";
  static const String tenxMyExpiredSubscription = "$apiURL/tenX/myexpiredsubscription";
  static const String tenxleaderboard = "$apiURL/tenX/tenxleaderboard";
  static const String tenxRenew = "$apiURL/tenX/renew";
  static const String tenxTutorial = "$apiURL/tenX/tenxtutorialview";
  static const String careerApply = "$apiURL/career/apply";
  static const String myWithdrawals = "$apiURL/withdrawals/mywithdrawals";
  static String verifyAndParticipate(String? id) => "$apiURL/dailycontest/contest/$id/varifycodeandparticipate";
}
