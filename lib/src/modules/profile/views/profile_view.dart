import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';
import 'package:stoxhero/src/modules/profile/widgets/profile_list_tile.dart';

import '../../../core/core.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.logout),
            onPressed: () {
              AppStorage.clearStorage();
              Get.offAllNamed(AppRoutes.signin);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(AppImages.appLogo),
                  ),
                ),
                title: Text(
                  controller.getUserFullName(),
                  style: AppStyles.tsWhiteMedium20,
                ),
                subtitle: Text(
                  'Referral Code : ${controller.userDetailsData.myReferralCode ?? '-'}',
                  style: AppStyles.tsPrimaryRegular14,
                ),
              ),
            ),
            ProfileListTile(
              label: 'My Profile',
              onTap: () {
                controller.loadData();
                Get.toNamed(AppRoutes.profileDetails);
              },
            ),
            ProfileListTile(
              label: 'Orders',
              onTap: () {
                Get.find<OrdersController>().loadData();
                Get.toNamed(AppRoutes.orders);
              },
            ),
            ProfileListTile(
              label: 'Portfolio',
              onTap: () {
                Get.find<PortfolioController>().loadData();
                Get.toNamed(AppRoutes.portfolio);
              },
            ),
            ProfileListTile(
              label: 'Message',
              onTap: () {},
            ),
            ProfileListTile(
              label: 'Settings',
              onTap: () {},
            ),
            ProfileListTile(
              label: 'FAQs',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
