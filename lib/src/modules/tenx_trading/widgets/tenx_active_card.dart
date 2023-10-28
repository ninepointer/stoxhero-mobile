import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/app.dart';

class TenxActiveCard extends GetView<TenxTradingController> {
  final TenxActiveSubscription subscription;
  final bool isActive;

  const TenxActiveCard({
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
        if (subscription.features?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: subscription.features?.length,
              itemBuilder: (context, index) => TenxTradingCardTile(
                label: subscription.features?[index].description ?? '-',
              ),
            ),
          ),
        SizedBox(height: 8),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '₹${subscription.actualPrice}',
                              style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationStyle: TextDecorationStyle.solid,
                                    color: AppColors.danger,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.circle,
                                size: 8,
                              ),
                            ),
                            Text(
                              'Save',
                              style: AppStyles.tsSecondaryMedium14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${controller.calculateSavingsPercentage(subscription.actualPrice, subscription.discountedPrice).toStringAsFixed(0)}%',
                              style: AppStyles.tsSecondaryMedium14,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.circle,
                                size: 8,
                              ),
                            ),
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
                ),
              ],
            ),
            SizedBox(height: 8),
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
                            'Potential Earnings',
                            style: AppStyles.tsSecondaryMedium14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '₹${subscription.profitCap}',
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
                      labelColor: AppColors.info,
                      backgroundColor: AppColors.info.withOpacity(.25),
                      height: 32,
                      label: 'Learn More',
                      onPressed: () {
                        controller.tenxCountTradingDays();
                        controller.selectSubscriptionName("");
                        controller.selectSubscriptionName(subscription.planName ?? '');
                        controller.selectedSubscription(subscription);
                        controller.selectSubscriptionAmount(subscription.portfolio?.portfolioValue?.toInt());
                        BottomSheetHelper.openBottomSheet(
                          context: context,
                          child: TenxLearnMoreInfo(),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: CommonFilledButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      labelColor: AppColors.danger,
                      backgroundColor: AppColors.danger.withOpacity(.25),
                      height: 32,
                      label: 'Watch Videos',
                      onPressed: () async {
                        controller.selectedSubscriptionId(subscription.sId);
                        controller.tenxTutorial();
                        final Uri url = Uri.parse(AppUrls.tenxYoutubeVideoLink);
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                    ),
                  ),
                ],
              ),
              if (subscription.allowPurchase == true) ...[
                CommonFilledButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  labelColor: AppColors.success,
                  backgroundColor: AppColors.success.withOpacity(.25),
                  height: 32,
                  onPressed: isActive
                      ? () {}
                      : () {
                          controller.selectedSubscriptionId(subscription.sId);
                          controller.selectedSubscription(subscription);
                          controller.purchaseIntent();
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: PurchaseItemBottomSheet(
                              buyItemPrice: controller.selectedSubscription.value.discountedPrice ?? 0,
                              onSubmit: () => controller.purchaseSubscription(),
                            ),
                          );
                        },
                  label: isActive ? 'Already Subscribed' : 'Subscribe',
                )
              ]
            ],
          ),
        ),
      ],
    );
  }
}
