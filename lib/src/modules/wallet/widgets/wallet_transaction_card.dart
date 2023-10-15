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
                  SizedBox(height: 4),
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
                color: amount > 0 ? AppColors.success : AppColors.danger,
              ),
            )
          ],
        ),
        SizedBox(height: 8),
        Text(
          subtitle ?? '-',
          style: AppStyles.tsGreyRegular12,
        ),
      ],
    );
  }
}
