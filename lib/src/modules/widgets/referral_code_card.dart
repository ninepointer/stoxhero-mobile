import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stoxhero/src/app/app.dart';

class ReferralCodeCard extends GetView<ReferralsController> {
  const ReferralCodeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.zero,
      children: [
        Row(
          children: [
            Text(
              controller.userDetailsData.myReferralCode ?? '-',
              style: Theme.of(context).textTheme.tsMedium18.copyWith(
                    fontSize: 24,
                  ),
            ),
            Spacer(),
            IconButton(
              constraints: const BoxConstraints(minWidth: 20, maxWidth: 20),
              visualDensity: VisualDensity.compact,
              splashRadius: 24,
              padding: EdgeInsets.zero,
              onPressed: () {
                Clipboard.setData(
                    ClipboardData(text: controller.getReferralMessage()));
                SnackbarHelper.showSnackbar(
                    'Referral code copied to clipboard');
              },
              icon: Icon(
                Icons.copy,
                size: 20,
                color: AppColors.secondary,
              ),
            ),
            SizedBox(width: 24),
            IconButton(
              constraints: const BoxConstraints(minWidth: 20, maxWidth: 20),
              visualDensity: VisualDensity.compact,
              splashRadius: 24,
              padding: EdgeInsets.zero,
              onPressed: () => Share.share(controller.getReferralMessage()),
              icon: Icon(
                Icons.share,
                size: 20,
                color: AppColors.secondary,
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ],
    );
  }
}
