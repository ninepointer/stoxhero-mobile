import 'package:flutter/material.dart';

import '../../../core/core.dart';

class WithdrawalTransactionCard extends StatelessWidget {
  final String? label;
  final String? dateTime;
  final String? walletTransactionId;
  final String? transferTransactionId;
  final dynamic amount;
  final String? mode;

  const WithdrawalTransactionCard({
    Key? key,
    required this.label,
    required this.dateTime,
    required this.walletTransactionId,
    required this.amount,
    required this.mode,
    required this.transferTransactionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.all(16).copyWith(
        top: 8,
        bottom: 0,
      ),
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.currency_rupee_rounded,
                size: 20,
                color: AppColors.secondary,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label ?? '-',
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                  SizedBox(height: 2),
                  Text(
                    dateTime ?? '-',
                    style: AppStyles.tsGreyRegular12,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Text(
              FormatHelper.formatNumbers(amount),
              style: AppStyles.tsPrimaryMedium16.copyWith(
                color: AppColors.success,
              ),
            )
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transferred via',
                  style: AppStyles.tsGreyRegular12,
                ),
                Text(
                  '${mode ?? '-'}',
                  style: Theme.of(context).textTheme.tsMedium12,
                ),
              ],
            ),
            SizedBox(height: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Transfer Transaction ID',
                  style: AppStyles.tsGreyRegular12,
                ),
                Text(
                  '${transferTransactionId ?? '-'}',
                  style: Theme.of(context).textTheme.tsMedium12,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 2),
        Text(
          'Wallet Transaction ID',
          style: AppStyles.tsGreyRegular12,
        ),
        Text(
          '${walletTransactionId ?? '-'}',
          style: Theme.of(context).textTheme.tsMedium12,
        ),
      ],
    );
  }
}
