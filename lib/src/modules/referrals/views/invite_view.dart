import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class InviteView extends GetView<ReferralsController> {
  const InviteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100),
        child: Container(
          child: Column(
            children: [
              Image.asset(
                AppImages.referral,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "StoxHero Referral Program\n${controller.activeReferrals.value?.referralProgramName ?? ''}",
                  textAlign: TextAlign.center,
                  style: AppStyles.tsSecondaryRegular20,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.grey.withOpacity(.25),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(14),
                    width: double.infinity,
                    child: Column(
                      children: [
                        if (controller.activeReferrals.value != null)
                          Text(
                            'Get ${FormatHelper.formatNumbers(controller.activeReferrals.value?.rewardPerReferral, decimal: 0)} for every referral in\nyour StoxHero wallet',
                            style: TextStyle(
                                color: Colors.lightGreen,
                                fontFamily: "Rubik",
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        if (controller.activeReferrals.value != null)
                          SizedBox(height: 8),
                        ReferralDetailsCardTile(
                          label: 'Invite Your Friends using your referral code',
                          iconData: Icons.share,
                        ),
                        ReferralDetailsCardTile(
                          label:
                              'Your friend gets 10 Lakhs Virtual Currency for Virtual F&O Paper Trading.',
                          iconData: Icons.share,
                        ),
                        ReferralDetailsCardTile(
                          label:
                              'Your friend gets ${FormatHelper.formatNumbers(controller.activeReferrals.value?.referralSignupBonus?.amount, decimal: 0)} in his StoxHero Wallet to participate in daily TestZones or TenX',
                          iconData: Icons.share,
                        ),
                        ReferralDetailsCardTile(
                          label:
                              'You get ${FormatHelper.formatNumbers(controller.activeReferrals.value?.rewardPerReferral, decimal: 0)} for each referral in your StoxHero Wallet.',
                          iconData: Icons.share,
                        ),
                        SizedBox(height: 16),
                        ReferralCodeCard(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.grey.withOpacity(.25),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(14),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'My Referral Code',
                                  style: AppStyles.tsGreyRegular12,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  controller.userDetailsData.myReferralCode ??
                                      '-',
                                  style: Theme.of(context).textTheme.tsMedium18,
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Icons.qr_code_2_rounded,
                              size: 36,
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.grey.withOpacity(.25),
                            ),
                          ),
                          child: QrImageView(
                            data:
                                '${AppUrls.referralWebUrl}${controller.userDetailsData.myReferralCode}',
                            version: QrVersions.auto,
                            eyeStyle: QrEyeStyle(
                              color: AppColors.lightGreen,
                            ),
                            size: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReferralDetailsCardTile extends StatelessWidget {
  final String label;
  final IconData iconData;

  const ReferralDetailsCardTile({
    super.key,
    required this.label,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: Theme.of(context).textTheme.tsRegular16,
      ),
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.lightGreen.withOpacity(.1),
          shape: BoxShape.circle,
        ),
        child: Icon(iconData,
            size: 20,
            color: Get.isDarkMode ? AppColors.lightGreen : AppColors.darkGreen),
      ),
    );
  }
}
