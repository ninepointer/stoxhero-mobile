import 'package:flutter/material.dart';

import '../../core/core.dart';

class BuySellExitButtons extends StatelessWidget {
  final bool isWatchlistCard;
  final bool isAdded;

  const BuySellExitButtons({
    super.key,
    this.isWatchlistCard = true,
    this.isAdded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(.25),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Text(
                'BUY',
                style: AppStyles.tsWhiteMedium14.copyWith(
                  color: AppColors.success,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.danger.withOpacity(.25),
              ),
              child: Text(
                'SELL',
                style: AppStyles.tsWhiteMedium14.copyWith(
                  color: AppColors.danger,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isWatchlistCard
                    ? isAdded
                        ? AppColors.info.withOpacity(.25)
                        : AppColors.secondary.withOpacity(.25)
                    : AppColors.secondary.withOpacity(.25),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                isWatchlistCard
                    ? isAdded
                        ? 'REMOVE'
                        : 'ADD'
                    : 'EXIT',
                style: AppStyles.tsWhiteMedium14.copyWith(
                  color: isWatchlistCard ? AppColors.info : AppColors.secondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
