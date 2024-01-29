import '../../app/app.dart';

class DeepLinkingServices {
  static void handelLinkRouting(Uri uri) {
    final homeController = Get.find<HomeController>();
    if (uri.path.contains('/market')) {
      homeController.selectedIndex(1);
    }
    if (uri.path.contains('/tenxtrading')) {
      homeController.selectedIndex(2);
      Get.find<TenxTradingController>().loadData();
    }
    if (uri.path.contains('/marginxs')) {
      homeController.selectedIndex(3);
      Get.find<MarginXController>().loadData();
    }
    if (uri.path.contains('/testzone')) {
      homeController.selectedIndex(4);
    }

    if (uri.path.contains('/collegetestzone')) {
      Get.toNamed(AppRoutes.collegeContest);
      Get.find<CollegeContestController>().loadData();
    }
    if (uri.path.contains('/portfolio')) {
      Get.toNamed(AppRoutes.portfolio);
      Get.find<PortfolioController>().loadData();
    }
    if (uri.path.contains('/internship')) {
      Get.toNamed(AppRoutes.internship);
      Get.find<InternshipController>().loadData();
    }
    if (uri.path.contains('/marketguru')) {
      Get.toNamed(AppRoutes.analytics);
      Get.find<AnalyticsController>().loadData();
    }
    if (uri.path.contains('/tutorials')) {
      Get.toNamed(AppRoutes.tutorial);
      Get.find<TutorialController>().loadData();
    }

    if (uri.path.contains('/profile')) {
      Get.toNamed(AppRoutes.profile);
      Get.find<ProfileController>().loadData();
    }
    if (uri.path.contains('/wallet')) {
      Get.toNamed(AppRoutes.wallet);
      Get.find<WalletController>().loadData();
    }
    if (uri.path.contains('/referrals')) {
      Get.toNamed(AppRoutes.referrals);
      Get.find<ReferralsController>().loadData();
    }
    if (uri.path.contains('/faqs')) {
      Get.toNamed(AppRoutes.faq);
    }
  }
}
