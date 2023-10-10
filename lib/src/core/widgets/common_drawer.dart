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
        Get.toNamed(AppRoutes.analytics);
        Get.find<AnalyticsController>().loadData();
        break;
      case 1:
        Get.toNamed(AppRoutes.portfolio);
        Get.find<PortfolioController>().loadData();
        break;
      case 2:
        Get.find<OrdersController>().loadData();
        Get.toNamed(AppRoutes.orders);
        break;
      case 3:
        Get.toNamed(AppRoutes.Internship);
        Get.find<InternshipController>().loadUserData();

        break;
      case 4:
        ThemeService().switchTheme();
        break;
      case 5:
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
                    // IconButton(
                    //   onPressed: () {
                    //     // Add your logout logic here
                    //   },
                    //   icon: Icon(Icons.logout),
                    //   color: Theme.of(context).primaryColor,
                    // ),
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
                    child: Image.asset(AppImages.appLogo),
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
                label: 'Analytics',
                onTap: () => selectedItem(context, 0),
              ),
              ProfileListTile(
                icon: Icons.person,
                label: 'Portfolio',
                onTap: () => selectedItem(context, 1),
              ),
              ProfileListTile(
                label: 'Orders',
                onTap: () => selectedItem(context, 2),
              ),
              ProfileListTile(
                label: 'Internship/Training',
                onTap: () => selectedItem(context, 3),
              ),
              ProfileListTile(
                icon: Icons.dark_mode,
                label: 'Dark Mode',
                onTap: () => selectedItem(context, 4),
              ),
              ProfileListTile(
                icon: Icons.logout,
                label: 'Logout',
                onTap: () => selectedItem(context, 5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
