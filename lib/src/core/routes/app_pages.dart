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
      binding: SigninBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => OtpView(),
      binding: OtpBinding(),
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
  ];
}
