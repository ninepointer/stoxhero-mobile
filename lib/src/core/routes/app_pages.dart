import 'package:get/route_manager.dart';

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
      name: AppRoutes.portfolio,
      page: () => PortfolioView(),
      binding: PortfolioBinding(),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
  ];
}
