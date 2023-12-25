import 'package:flutter/material.dart';

import '../../../app/app.dart';

class MyAffilateReferralDetailCard extends StatelessWidget {
  final int? rank;
  final MyAffiliateRefferal? affiliateReferral;

  const MyAffilateReferralDetailCard({
    super.key,
    this.rank,
    this.affiliateReferral,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(top: 8),
      children: [
        Row(
          children: [
            Text("$rank"),
            SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${affiliateReferral?.name ?? ""}',
                    style: Theme.of(context).textTheme.tsRegular14,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Joining Date : ${FormatHelper.formatDateInMonth(affiliateReferral?.joiningDate)}',
                    style: Theme.of(context).textTheme.tsGreyRegular10,
                  ),
                ],
              ),
            ),
            Text(
              FormatHelper.formatNumbers(affiliateReferral?.payout ?? 0),
              style: Theme.of(context).textTheme.tsMedium16.copyWith(
                    color: AppColors.success,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
