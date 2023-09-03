import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class InviteView extends GetView<ReferralsController> {
  const InviteView({Key? key}) : super(key: key);
  String getReferralMessage() {
    return "AB INDIA SIKHEGA OPTIONS TRADING AUR BANEGA ATMANIRBHAR Join me at StoxHero - Options Trading and Investment Platform 🤝 👉 Get 10,00,000 virtual currency in your account to start option trading using my referral code 👉 Join the community of ace traders and learn real-time options trading 👉 Participate in TenX Trading and earn 10% real cash on the profit you will make on the platform 📲 Visit https://www.stoxhero.com/signup?referral=${controller.userDetailsData.myReferralCode} Use my below invitation code 👇 and get INR ₹10,00,000 in your wallet and start trading My Referral Code to join the StoxHero: ${controller.userDetailsData.myReferralCode}";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: !controller.isLoadingStatus,
        replacement: CommonLoader(),
        child: SingleChildScrollView(
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
                              'Get ${controller.activeReferrals.value?.currency ?? ''} ${controller.activeReferrals.value?.rewardPerReferral ?? ''} for every referral in\nyour StoxHero wallet',
                              style: AppStyles.tsPrimaryRegular16,
                              textAlign: TextAlign.center,
                            ),
                          if (controller.activeReferrals.value != null) SizedBox(height: 8),
                          ReferralDetailsCardTile(
                            label: 'Invite Your Friends',
                            iconData: Icons.share,
                          ),
                          ReferralDetailsCardTile(
                            label:
                                'Your friend gets 10 Lakhs Virtual Currency for Paper Trading (Virtual Trading).',
                            iconData: Icons.share,
                          ),
                          ReferralDetailsCardTile(
                            label:
                                'Your friend gets two portfolios worth 10 Lakhs each to participate in daily free contests.',
                            iconData: Icons.share,
                          ),
                          ReferralDetailsCardTile(
                            label: 'You get INR 15 for each referral',
                            iconData: Icons.share,
                          ),
                          SizedBox(height: 16),
                          Card(
                            elevation: 0,
                            color: AppColors.grey.withOpacity(.25),
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(14),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        controller.userDetailsData.myReferralCode ?? '-',
                                        style: Theme.of(context).textTheme.tsRegular20.copyWith(
                                              fontSize: 24,
                                            ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        splashRadius: 24,
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Clipboard.setData(
                                              ClipboardData(text: getReferralMessage()));
                                        },
                                        icon: Icon(
                                          Icons.copy,
                                          size: 20,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        splashRadius: 24,
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Share.share(getReferralMessage());
                                        },
                                        icon: Icon(
                                          Icons.share,
                                          size: 20,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
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
                                    style: AppStyles.tsGreyRegular14,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    controller.userDetailsData.myReferralCode ?? '-',
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
                          QrImageView(
                            data:
                                'https://www.stoxhero.com/signup?referral=${controller.userDetailsData.myReferralCode}',
                            version: QrVersions.auto,
                            foregroundColor: AppColors.primary,
                            size: 200,
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
          color: AppColors.grey.withOpacity(.25),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          size: 20,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
