import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class ReferralsLeaderboardView extends GetView<ReferralsController> {
  const ReferralsLeaderboardView({Key? key}) : super(key: key);

  num getTotalUserReferralEarning(List<Referrals> referrals) {
    num amount = 0;
    for (var item in referrals) {
      amount += item.referralEarning ?? 0;
    }
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CommonTile(label: 'Referral Leaderboard'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12),
            child: Row(
              children: [
                Expanded(
                  child: customCard(
                    context,
                    label: 'Friend\nJoined',
                    earning: controller.earnings.value.joined?.toString() ?? '0',
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: customCard(
                    context,
                    label: 'Total \n Earnings',
                    earning: "₹ ${controller.earnings.value.earnings?.toString() ?? '0'}",
                    valueColor: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 8),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: customCard(
          //     context,
          //     label: 'My Rank',
          //     earning: '00',
          //   ),
          // ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.referralsLeaderboardList.length,
            padding: EdgeInsets.zero,
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
          SizedBox(height: 16),
          CommonTile(label: 'Friends Leaderboard'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.myReferralsList.length,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var user = controller.myReferralsList[index];
              return ReferralsLeaderboardCard(
                rank: '#${index + 1}',
                name: '${user.firstName!.capitalizeFirst} ${user.lastName!.capitalizeFirst}',
                count: user.referrals != null ? (user.referrals!.length).toString() : '0',
                earnings: getTotalUserReferralEarning(user.referrals ?? []),
              );
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget customCard(
    BuildContext context, {
    required String label,
    required String earning,
    Color? valueColor,
  }) {
    return CommonCard(
      margin: EdgeInsets.zero,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.tsRegular16,
                ),
              ),
            ),
            SizedBox(width: 4),
            Text(
              earning,
              style: Theme.of(context).textTheme.tsMedium16.copyWith(
                    color: valueColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
