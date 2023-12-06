import 'package:flutter/material.dart';
import '../../../app/app.dart';
import 'tenx_Analitical_Bottom_sheet.dart';
import 'expired_tenx_share_sheet.dart';

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
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return TenXAnaliticalBottomSheet(
                              subscription: subscription);
                        });
                  },
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
              Expanded(
                child: CommonFilledButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  labelColor: AppColors.secondary,
                  backgroundColor: AppColors.secondary.withOpacity(.25),
                  height: 32,
                  label: 'Share',
                  onPressed: () async {
                    controller.tenxExpiredPlans();
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: ShareTenXModalContent(
                            subscription: subscription,
                          ),
                        );
                      },
                    );
                    // }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
