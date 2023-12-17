import '../../../main.dart';

class AppUrls {
  static const String baseURL =
      isProd ? 'https://stoxhero.com' : 'http://43.204.7.180';
  static const String apiURL = '$baseURL/api/v1';

  static const String referralWebUrl = 'https://www.stoxhero.com/?referral=';

  static const String paymentCallBackUrl =
      "https://stoxhero.com/api/v1/payment/callback";

  static const String tenxYoutubeVideoLink =
      'https://www.youtube.com/watch?v=a3_bmjv5tXQ';

  static const String appVersion = '$apiURL/mobileappversion';
  static const String defaultInviteCode = "$apiURL/campaign/defaultinvite";
  static const String makePayment = "$apiURL/payment/makepayment";
  static const String checkPaymentStatus = "$apiURL/payment/checkstatus";

  static const String tenx = '$apiURL/tenX';
  static const String tradeMarginDetails = 'trade/marginDetail';

  static const String stockIndex = "$apiURL/stockindex";
  static const String getIndexLivePrice = "$apiURL/getIndexliveprice";
  static const String collegeList = "$apiURL/college/collegeList";

  static const String addFcmToken = "$apiURL/addfcmtoken";

  static const String signup = "$apiURL/signup";
  static const String phoneLogin = "$apiURL/phonelogin";
  static const String verifyPhoneLogin = "$apiURL/verifyphonelogin";
  static const String verifyOtp = "$apiURL/verifyotp";
  static const String resendSigninOtp = "$apiURL/resendmobileotp";
  static const String resendSignupOtp = "$apiURL/resendotp";
  static const String loginDetails = "$apiURL/loginDetail";
  static const String updateUserDetails = "$apiURL/userdetail/me";
  static const String readSetting = "$apiURL/readsetting";

  static const String myTenx = "$apiURL/portfolio/myTenx";
  static const String tenxActive = "$apiURL/tenx/active";
  static const String tenxSubscription = "$apiURL/tenX/mySubscription";
  static const String tenxMyActiveSubscribed = "$apiURL/tenX/myactivesubs";

  static const String tenxMyExpiredSubscription =
      "$apiURL/tenX/myexpiredsubscription";
  static const String tenxleaderboard = "$apiURL/tenX/tenxleaderboard";
  static const String tenxRenew = "$apiURL/tenX/renew";
  static const String tenxTutorial = "$apiURL/tenX/tenxtutorialview";

  static const String myPortfolio = "$apiURL/portfolio/myPortfolio";
  static const String virtualTradingPortfolio = "$apiURL/paperTrade/margin";
  static const String earnings = "$apiURL/earnings";
  static const String referralsActive = "$apiURL/referrals/active";
  static const String referralsLeaderboard = "$apiURL/referrals/leaderboard";
  static const String referralsMyRank = "$apiURL/referrals/myrank";
  static const String myReferrals = "$apiURL/myreferrals";
  static const String withdrawal = "$apiURL/withdrawals";
  static const String userWalletTransactions = "$apiURL/userwallet/my";
  static const String returnSummary = "$apiURL/userdashboard/summary";
  static const String dashboardCarousel = "$apiURL/carousels/home";

  static const String infinityTradeTodaysOrders =
      "$apiURL/infinityTrade/my/todayorders";
  static const String infinityTradeAllOrders =
      "$apiURL/infinityTrade/my/historyorders";
  static const String verifyCouponCode = "$apiURL/coupons/verify";

  static const String paperTradeTodaysOrders =
      "$apiURL/paperTrade/my/todayorders";
  static const String paperTradeAllOrders =
      "$apiURL/paperTrade/my/historyorders";

  static const String paperTradePosition = "$apiURL/paperTrade/pnl";
  static const String paperTradePlacingOrder = "$apiURL/paperTrade";

  static const String virtualTradingAnalyticsOverView =
      "$apiURL/analytics/papertrade/myoverview";
  static const String virtualAnalyticsExpectedPnL =
      "$apiURL/userdashboard/expectedpnl?tradeType=virtual";
  static const String analyticsVirtualMonthlyPnL =
      "$apiURL/analytics/papertrade/mymonthlypnl";
  static const String virtualTradingDateWiseAnalytics =
      "$apiURL/analytics/papertrade/mystats";

  static const String tenxTradingAnalyticsOverView =
      "$apiURL/analytics/stoxhero/myoverview";
  static const String tenXAnalyticsExpectedPnL =
      "$apiURL/userdashboard/expectedpnl?tradeType=tenX";
  static const String analyticsTenXMonthlyPnl =
      "$apiURL/analytics/stoxhero/mymonthlypnl";
  static const String tenxTradingDateWiseAnalytics =
      "$apiURL/analytics/stoxhero/mystats";

  static const String infinityTradingAnalyticsOverView =
      "$apiURL/analytics/infinity/myoverview";
  static const String infinityAnalyticsExpectedPnL =
      "$apiURL/userdashboard/expectedpnl?tradeType=infinity";
  static const String infinityTradingDateWiseAnalytics =
      "$apiURL/analytics/infinity/mystats";

  static const String tradingInstruments = "$apiURL/tradableInstruments";
  static const String tradingInstrumentWatchlist = "$apiURL/instrumentDetails";
  static const String getliveprice = "$apiURL/getliveprice";

  static const String tenxTradingPlacingOrder = "$apiURL/tenxPlacingOrder";
  static const String addInstrument = "$apiURL/addInstrument";
  static const String inActiveInstrument = "$apiURL/inactiveInstrument";
  static const String purchaseIntent = "$tenx/capturepurchaseintent";
  static const String purchaseSubscription = "$apiURL/userwallet/deduct";

  static const String purchaseContestIntent =
      "$apiURL/dailycontest/purchaseintent/";
  static const String purchaseContest = "$apiURL/dailycontest/feededuct";
  static const String weeklyTopPerformers =
      "$apiURL/dailycontest/weeklytopperformer";
  static const String liveContests = "$apiURL/dailycontest/contests/userlive";
  static const String upComingContests =
      "$apiURL/dailycontest/contests/userupcoming";
  static const String completedContests =
      "$apiURL/dailycontest/contests/completed";
  static const String contestChampionList =
      "$apiURL/dailycontest/lastpaidcontestchampions";

  static const String allContestPnl =
      "$apiURL/dailycontest/trade/allcontestPnl";
  static const String contestLeaderboard =
      "$apiURL/contestscoreboard/scoreboard";
  static const String contestTodaysOrders =
      "$apiURL/dailycontest/dailycontest/trade/my/todayorders";
  static const String contestPlacingOrder = "$apiURL/placingOrderDailyContest";

  static const String featuredContest = "$apiURL/dailycontest/userfeatured";
  static const String liveCollegeContests =
      "$apiURL/dailycontest/collegecontests/userlive";
  static const String upComingCollegeContests =
      "$apiURL/dailycontest/collegecontests/userupcoming";
  static const String completedCollegeContests =
      "$apiURL/dailycontest/contests/collegecompleted";

  static const String collegeContestLeaderboard =
      "$apiURL/contestscoreboard/collegescoreboard";
  static const String generateCollegeContestOtp =
      "$apiURL/dailycontest/generateotp";
  static const String confirmCollegeContestOtp =
      "$apiURL/dailycontest/confirmotp";

  static const String tutorial = "$apiURL/tutorialcategory/";

  static const String liveMarginx = "$apiURL/marginx/userlive";
  static const String upComingMarginX = "$apiURL/marginx/userupcoming";
  static const String completedMarginx = "$apiURL/marginx/usercompleted";

  static const String marginXPlaceOrder = "$apiURL/placingOrderMarginx";
  static const String purchaseMarginX = "$apiURL/marginx/feededuct";

  static const String generateCareerOtp = "$apiURL/career/generateotp";
  static const String confirmCareerOtp = "$apiURL/career/confirmotp";

  static const String internshipBatch = "$apiURL/internbatch/currentinternship";
  static const String internshipPlaceOrder = "$apiURL/internPlacingOrder";
  static const String internshipAllOrders =
      "$apiURL/internship/my/historyorders";
  static const String internshipTodayOrders =
      "$apiURL/internship/my/todayorders";
  static const String internshipCertificate =
      "$apiURL/internbatch/eligibleforcertificate";
  static const String careerApply = "$apiURL/career/apply";
  static const String myWithdrawals = "$apiURL/withdrawals/mywithdrawals";
  static const String pendingOrderModify = "$apiURL/pendingorder/modify";
  static const String marginRequired = "$apiURL/marginrequired";

  static String internshipCertificateDownload(String? id) =>
      "$apiURL/internbatch/download/$id";
  static String tenxPortfolio(String? id) =>
      "$apiURL/tenX/$id/trade/marginDetail";
  static String tenxTradeTodaysOrders(String? subscriptionId) =>
      "$apiURL/tenX/my/todayorders/$subscriptionId";
  static String tenxTradeAllOrders(
          String? subId, String? subscribedOn, String? expiredOn) =>
      "$apiURL/tenX/my/historyorders/$subId/$subscribedOn/$expiredOn";

  static String completedContestLeaderboard(String? id) =>
      "$apiURL/dailycontest/contestleaderboard/$id";
  static String completedContestOrders(String? id) =>
      '$apiURL/dailycontest/trade/$id/my/todayorders';
  static String completedCollegeContestCertificate(String? id) =>
      "$apiURL/dailycontest/download/$id";
  static String tenXSubscribePNL(
          String? subscriptionId, String? subscribedOnTime) =>
      "$apiURL/tenX/$subscriptionId/trade/livesubscriptionpnl/$subscribedOnTime";

  static String contestInstrumentWatchList(
          bool? isNifty, bool? isBankNifty, bool? isFinNifty) =>
      "$apiURL/instrumentDetails?isNifty=$isNifty&isBankNifty=$isBankNifty&isFinNifty=$isFinNifty&dailyContest=true";

  static String contestCreditData(String? id) =>
      "$apiURL/dailycontest/trade/$id/myPnlandCreditData";
  static String contestPosition(String? id) =>
      "$apiURL/dailycontest/trade/$id/pnl";
  static String contestsTradingInstruments(
          bool? isNifty, bool? isBankNifty, bool? isFinNifty) =>
      "$apiURL/tradableInstruments?isNifty=$isNifty&isBankNifty=$isBankNifty&isFinNifty=$isFinNifty&dailyContest=Daily Contest";

  static String shareContest(String? id) =>
      "$apiURL/dailycontest/contest/$id/share";
  static String getNotified(String? id) =>
      "$apiURL/dailycontest/contest/$id/register";
  static String participate(String? id) =>
      "$apiURL/dailycontest/contest/$id/participate";
  static String featuredParticipate(String? id) =>
      "$apiURL/dailycontest/contest/$id/participate";

  static String marginXPosition(String? id) => "$apiURL/marginxtrade/$id/pnl";
  static String marginXCreditData(String? id) =>
      "$apiURL/marginxtrade/$id/myPnlandCreditData";
  static String marginXInstrumentWatchList(
          bool? isNifty, bool? isBankNifty, bool? isFinNifty) =>
      "$apiURL/instrumentDetails?isNifty=$isNifty&isBankNifty=$isBankNifty&isFinNifty=$isFinNifty&dailyContest=true";
  static String marginXTradingInstruments(
          bool? isNifty, bool? isBankNifty, bool? isFinNifty) =>
      "$apiURL/tradableInstruments?isNifty=$isNifty&isBankNifty=$isBankNifty&isFinNifty=$isFinNifty&dailyContest=true";
  static String completedMarginXOrders(String? id) =>
      "$apiURL/marginxtrade/$id/my/allorders";

  static String virtualperformance(String? tradeType, String? timeFrame) =>
      "$apiURL/userdashboard/stats?tradeType=$tradeType&timeframe=$timeFrame";
  static String performance(String? tradeType, String? timeFrame) =>
      "$apiURL/userdashboard/${tradeType}stats?timeframe=$timeFrame";

  static String careers(String? type) => "$apiURL/career/live?type=$type";

  static String internshipPosition(String? id) => "$apiURL/internship/pnl/$id";
  static String internshipOverview(String? id) =>
      "$apiURL/analytics/internship/myoverview/$id";
  static String internshipMonthlyPNL(String? id) =>
      "$apiURL/analytics/internship/mymonthlypnl/$id";
  static String internshipDateWisePNL(String? id) =>
      "$apiURL/analytics/internship/mystats/$id";
  static String internshipBatchPortfolio(String? id) =>
      "$apiURL/internship/marginDetail/$id";

  static String tenxCountTradingDays(String? id) =>
      "$apiURL/tenX/$id/trade/countTradingDays";
  static String shareMarginX(String? id) => "$apiURL/marginx/share/$id";
  static String tenxSubscriberCount(String? id) =>
      "$apiURL/tenX/subscribercount/$id";
  static String verifyAndParticipate(String? id) =>
      "$apiURL/dailycontest/contest/$id/varifycodeandparticipate";

  static const String pendingOrder = "$apiURL/pendingorder/my";
  static String tenxStopLossExecutedOrder(String? id) =>
      "$pendingOrder/todaysProcessed/$id/TenX%20Trader";
  static String tenxStopLossPendingOrder(String? id) =>
      "$pendingOrder/todaysPending/$id/TenX%20Trader";
  static String tenxStopLossPendingCancelOrder(String? id) =>
      "$apiURL/pendingorder/$id/TenX%20Trader";
  static String stopLossEditOrder(String? id) =>
      "$apiURL/pendingorder/editprice/$id";

  static String virtualStopLossExecutedOrder(String? id) =>
      "$pendingOrder/todaysProcessed/$id/paperTrade";
  static String virtualStopLossPendingOrder(String? id) =>
      "$pendingOrder/todaysPending/$id/paperTrade";
  static String virtualStopLossPendingCancelOrder(String? id) =>
      "$apiURL/pendingorder/$id/paperTrade";

  static String contestStopLossExecutedOrder(String? id) =>
      "$pendingOrder/todaysProcessed/$id/Daily%20Contest";
  static String contestStopLossPendingOrder(String? id) =>
      "$pendingOrder/todaysPending/$id/Daily%20Contest";
  static String contestStopLossPendingCancelOrder(String? id) =>
      "$apiURL/pendingorder/$id/Daily%20Contest";

  static String internshipStopLossExecutedOrder(String? id) =>
      "$pendingOrder/todaysProcessed/$id/Internship%20Trader";
  static String internshipStopLossPendingOrder(String? id) =>
      "$pendingOrder/todaysPending/$id/Internship%20Trader";
  static String internshipStopLossPendingCancelOrder(String? id) =>
      "$apiURL/pendingorder/$id/Internship%20Trader";

  static String marginXStopLossExecutedOrder(String? id) =>
      "$pendingOrder/todaysProcessed/$id/MarginX";
  static String marginXStopLossPendingOrder(String? id) =>
      "$pendingOrder/todaysPending/$id/MarginX";
  static String marginXStopLossPendingCancelOrder(String? id) =>
      "$apiURL/pendingorder/$id/MarginX";
  static String marginXTodayOrders(String? id) =>
      "$apiURL/marginxtrade/$id/my/todayorders";

  static String dayWiseContestPnl(String? id) =>
      "$apiURL/dailycontest/trade/$id/mydaywisepnl";
  static String contestProfile(String? id) =>
      "$apiURL/dailycontest/contestprofile/$id";
  static const String weeklyTopPerformersFullList =
      "$apiURL/dailycontest/weeklytopperformerfulllist";
  static const String weeklyTopPerformersFullListCarouseal =
      "$apiURL/toptestzoneportfolios";
  static String contestResultPage(String? id) =>
      "$apiURL/dailycontest/trade/$id/result";
}
