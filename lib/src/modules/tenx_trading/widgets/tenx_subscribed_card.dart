import 'package:flutter/material.dart';
import 'package:stoxhero/src/data/models/response/tenx_my_active_subscribed_list_response.dart';
import '../../../app/app.dart';

class TenxSubscribedCard extends GetView<TenxTradingController> {
  final TenxMyActiveSubscribedList subscription;
  final bool isActive;

  const TenxSubscribedCard({
    super.key,
    required this.subscription,
    required this.isActive,
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
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12, left: 12),
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
                            '₹${subscription.discountedPrice}',
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
          child: Column(
            children: [
              Row(
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
                      label: 'Renew',
                      onPressed: () {
                        controller.selectedSubscriptionId(subscription.sId);
                        controller.tenxMyActiveSubcribed(subscription);
                        BottomSheetHelper.openBottomSheet(
                          context: context,
                          child: PurchaseItemBottomSheet(
                            buyItemPrice: controller.selectedSubscription.value.discountedPrice ?? 0,
                            onSubmit: () => controller.tenxRenewSubscription(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              CommonOutlinedButton(
                height: 40,
                onPressed: () {
                  controller.selectedSubscriptionId(subscription.sId);
                  controller.tenxMyActiveSubcribed(subscription);
                  controller.loadTenxData();
                  Get.toNamed(AppRoutes.tenxDashboard);
                },
                label: 'Start Trading',
              ),
            ],
          ),
        ),
      ],
    );
  }
}