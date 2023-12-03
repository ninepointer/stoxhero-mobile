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
    super.initState();
    controller = Get.find<HomeController>();
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
        Get.toNamed(AppRoutes.analytics);
        Get.find<AnalyticsController>().loadData();
        break;
      case 1:
        Get.toNamed(AppRoutes.portfolio);
        Get.find<PortfolioController>().loadData();
        break;
      case 2:
        Get.toNamed(AppRoutes.orders);
        Get.find<OrdersController>().loadData();
        break;
      case 3:
        Get.toNamed(AppRoutes.careers);
        break;
      case 4:
        Get.toNamed(AppRoutes.Internship);
        Get.find<InternshipController>().loadData();
        break;
      case 5:
        ThemeService().switchTheme();
        break;
      case 6:
        AppStorage.clearStorage();
        Get.offAllNamed(AppRoutes.signin);
        // AppStorage.clearLoginDetails();
        // Get.offAllNamed(AppRoutes.signin);
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
                accountEmail: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Referral Code: ${controller.userDetailsData.myReferralCode ?? '-'}',
                      ),
                    ),
                  ],
                ),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.grey.withOpacity(.25),
                    ),
                  ),
                  child: ClipOval(
                    child: controller.userDetails.value.profilePhoto == null
                        ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image.asset(
                              Get.isDarkMode ? AppImages.darkAppLogo : AppImages.lightAppLogo,
                              width: 48,
                              height: 48,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Image.network(
                            controller.userDetails.value.profilePhoto?.url ?? '',
                          ),
                  ),
                ),
              ),
            ),
            Divider(thickness: 1, height: 0),
            Expanded(child: menuItem()),
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

  Widget menuItem() {
    return ListView(
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
                label: 'MarketGuru',
                onTap: () => selectedItem(context, 0),
              ),
              ProfileListTile(
                icon: Icons.person,
                label: 'Portfolio',
                onTap: () => selectedItem(context, 1),
              ),
              ProfileListTile(
                label: 'Order Book',
                onTap: () => selectedItem(context, 2),
              ),
              ProfileListTile(
                icon: Icons.school,
                label: 'Careers',
                onTap: () => selectedItem(context, 3),
              ),
              ProfileListTile(
                icon: Icons.school,
                label: 'Internship/Workshop',
                onTap: () => selectedItem(context, 4),
              ),
              ProfileListTile(
                icon: ThemeService().theme == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                label: ThemeService().theme == ThemeMode.dark ? 'Light Mode' : 'Dark Mode',
                onTap: () => selectedItem(context, 5),
              ),
              ProfileListTile(
                icon: Icons.logout,
                label: 'Logout',
                onTap: () => selectedItem(context, 6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
