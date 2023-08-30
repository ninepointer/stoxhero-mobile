import 'package:get/route_manager.dart';
import 'package:stoxhero/src/modules/faq/faq_index.dart';
import 'package:stoxhero/src/modules/tutorial/tutorial_index.dart';

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
      binding: BankBinding(),
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
      // binding: TutorialBinding(),
    ),
  ];
}
