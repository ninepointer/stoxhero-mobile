import 'package:flutter/material.dart';

import '../../../core/core.dart';

class WalletTransactionCard extends StatelessWidget {
  final String? label;
  final String? dateTime;
  final String? subtitle;
  final dynamic amount;

  const WalletTransactionCard({
    Key? key,
    required this.label,
    required this.dateTime,
    required this.subtitle,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.netural.shade400,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.currency_rupee_rounded,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label ?? '-',
                    style: AppStyles.tsWhiteMedium16,
                  ),
                  SizedBox(height: 4),
                  Text(
                    dateTime ?? '-',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle ?? '-',
                    style: AppStyles.tsSecondaryRegular14,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Text(
              FormatHelper.formatNumbers(amount),
              style: AppStyles.tsPrimaryMedium20.copyWith(
                color: amount > 0 ? AppColors.success : AppColors.danger,
              ),
            )
          ],
        )
      ],
    );
  }
}
