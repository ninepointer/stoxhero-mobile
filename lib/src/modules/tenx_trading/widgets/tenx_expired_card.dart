import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../data/models/response/tenx_my_expired_subscription_list_response.dart';

class TenxExpiredCard extends GetView<TenxTradingController> {
  final TenxMyExpiredSubscriptionList subscription;

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
        SizedBox(height: 8),
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
                            'Subscription',
                            style: AppStyles.tsSecondaryMedium12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '₹${subscription.fee}',
                            style: AppStyles.tsSecondaryMedium14,
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
                            'Net Payout',
                            style: AppStyles.tsSecondaryMedium12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '₹0',
                            // '₹${subscription.fee}',
                            style: AppStyles.tsSecondaryMedium14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(12).copyWith(bottom: 8, top: 8),
          child: Row(
            children: [
              Expanded(
                child: CommonOutlinedButton(
                  height: 40,
                  label: 'Analytics',
                  onPressed: () => SnackbarHelper.showSnackbar('Coming Soon'),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: CommonOutlinedButton(
                  height: 40,
                  onPressed: () {
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
