import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/profile/widgets/profile_list_tile.dart';

import '../../modules/modules.dart';
import '../core.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  late HomeController controller;
  @override
  void initState() {
    controller = Get.find<HomeController>();
    super.initState();
  }

  String getUserFullName() {
    String firstName = controller.userDetailsData.firstName ?? '';
    String lastName = controller.userDetailsData.lastName ?? '';
    String fullName = '$firstName $lastName';
    return fullName.capitalize!;
  }

  void selectedItem(BuildContext context, int index) {
    Get.back();
    switch (index) {
      case 0:
        // Get.toNamed();
        break;
      case 1:
        Get.toNamed(AppRoutes.portfolio);
        Get.find<PortfolioController>().loadData();
        break;
      case 2:
        Get.toNamed(AppRoutes.referrals);
        Get.find<ReferralsController>().loadData();
        break;
      case 3:
        Get.toNamed(AppRoutes.careers);
        break;
      case 4:
        Get.toNamed(AppRoutes.faq);
        break;
      case 5:
        Get.toNamed(AppRoutes.tutorial);
        Get.find<TutorialController>().loadData();
        break;
      case 6:
        ThemeService().switchTheme();
        break;
      case 7:
        AppStorage.clearLoginDetails();
        Get.offAllNamed(AppRoutes.signin);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Obx(
              () => UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                accountName: Text(
                  getUserFullName(),
                  style: Theme.of(context).textTheme.tsMedium16,
                ),
                accountEmail: Text(
                  'Referral Code: ${controller.userDetailsData.myReferralCode ?? '-'}',
                ),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.grey.withOpacity(.25),
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(AppImages.appLogo),
                  ),
                ),
              ),
            ),
            Divider(thickness: 1, height: 0),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ProfileListTile(
                          icon: Icons.analytics,
                          label: 'Analytics',
                          onTap: () => selectedItem(context, 0),
                        ),
                        ProfileListTile(
                          icon: Icons.person,
                          label: 'Portfolio',
                          onTap: () => selectedItem(context, 1),
                        ),
                        ProfileListTile(
                          icon: Icons.diversity_3_rounded,
                          label: 'Referrals',
                          onTap: () => selectedItem(context, 2),
                        ),
                        ProfileListTile(
                          icon: Icons.school,
                          label: 'Careers',
                          onTap: () => selectedItem(context, 3),
                        ),
                        ProfileListTile(
                          icon: Icons.help,
                          label: 'FAQs',
                          onTap: () => selectedItem(context, 4),
                        ),
                        ProfileListTile(
                          icon: Icons.smart_display_rounded,
                          label: 'Tutorials',
                          onTap: () => selectedItem(context, 5),
                        ),
                        ProfileListTile(
                          icon: Icons.dark_mode,
                          label: 'Dark Mode',
                          onTap: () => selectedItem(context, 6),
                        ),
                        ProfileListTile(
                          icon: Icons.logout,
                          label: 'Logout',
                          onTap: () => selectedItem(context, 7),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                '© 2023,\n made with ❤️ by StoxHero \n for a better trading experience.',
                textAlign: TextAlign.center,
                style: AppStyles.tsGreyRegular12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
