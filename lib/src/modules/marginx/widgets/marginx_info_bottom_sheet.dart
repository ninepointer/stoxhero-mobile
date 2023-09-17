import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stoxhero/src/core/core.dart';

class MarginxInfoBottomSheet extends StatelessWidget {
  const MarginxInfoBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Introducing MarginX: Your Gateway to Realistic Trading',
                style: Theme.of(context).textTheme.tsMedium16,
              ),
            ),
            Divider(
              thickness: 1,
              height: 16,
            ),
            Text(
              "We've designed this innovative trading experience to bridge the gap between learning and real-world trading, allowing you to get as close to the market as possible.",
              style: Theme.of(context).textTheme.tsRegular14,
            ),
            SizedBox(height: 8),
            Text(
              "What is MarginX?",
              style: Theme.of(context).textTheme.tsMedium16,
            ),
            SizedBox(height: 8),
            Text(
              "In MarginX, you won't just learn about trading; you'll experience it. MarginX is designed to bridge the gap between learning and real-world trading, allowing you to get as close to the market as possible & also continue to make real profit using virtual currency. Your success in MarginX depends on your ability to make informed decisions, manage risk, and seize opportunities - just like in the real trading world.",
              style: Theme.of(context).textTheme.tsRegular14,
            ),
            SizedBox(height: 8),
            Text(
              "Here's how it works:",
              style: Theme.of(context).textTheme.tsMedium16,
            ),
            SizedBox(height: 8),
            Text(
              "Profit on Your Investment: Just like real options trading, you'll make a profit on the amount you've invested. Let's say you've invested Rs. 100. If you grow your trading capital by 10%, your real profit will also be 10% of your invested amount, which is Rs. 10. So your final amount will be Rs. 100 (your invested amount) + Rs. 10 (profit earned), making the total Rs. 110.",
              style: Theme.of(context).textTheme.tsRegular14,
            ),
            SizedBox(height: 8),
            Text(
              "Safety Net: If you end up with the same capital, your entire invested amount is safe",
              style: Theme.of(context).textTheme.tsMedium16,
            ),
            SizedBox(height: 8),
            Text(
              "Proportional Loss: If your capital reduces by 10%, your real loss will also be in the same proportion, i.e., Rs. 10. So your final amount will be Rs. 100 (your invested amount) - Rs. 10 (loss made), making the total Rs. 90",
              style: Theme.of(context).textTheme.tsRegular14,
            ),
            SizedBox(height: 8),
            Text(
              "When will I receive my profit in my wallet?",
              style: Theme.of(context).textTheme.tsMedium16,
            ),
            SizedBox(height: 8),
            Text(
              "You recieve the payout in your wallet as soon as the market closes for that day i.e after 3:30 PM",
              style: Theme.of(context).textTheme.tsRegular14,
            ),
            SizedBox(height: 12),
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
          ],
        ),
      ),
    );
  }
}
