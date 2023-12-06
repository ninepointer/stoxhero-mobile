import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenxSubscribedCard extends GetView<TenxTradingController> {
  final TenxSubscribedPlan subscription;
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
        SizedBox(height: 12),
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
                            'Subscription Price',
                            style: AppStyles.tsSecondaryMedium14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '₹${subscription.discountedPrice}',
                            style: AppStyles.tsSecondaryMedium14.copyWith(
                              color: AppColors.success,
                            ),
                          ),
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
                      'Expires On :\n${controller.getFormattedExpiryDate(subscription.subscribedOn, subscription.expiryDays)}',
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
          child: Column(
            children: [
              Row(
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
                      onPressed: () =>
                          SnackbarHelper.showSnackbar('Coming Soon'),
                    ),
                  ),
                  if (subscription.allowRenewal == true) ...[
                    Expanded(
                      child: CommonFilledButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        labelColor: AppColors.danger,
                        backgroundColor: AppColors.danger.withOpacity(.25),
                        height: 32,
                        label: 'Renew',
                        onPressed: () {
                          controller.selectedSubscriptionId(subscription.sId);
                          controller.tenxSubscribedPlanSelected(subscription);
                          print(subscription.toJson());
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: PaymentBottomSheet(
                              productType: ProductType.tenx,
                              productId: subscription.sId ?? '',
                              buyItemPrice: subscription.discountedPrice ?? 0,
                              onPaymentSuccess:
                                  controller.loadDataAfterPaymentSuccess,
                              onSubmit: () {
                                Get.back();
                                var walletController =
                                    Get.find<WalletController>();
                                var data = {
                                  "bonusRedemption": walletController
                                          .isHeroCashAdded.value
                                      ? walletController.heroCashAmount.value
                                      : 0,
                                  "coupon": walletController
                                      .couponCodeTextController.text,
                                  "subscriptionAmount":
                                      walletController.subscriptionAmount.value,
                                  "subscriptionName": subscription.planName,
                                  "subscriptionId": subscription.sId,
                                };
                                controller.tenxRenewSubscription(data);
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ]
                ],
              ),
              CommonFilledButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                labelColor: AppColors.success,
                backgroundColor: AppColors.success.withOpacity(.25),
                height: 32,
                onPressed: () {
                  controller.selectedSubscriptionId(subscription.sId);
                  controller.tenxSubscribedPlanSelected(subscription);
                  controller.loadTenxData();
                  controller.selectSubscriptionName("");
                  controller
                      .selectSubscriptionName(subscription.planName ?? '');
                  controller.tenxExpiredPlanSelected();
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
