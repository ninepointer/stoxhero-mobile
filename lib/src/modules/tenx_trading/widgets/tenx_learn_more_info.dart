import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenxLearnMoreInfo extends GetView<TenxTradingController> {
  const TenxLearnMoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget headline(String text) {
      return Text(
        text,
        style: Theme.of(context).textTheme.tsMedium14,
      );
    }

    Widget subtitle(String text) {
      return Text(
        text,
        style: Theme.of(context).textTheme.tsRegular12,
        textAlign: TextAlign.center,
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Text(
                '${controller.selectSubscriptionName} Subscription Details',
                style: Theme.of(context).textTheme.tsMedium14,
              ),
            ),
            Divider(
              height: 8,
              thickness: 1,
            ),
            headline("💰 Virtual Margin Money Boost"),
            SizedBox(height: 2),
            subtitle(
                "This subscription plan provides you with a margin of ₹${controller.selectSubscriptionAmount}/-, to enhance your F&O Intraday Options trading. This boost empowers you to take advantage of more trading opportunities."),
            SizedBox(height: 8),
            headline('⌛ Duration Flexibility'),
            SizedBox(height: 2),
            subtitle(
                'The subscription is designed to cater to your needs. It covers either ${controller.selectedSubscription.value.validity} trading days or a total of ${controller.selectedSubscription.value.expiryDays} calendar days, whichever comes first. This flexibility allows you to align the plan with your trading preferences and schedule.'),
            SizedBox(height: 8),
            headline('🏆 Profit Rewards'),
            SizedBox(height: 2),
            subtitle(
                'At the end of the subscription period, which spans ${controller.selectedSubscription.value.validity} trading days, you become eligible for ${controller.selectedSubscription.value.payoutPercentage}% of the net profit if your trading results are in the positive. This means that your successful trades are rewarded, adding to your earnings.'),
            SizedBox(height: 8),
            headline('👉 Profit Cap'),
            SizedBox(height: 2),
            subtitle(
                "To ensure fairness and stability, the subscription plan includes a profit cap of ₹${controller.selectedSubscription.value.profitCap}/-. This cap represents the maximum amount you can earn as a part of the plan, even if your trading results exceed expectations. It's a safeguard that maintains a balanced and secure trading environment."),
            SizedBox(height: 8),
            headline('🕗 Automatic Expiry'),
            SizedBox(height: 2),
            subtitle(
                "If, for any reason, you are unable to complete the full ${controller.selectedSubscription.value.validity} trading days within the specified ${controller.selectedSubscription.value.expiryDays} calendar days, the subscription will automatically expire without processing any payouts."),
            SizedBox(height: 8),
            headline("💸 Seamless Payouts"),
            SizedBox(height: 2),
            subtitle(
                "Your hard-earned profits are important to us. At the end of the ${controller.selectedSubscription.value.validity} trading days, your payout is swiftly credited to your wallet. This hassle-free process ensures that you can enjoy the fruits of your trading success without delay."),
            SizedBox(height: 8),
            headline("❎ Daily Square-Off"),
            SizedBox(height: 2),
            subtitle(
                "For your convenience and risk management, all trades within the subscription plan are automatically squared off at 3:20 PM every trading day. This ensures that you have a clean slate for the next trading session and helps you maintain control over your portfolio."),
            SizedBox(height: 8),
            Text(
              "With our subscription plan, we aim to enhance your trading journey by providing flexibility, rewards, and a seamless experience. Start your subscription today and maximize your trading potential! 🚀",
              style: Theme.of(context).textTheme.tsMedium14,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Got it',
                    style: Theme.of(context).textTheme.tsRegular16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
