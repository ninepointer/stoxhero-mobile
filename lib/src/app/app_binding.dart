import 'package:get/get.dart';

import '../data/data.dart';
import '../modules/modules.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkService(), permanent: true);
    Get.put(AuthRepository(), permanent: true);
    Get.put(ProfileRepository(), permanent: true);
    Get.put(PortfolioRepository(), permanent: true);
    Get.put(ReferralsRepository(), permanent: true);
    Get.put(TenxRepository(), permanent: true);
    Get.put(OrdersRepository(), permanent: true);
    Get.put(WalletRepository(), permanent: true);
    Get.put(AnalyticsRepository(), permanent: true);

    Get.put(AuthController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(PortfolioController(), permanent: true);
    Get.put(ReferralsController(), permanent: true);
    Get.put(OrdersController(), permanent: true);
    Get.put(WalletController(), permanent: true);
    Get.put(AnalyticsController(), permanent: true);
  }
}
