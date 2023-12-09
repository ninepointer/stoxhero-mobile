import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../data/models/response/tenx_subscription_pnl_response.dart';

class TenXLiveAnaliticalBottomSheet extends GetView<TenxTradingController> {
  final TenxSubscribedPlan subscription;
//  final List<TenxSubscribedPlanPnl> pnlData;


  TenXLiveAnaliticalBottomSheet({
    Key? key,
    required this.subscription,
    // required this.pnlData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('rrrr${pnlData[0].grossPnl}');
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
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
                          SizedBox(width: 4),
                          Text(
                            '',
                            // style: AppStyles.tsSecondaryMedium14.copyWith(
                            //   color: subscription.gpnl! >= 0
                            //       ? AppColors.success
                            //       : AppColors.danger,
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12),
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
                            '${controller.tenxSubscribedPlansPNLData}',
                            style: AppStyles.tsSecondaryMedium14.copyWith(
                              color: AppColors.success,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
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
                            'Price:',
                            style: AppStyles.tsSecondaryMedium12,
                          ),
                          // Text(subscription),
                          SizedBox(width: 4),
                          Text(
                            '${FormatHelper.formatNumbers(subscription.fee)}',
                            style: AppStyles.tsSecondaryMedium14.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12),
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
                            'Net P&L:',
                            style: AppStyles.tsSecondaryMedium12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '',
                            // ' ${FormatHelper.formatNumbers(subscription.npnl)}',
                            // '₹${subscription.fee}',
                            // style: AppStyles.tsSecondaryMedium14.copyWith(
                            //   color: subscription.npnl! >= 0
                            //       ? AppColors.success
                            //       : AppColors.danger,
                            // ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
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
                            'TDS:',
                            style: AppStyles.tsSecondaryMedium12,
                          ),
                          // Text(subscription),
                          SizedBox(width: 4),
                          Text(
                            '',
                            // '${FormatHelper.formatNumbers(subscription.tds ?? 0)}',
                            style: AppStyles.tsSecondaryMedium14.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12),
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
                            'Net Payout:',
                            style: AppStyles.tsSecondaryMedium12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '',
                            // '${FormatHelper.formatNumbers(subscription.payout)}',
                            // '₹${subscription.fee}',
                            style: AppStyles.tsSecondaryMedium14.copyWith(
                              color: AppColors.success,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
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
                          SizedBox(width: 4),
                          Text(
                            '',
                            // '${subscription.tradingDays}',
                            style: AppStyles.tsSecondaryMedium14.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12),
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
                            '',
                            // '${subscription.trades}',
                            style: AppStyles.tsSecondaryMedium14.copyWith(
                              color: AppColors.success,
                            ),
                          )
                        ],
                      ),
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
