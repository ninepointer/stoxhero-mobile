import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenXLiveAnaliticalBottomSheet extends GetView<TenxTradingController> {
  final TenxSubscribedPlan subscription;

  final TenxSubscribedPlanPnl pnlData;

  TenXLiveAnaliticalBottomSheet({
    Key? key,
    required this.subscription,
    required this.pnlData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CommonCard(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          hasBorder: false,
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
                      '${subscription.planName != null ? subscription.planName : ''}',
                      style: Get.isDarkMode
                          ? AppStyles.tsWhiteMedium14
                          : AppStyles.tsBlackMedium14,
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
                                '${controller.tenxSubscribedPlansPNLData.value.grossPnl != null ? FormatHelper.formatNumbers(controller.tenxSubscribedPlansPNLData.value.grossPnl, decimal: 0) : 0}',
                                style: AppStyles.tsSecondaryMedium14.copyWith(
                                    color: controller.tenxSubscribedPlansPNLData
                                                .value.grossPnl !=
                                            null
                                        ? controller.tenxSubscribedPlansPNLData
                                                    .value.grossPnl! >=
                                                0
                                            ? AppColors.success
                                            : AppColors.danger
                                        : AppColors.success),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
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
                                '${controller.tenxSubscribedPlansPNLData.value.brokerage != null ? FormatHelper.formatNumbers(controller.tenxSubscribedPlansPNLData.value.brokerage, decimal: 0) : 0}',
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
                                '${subscription.discountedPrice != null ? FormatHelper.formatNumbers(subscription.discountedPrice, decimal: 0) : 0}',
                                style: AppStyles.tsSecondaryMedium14.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
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
                                '${controller.tenxSubscribedPlansPNLData.value.npnl != null ? FormatHelper.formatNumbers(controller.tenxSubscribedPlansPNLData.value.npnl, decimal: 0) : 0}',
                                style: AppStyles.tsSecondaryMedium14.copyWith(
                                  color: controller.tenxSubscribedPlansPNLData
                                              .value.npnl !=
                                          null
                                      ? controller.tenxSubscribedPlansPNLData
                                                  .value.npnl! >=
                                              0
                                          ? AppColors.success
                                          : AppColors.danger
                                      : AppColors.success,
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
                                '${controller.tenxSubscribedPlansPNLData.value.tradingDays != null ? controller.tenxSubscribedPlansPNLData.value.tradingDays : 0}',
                                style: AppStyles.tsSecondaryMedium14.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
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
                                '${controller.tenxSubscribedPlansPNLData.value.trades != null ? controller.tenxSubscribedPlansPNLData.value.trades : 0}',
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
