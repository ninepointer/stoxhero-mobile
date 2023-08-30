import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class WalletTransactionBottomSheet extends GetView<WalletController> {
  const WalletTransactionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Withdraw from wallet to bank account',
              style: AppStyles.tsWhiteRegular18,
            ),
            Divider(
              thickness: 1,
              height: 36,
              color: AppColors.netural.shade50.withOpacity(0.5),
            ),
            Text(
              "KYC required for withdrawals. Daily limit: ₹200 to ₹1000",
              style: AppStyles.tsWhiteRegular16,
            ),
            SizedBox(height: 16),
            Text(
              "Your wallet balance: ${FormatHelper.formatNumbers(controller.totalCashAmount.value)}",
            ),
            SizedBox(height: 16),
            CommonTextField(
              hintText: 'Amount',
              prefixIcon: Icon(Icons.money),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: controller.onCancel,
                  child: Text(
                    'Cancel',
                    style: AppStyles.tsWhiteRegular14,
                  ),
                ),
                SizedBox(width: 8),
                CommonFilledButton(
                  height: 40,
                  width: 120,
                  label: 'Confirm',
                  onPressed: controller.onConfirm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showBottomModalSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => WalletTransactionBottomSheet(),
  );
}
