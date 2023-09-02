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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
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
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.grey.withOpacity(.25),
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
                                          controller.earnings.value.joined?.toString() ?? '0',
                                          style: Theme.of(context).textTheme.tsMedium16,
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
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.grey.withOpacity(.25),
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
                                          controller.earnings.value.earnings?.toString() ?? '0',
                                          style: Theme.of(context).textTheme.tsMedium16,
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
}
