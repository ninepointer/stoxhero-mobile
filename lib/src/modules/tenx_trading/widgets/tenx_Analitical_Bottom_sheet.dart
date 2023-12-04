import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenXAnaliticalBottomSheet extends GetView<TenxTradingController> {
  final TenxExpiredPlan subscription;
  const TenXAnaliticalBottomSheet({
    Key? key,
    required this.subscription,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      children: [
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${subscription.planName}',
                  style: AppStyles.tsBlackMedium14,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Gross P&L:',
                          style: AppStyles.tsSecondaryMedium12,
                        ),
                        // Text(subscription),
                        SizedBox(width: 4),
                        Text(
                          '${FormatHelper.formatNumbers(subscription.gpnl, decimal: 2)}',
                          style: AppStyles.tsSecondaryMedium14.copyWith(
                            color: subscription.gpnl! >= 0
                                ? AppColors.success
                                : AppColors.danger,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Brokerage:',
                          style: AppStyles.tsSecondaryMedium12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${FormatHelper.formatNumbers(subscription.brokerage, decimal: 2)}',
                          // '₹${subscription.fee}',
                          style: AppStyles.tsSecondaryMedium14.copyWith(
                            color: AppColors.success,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Trading Days:',
                          style: AppStyles.tsSecondaryMedium12,
                        ),
                        // Text(subscription),
                        SizedBox(width: 4),
                        Text(
                          '${subscription.tradingDays}',
                          style: AppStyles.tsSecondaryMedium14.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Trades:',
                          style: AppStyles.tsSecondaryMedium12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${subscription.trades}',
                          style: AppStyles.tsSecondaryMedium14.copyWith(
                            color: AppColors.success,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
