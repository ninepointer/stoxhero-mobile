import 'package:get/route_manager.dart';
import 'package:stoxhero/src/modules/contest/views/contest_search_symbol_view.dart';
import 'package:stoxhero/src/modules/stocks/views/stocks_dashboard_view.dart';

import '../../modules/modules.dart';
import 'routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onBoarding,
      page: () => OnBoardingView(),
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => SigninView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => OtpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.profileDetails,
      page: () => ProfileDetailsView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.bankDetails,
      page: () => BankDetailsView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.kycDetails,
      page: () => KycDetailsView(),
      // binding: BankBinding(),
    ),
    GetPage(
      name: AppRoutes.portfolio,
      page: () => PortfolioView(),
      binding: PortfolioBinding(),
    ),
    GetPage(
      name: AppRoutes.analytics,
      page: () => AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: AppRoutes.referrals,
      page: () => ReferralsView(),
      binding: ReferralsBinding(),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutes.tenxDashboard,
      page: () => TenxDashboardView(),
      binding: TenxTradingBinding(),
    ),
    GetPage(
      name: AppRoutes.tenxSearchSymbol,
      page: () => TenxSearchSymbolView(),
      binding: TenxTradingBinding(),
    ),
    GetPage(
      name: AppRoutes.contest,
      page: () => ContestView(),
      binding: ContestBinding(),
    ),
    GetPage(
      name: AppRoutes.contestSearchSymbol,
      page: () => ContestSearchSymbolView(),
      binding: ContestBinding(),
    ),
    GetPage(
      name: AppRoutes.contestLiveLeaderboard,
      page: () => ContestLiveLeaderboardView(),
      binding: ContestBinding(),
    ),
    GetPage(
      name: AppRoutes.pastContest,
      page: () => PastContestView(),
      binding: ContestBinding(),
    ),
    GetPage(
      name: AppRoutes.faq,
      page: () => FaqView(),
    ),
    GetPage(
      name: AppRoutes.tutorial,
      page: () => TutorialView(),
      binding: TutorialBinding(),
    ),
    GetPage(
      name: AppRoutes.careers,
      page: () => CareerView(),
      binding: CareerBinding(),
    ),
    GetPage(
      name: AppRoutes.wallet,
      page: () => WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: AppRoutes.marginx,
      page: () => MarginXView(),
      binding: MarginXBinding(),
    ),
    GetPage(
      name: AppRoutes.marginXSearchSymbol,
      page: () => MarginXSearchSymbolView(),
      binding: MarginXBinding(),
    ),
    GetPage(
      name: AppRoutes.collegeContest,
      page: () => CollegeContestView(),
      binding: CollegeContestBinding(),
    ),
    GetPage(
      name: AppRoutes.collegeContestSearchSymbol,
      page: () => CollegeContestSearchSymbolView(),
      binding: CollegeContestBinding(),
    ),
    GetPage(
      name: AppRoutes.collegeContestLiveLeaderboard,
      page: () => CollegeContestLiveLeaderboardView(),
      binding: CollegeContestBinding(),
    ),
    GetPage(
      name: AppRoutes.virtualTrading,
      page: () => VirtualTradingView(),
      binding: VirtualTradingBinding(),
    ),
    GetPage(
      name: AppRoutes.virtualSearchSymbol,
      page: () => VirtualSearchSymbolView(),
      binding: VirtualTradingBinding(),
    ),
    GetPage(
      name: AppRoutes.Internship,
      page: () => InternshipDashboardView(),
      binding: InternshipBinding(),
    ),
    GetPage(
      name: AppRoutes.internshipSearchSymbol,
      page: () => InternshipSearchSymbolView(),
      binding: InternshipBinding(),
    ),
    GetPage(
      name: AppRoutes.contestProfile,
      page: () => ContestProfileView(),
      // binding: InternshipBinding(),
    ),
    GetPage(
      name: AppRoutes.weeklyTopPerformersFullList,
      page: () => ContestTopPerformerCard(),
      binding: ContestProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.stocks,
      page: () => StocksDashboardView(),
      binding: ContestProfileBinding(),
      
    ),
    GetPage(
      name: AppRoutes.affiliate,
      page: () => AffiliateView(),
      binding: AffiliateBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.stocks,
    //   page: () => StocksDashboardView(),
    //    binding: ContestProfileBinding(),

    // ),
  ];
}
