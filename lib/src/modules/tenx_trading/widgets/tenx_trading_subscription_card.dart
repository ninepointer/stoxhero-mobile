import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class TenxTradingSubscriptionCard extends GetView<TenxTradingController> {
  final TenxActiveSubscription subscription;
  final bool isActive;

  const TenxTradingSubscriptionCard({
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
        Divider(
          thickness: 1,
          height: 0,
        ),
        ListTile(
          visualDensity: VisualDensity.compact,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Row(
            children: [
              Text(
                '₹${subscription.actualPrice}',
                style: Theme.of(context).textTheme.tsRegular18.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
              ),
              SizedBox(width: 16),
              Text(
                '₹${subscription.discountedPrice}',
                style: AppStyles.tsSecondarySemiBold20,
              ),
            ],
          ),
          trailing: CommonFilledButton(
            width: 150,
            height: 32,
            onPressed: isActive
                ? () {
                    controller.selectedSubscriptionId(subscription.sId);
                    controller.selectedSubscription(subscription);
                    controller.loadData();
                    Get.toNamed(AppRoutes.tenxDashboard);
                  }
                : () {
                    controller.selectedSubscriptionId(subscription.sId);
                    controller.selectedSubscription(subscription);
                    controller.purchaseIntent();
                    controller.calculateUserWalletAmount();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => TenxBuySubscriptionBottomSheet(),
                    );
                  },
            label: isActive ? 'Start Trading' : 'Unlock',
          ),
        ),
      ],
    );
  }
}

class TenxTradingCardHeader extends StatelessWidget {
  final String label;
  final Color color;

  const TenxTradingCardHeader({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: color.withOpacity(0.1),
      ),
      child: Text(
        label,
        style: AppStyles.tsSecondaryMedium16.copyWith(
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TenxTradingCardTile extends StatelessWidget {
  final String label;

  const TenxTradingCardTile({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 0,
      visualDensity: VisualDensity.compact,
      leading: Icon(
        Icons.check_circle_rounded,
        size: 16,
        color: AppColors.grey.withOpacity(.5),
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.tsRegular14,
      ),
    );
  }
}
