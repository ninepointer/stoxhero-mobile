import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class ReferralsAffilateTransactionCard extends StatelessWidget {
  final String? name;
  final String? transactionId;
  final String? productName;
  final num? earnings;
  final String? date;
  const ReferralsAffilateTransactionCard({
    super.key,
    this.name,
    this.transactionId,
    this.productName,
    this.earnings,
    this.date,
  });
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.all(16).copyWith(bottom: 0, top: 8),
      children: [
        Row(
          children: [
            Container(
              height: 36,
              width: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grey.withOpacity(.4),
              ),
              child: Icon(
                Icons.currency_rupee_rounded,
                color: AppColors.lightGreen,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Commission for ${name ?? '-'}'s $productName\npurchase ",
                          style: Theme.of(context).textTheme.tsRegular12,
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
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "$transactionId",
                          style: Theme.of(context).textTheme.tsGreyRegular10,
                        ),
                      ),
                      Text(
                        // '${FormatHelper.formatDateTimeOnlyToIST(date)}',
                        '${FormatHelper.formatDateByMonthWithTime(date)}',
                        style: Theme.of(context).textTheme.tsRegular10,
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
