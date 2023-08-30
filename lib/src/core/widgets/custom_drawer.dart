import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/profile/widgets/profile_list_tile.dart';

import '../../modules/modules.dart';
import '../core.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(
              () => UserAccountsDrawerHeader(
                accountName: Text(
                  getUserFullName(),
                  style: AppStyles.tsWhiteMedium16,
                ),
                accountEmail: Text(
                  'Referral Code: ${controller.userDetailsData.myReferralCode ?? '-'}',
                ),
                currentAccountPicture: ClipOval(
                  child: Image.asset(AppImages.appLogo),
                ),
              ),
            ),
            menuItem(),
            SizedBox(height: 8),
            Text(
              '© 2023,\n made with ❤️ by StoxHero \n for a better trading experience.',
              textAlign: TextAlign.center,
              style: AppStyles.tsGreyMedium16,
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
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
            icon: Icons.widgets,
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
            icon: Icons.cast_for_education,
            label: 'Tutorials',
            onTap: () => selectedItem(context, 5),
          ),
          ProfileListTile(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () => selectedItem(context, 6),
          ),
        ],
      ),
    );
  }
}
