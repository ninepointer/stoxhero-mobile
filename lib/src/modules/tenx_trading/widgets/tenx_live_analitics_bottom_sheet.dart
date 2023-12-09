import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenXLiveAnaliticalBottomSheet extends GetView<TenxTradingController> {
  final TenxSubscribedPlan subscription;

  final List<TenxSubscribedPlanPnl> pnlData;

  TenXLiveAnaliticalBottomSheet({
    Key? key,
    required this.subscription,
    required this.pnlData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CommonCard(
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
                        padding: EdgeInsets.only(left: 4),
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
                                '${FormatHelper.formatNumbers(controller.tenxSubscribedPlansPNLData[0].grossPnl, decimal: 0)}',
                                style: AppStyles.tsSecondaryMedium14.copyWith(
                                  color: controller
                                              .tenxSubscribedPlansPNLData[0]
                                              .grossPnl! >=
                                          0
                                      ? AppColors.success
                                      : AppColors.danger,
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
                                'Brokerage:',
                                style: AppStyles.tsSecondaryMedium12,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${FormatHelper.formatNumbers(controller.tenxSubscribedPlansPNLData[0].brokerage, decimal: 0)}',
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
                        padding: EdgeInsets.only(left: 4),
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
                                '${FormatHelper.formatNumbers(subscription.discountedPrice, decimal: 0)}',
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
                                '${FormatHelper.formatNumbers(controller.tenxSubscribedPlansPNLData[0].npnl, decimal: 0)}',
                                style: AppStyles.tsSecondaryMedium14.copyWith(
                                  color: controller
                                              .tenxSubscribedPlansPNLData[0]
                                              .npnl! >=
                                          0
                                      ? AppColors.success
                                      : AppColors.danger,
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
                        padding: EdgeInsets.only(left: 4),
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
                                '${controller.tenxSubscribedPlansPNLData[0].tradingDays}',
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
                                '${controller.tenxSubscribedPlansPNLData[0].trades}',
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
        ));
  }
}
