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
    this.onPressed,
  });

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
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
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
                    label,
                    style: Theme.of(context).textTheme.tsRegular12,
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
