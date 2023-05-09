import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../profile_index.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  Widget _buildProfileTile(String label, {Function()? onTap}) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minLeadingWidth: 0,
        leading: Icon(
          Icons.circle,
          size: 36,
          color: AppColors.netural.shade400,
        ),
        title: Text(
          label,
          style: AppStyles.tsWhiteRegular16,
        ),
        trailing: Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.loadUserDetails();
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
                  'Referal Code : ${controller.userDetailsData.myReferralCode ?? '-'}',
                  style: AppStyles.tsPrimaryRegular14,
                ),
              ),
            ),
            _buildProfileTile(
              'My Profile',
              onTap: () {
                controller.loadProfileDetails();
                Get.toNamed(AppRoutes.profileDetails);
              },
            ),
            _buildProfileTile(
              'Orders',
              onTap: () {},
            ),
            _buildProfileTile(
              'Portfolio',
              onTap: () {},
            ),
            _buildProfileTile(
              'Message',
              onTap: () {},
            ),
            _buildProfileTile(
              'Settings',
              onTap: () {},
            ),
            _buildProfileTile(
              'FAQs',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
