import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class ReferralsLeaderboardCard extends StatelessWidget {
  final String? rank;
  final String? name;
  final String? count;
  final num? earnings;

  const ReferralsLeaderboardCard({
    super.key,
    this.rank,
    this.name,
    this.count,
    this.earnings,
  });
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withOpacity(0.25),
              ),
              child: Text(
                rank ?? '#',
                style: AppStyles.tsSecondaryMedium16,
              ),
            ),
            SizedBox(width: 8),
            Text(
              name ?? '-',
              style: Theme.of(context).textTheme.tsRegular18,
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonCardTile(
              label: "Total Referral's",
              value: count ?? '-',
              valueColor: Theme.of(context).textTheme.tsRegular10.color,
            ),
            CommonCardTile(
              isRightAlign: true,
              isValueNumber: true,
              label: "Total Earning's",
              value: earnings,
              valueColor: AppColors.success,
            ),
          ],
        )
      ],
    );
  }
}
