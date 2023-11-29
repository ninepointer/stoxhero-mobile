import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenxExpiredCard extends GetView<TenxTradingController> {
  final TenxExpiredPlan subscription;

  const TenxExpiredCard({
    super.key,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        TenxTradingCardHeader(
          label: subscription.planName ?? '-',
          color: subscription.planName == "Beginner"
              ? AppColors.info
              : subscription.planName == "Intermediate"
                  ? AppColors.success
                  : subscription.planName == "Pro"
                      ? AppColors.danger
                      : AppColors.primary,
        ),
        Divider(thickness: 1, height: 0),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: subscription.features?.length,
          itemBuilder: (context, index) => TenxTradingCardTile(
            label: subscription.features?[index].description ?? '-',
          ),
        ),
        SizedBox(height: 12),
        Column(
          children: [
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
                            '₹${subscription.fee}',
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
                            '₹${subscription.npnl?.toStringAsFixed(2)}',
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
              height: 4,
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
                            '₹${subscription.tds}',
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
                            '${subscription.payout}',
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
            SizedBox(height: 4),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Subscribed On :\n${FormatHelper.formatDateTimeToIST(subscription.subscribedOn)}',
                      style: AppStyles.tsSecondaryMedium12,
                    ),
                  ),
                  SizedBox(height: 2),
                  Expanded(
                    child: Text(
                      'Expired On :\n${FormatHelper.formatDateTimeToIST(subscription.expiredOn)}',
                      textAlign: TextAlign.end,
                      style: AppStyles.tsWhiteMedium12.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: CommonFilledButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  labelColor: AppColors.secondary,
                  backgroundColor: AppColors.secondary.withOpacity(.25),
                  height: 32,
                  label: 'Analytics',
                  onPressed: () => SnackbarHelper.showSnackbar('Coming Soon'),
                ),
              ),
              Expanded(
                child: CommonFilledButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  labelColor: AppColors.info,
                  backgroundColor: AppColors.info.withOpacity(.25),
                  height: 32,
                  onPressed: () {
                    Get.find<OrdersController>().loadData();
                    Get.toNamed(AppRoutes.orders);
                  },
                  label: 'Order Book',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
