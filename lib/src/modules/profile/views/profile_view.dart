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
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Card(
              //   elevation: 0,
              //   margin: EdgeInsets.symmetric(vertical: 16),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: ListTile(
              //     leading: Container(
              //       height: 50,
              //       width: 50,
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(100),
              //         child: Image.asset(AppImages.appLogo),
              //       ),
              //     ),
              //     title: Text(
              //       controller.getUserFullName(),
              //       style: Theme.of(context).textTheme.tsMedium20,
              //     ),
              //     subtitle: Text(
              //       'Referral Code : ${controller.userDetailsData.myReferralCode ?? '-'}',
              //       style: AppStyles.tsPrimaryRegular14,
              //     ),
              //   ),
              // ),
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

                      final snackBar = SnackBar(
                        content: Text('Referral code copied to clipboard'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                onTap: () {
                  Get.toNamed(AppRoutes.bankDetails);
                },
              ),
              ProfileListTile(
                icon: Icons.account_balance,
                label: 'KYC Details',
                onTap: () {
                  Get.toNamed(AppRoutes.kycDetails);
                },
              ),
              ProfileListTile(
                label: 'Orders',
                onTap: () {
                  Get.toNamed(AppRoutes.orders);
                  Get.find<OrdersController>().loadData();
                },
              ),
              ProfileListTile(
                label: 'Portfolio',
                onTap: () {
                  Get.toNamed(AppRoutes.portfolio);
                  Get.find<PortfolioController>().loadData();
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
            ],
          ),
        ),
      ),
    );
  }
}
