import 'package:get/get.dart';

import '../modules/modules.dart';
import 'app.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkService(), permanent: true);
    Get.put(AuthRepository(), permanent: true);
    Get.put(ProfileRepository(), permanent: true);
    Get.put(PortfolioRepository(), permanent: true);
    Get.put(ReferralsRepository(), permanent: true);
    Get.put(TenxTradingRepository(), permanent: true);
    Get.put(OrdersRepository(), permanent: true);
    Get.put(WalletRepository(), permanent: true);
    Get.put(AnalyticsRepository(), permanent: true);
    Get.put(ContestRepository(), permanent: true);
    Get.put(DashboardRepository(), permanent: true);
    Get.put(MarginXRepository(), permanent: true);
    Get.put(CareerRepository(), permanent: true);
    Get.put(VirtualTradingRepository(), permanent: true);
    Get.put(TutorialRepository(), permanent: true);

    Get.put(AppController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(TenxTradingController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(BankController(), permanent: true);

    Get.put(PortfolioController(), permanent: true);
    Get.put(ReferralsController(), permanent: true);
    Get.put(OrdersController(), permanent: true);
    Get.put(WalletController(), permanent: true);
    Get.put(AnalyticsController(), permanent: true);
    Get.put(ContestController(), permanent: true);
    Get.put(TutorialController(), permanent: true);
    Get.put(CareerController(), permanent: true);
    Get.put(MarginXController(), permanent: true);
    Get.put(VirtualTradingController(), permanent: true);
    Get.put(CollegeContestController(), permanent: true);
  }
}
