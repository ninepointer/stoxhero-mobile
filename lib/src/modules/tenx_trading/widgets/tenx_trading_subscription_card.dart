import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';

class TenxTradingSubscriptionCard extends StatelessWidget {
  final TenxActiveSubscription subscription;

  const TenxTradingSubscriptionCard({
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
        Divider(
          thickness: 1,
          height: 0,
          color: AppColors.netural,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: subscription.features?.length,
          itemBuilder: (context, index) => TenxTradingCardTile(
            label: subscription.features?[index].description ?? '-',
          ),
        ),
        ListTile(
          visualDensity: VisualDensity.compact,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '₹${subscription.actualPrice}',
                  style: AppStyles.tsWhiteRegular16.copyWith(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: SizedBox(width: 8),
                ),
                TextSpan(
                  text: '₹${subscription.discountedPrice}',
                  style: AppStyles.tsPrimaryMedium20,
                ),
              ],
            ),
          ),
          trailing: CommonFilledButton(
            width: 100,
            height: 32,
            onPressed: () {},
            label: 'Unlock',
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
      leading: Icon(Icons.check_circle_rounded),
      title: Text(
        label,
        style: AppStyles.tsWhiteRegular14,
      ),
    );
  }
}
