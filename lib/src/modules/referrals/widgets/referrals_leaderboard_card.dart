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
      margin: EdgeInsets.all(
        MediaQuery.of(context).size.width * 0.0306,
      ).copyWith(bottom: 0, top: MediaQuery.of(context).size.width * 0.0204),
      children: [
        Row(
          children: [
            Container(
              height: 36,
              width: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withOpacity(0.25),
              ),
              child: Text(
                rank ?? '#',
                style: AppStyles.tsSecondaryMedium16,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.0408,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name ?? '-',
                          style: Theme.of(context).textTheme.tsRegular16,
                        ),
                      ),
                      Text(
                        FormatHelper.formatNumbers(earnings),
                        style: Theme.of(context).textTheme.tsMedium16.copyWith(
                              color: AppColors.success,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Total Referrals",
                          style: Theme.of(context).textTheme.tsGreyRegular12,
                        ),
                      ),
                      Text(
                        count ?? '-',
                        style: Theme.of(context).textTheme.tsRegular12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
