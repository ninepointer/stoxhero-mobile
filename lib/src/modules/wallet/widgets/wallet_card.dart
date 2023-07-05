import 'package:flutter/material.dart';

import '../../../core/core.dart';

class WalletCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;
  final String buttonLabel;
  final Function()? onPressed;

  const WalletCard({
    super.key,
    required this.label,
    required this.value,
    required this.iconData,
    required this.buttonLabel,
    required this.onPressed,
  });

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
                iconData,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppStyles.tsWhiteRegular12,
                  ),
                  SizedBox(height: 2),
                  Text(
                    value,
                    style: AppStyles.tsPrimaryMedium20.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            CommonFilledButton(
              height: 32,
              width: 120,
              label: buttonLabel,
              onPressed: onPressed,
            )
          ],
        )
      ],
    );
  }
}
