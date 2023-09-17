import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16).copyWith(
          bottom: 156,
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(AppImages.appLogo),
              ),
            ),
            SizedBox(height: 12),
            Text(
              controller.getUserFullName(),
              style: Theme.of(context).textTheme.tsMedium18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: Text(
                    'Referral Code : ${controller.userDetailsData.myReferralCode ?? '-'}',
                    style: AppStyles.tsPrimaryRegular14,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String referralCode = controller.userDetailsData.myReferralCode ?? '-';
                    Clipboard.setData(ClipboardData(text: referralCode));
                    SnackbarHelper.showSnackbar('Referral code copied to clipboard');
                  },
                  icon: Icon(Icons.copy),
                  iconSize: 16,
                ),
              ],
            ),
            SizedBox(height: 16),
            ProfileListTile(
              icon: Icons.person,
              label: 'My Profile',
              onTap: () {
                controller.loadData();
                Get.toNamed(AppRoutes.profileDetails);
              },
            ),
            ProfileListTile(
              icon: Icons.account_balance,
              label: 'Bank Details',
              onTap: () => Get.toNamed(AppRoutes.bankDetails),
            ),
            ProfileListTile(
              icon: Icons.account_balance,
              label: 'KYC Details',
              onTap: () => Get.toNamed(AppRoutes.kycDetails),
            ),
            ProfileListTile(
              icon: Icons.school,
              label: 'Careers',
              onTap: () => Get.toNamed(AppRoutes.careers),
            ),
            ProfileListTile(
              icon: Icons.wallet_giftcard_rounded,
              label: 'Referrals',
              onTap: () {
                Get.toNamed(AppRoutes.referrals);
                Get.find<ReferralsController>().loadData();
              },
            ),
            ProfileListTile(
              icon: Icons.help,
              label: 'FAQ\'s',
              onTap: () => Get.toNamed(AppRoutes.faq),
            ),
            ProfileListTile(
              icon: Icons.cast_for_education,
              label: 'Tutorials',
              onTap: () {
                Get.toNamed(AppRoutes.tutorial);
                Get.find<TutorialController>().loadData();
              },
            ),
            ProfileListTile(
              label: 'Messages',
              icon: Icons.message,
              onTap: () {},
            ),
            ProfileListTile(
              label: 'Settings',
              icon: Icons.settings,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
