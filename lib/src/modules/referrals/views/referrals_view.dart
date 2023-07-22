import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class ReferralsView extends GetView<ReferralsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referrals'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "StoxHero Referral Program\n${controller.activeReferrals.value?.referralProgramName ?? ''}",
                      textAlign: TextAlign.center,
                      style: AppStyles.tsSecondaryRegular20,
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //   child: Center(
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(16),
                  //       child: Image.asset(
                  //         'assets/images/referrals.png',
                  //         width: 250,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.netural.shade400,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(14),
                        width: double.infinity,
                        child: Column(
                          children: [
                            if (controller.activeReferrals.value != null)
                              Text(
                                'Get ${controller.activeReferrals.value?.currency ?? ''} ${controller.activeReferrals.value?.rewardPerReferral ?? ''} for every referral in\nyour StoxHero wallet',
                                style: AppStyles.tsPrimaryRegular14,
                                textAlign: TextAlign.center,
                              ),
                            if (controller.activeReferrals.value != null) SizedBox(height: 8),
                            ReferralDetailsCardTile(
                              label: 'Invite Your Friends',
                              iconData: Icons.share,
                            ),
                            ReferralDetailsCardTile(
                              label: 'Your friend gets 10 Lakhs Virtual Currency for Paper Trading (Virtual Trading).',
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
                              color: AppColors.netural,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
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
                                          style: AppStyles.tsWhiteRegular20.copyWith(
                                            fontSize: 24,
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          visualDensity: VisualDensity.compact,
                                          splashRadius: 24,
                                          padding: EdgeInsets.zero,
                                          onPressed: () {},
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
                                          onPressed: () {},
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.zero,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: AppColors.netural.shade400,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(14),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.netural,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.groups_rounded,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Friends Joined',
                                            style: AppStyles.tsGreyRegular12,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            '00',
                                            style: AppStyles.tsWhiteMedium16,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.zero,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: AppColors.netural.shade400,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(14),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.netural,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.currency_rupee_rounded,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total Earnings',
                                            style: AppStyles.tsGreyRegular12,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            '00',
                                            style: AppStyles.tsWhiteMedium16,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.netural.shade400,
                        ),
                        borderRadius: BorderRadius.circular(4),
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
                                      style: AppStyles.tsWhiteMedium18,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.qr_code_2_rounded,
                                  size: 50,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    tileColor: AppColors.netural.shade600,
                    title: Text(
                      'Friends Leaderboard',
                      style: AppStyles.tsPrimaryRegular18,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ReferralsLeaderboardCard();
                    },
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    tileColor: AppColors.netural.shade600,
                    title: Text(
                      'Referral Leaderboard',
                      style: AppStyles.tsPrimaryRegular18,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.referralsLeaderboardList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var user = controller.referralsLeaderboardList[index];
                      return ReferralsLeaderboardCard(
                        rank: '#${index + 1}',
                        name: '${user.firstName!.capitalizeFirst} ${user.lastName!.capitalizeFirst}',
                        count: user.referralCount,
                        earnings: user.earnings,
                      );
                    },
                  ),
                  SizedBox(height: 36),
                ],
              ),
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
        style: AppStyles.tsWhiteRegular16,
      ),
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.netural,
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
