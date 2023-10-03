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
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.all(16.0),
        child: Visibility(
          visible: true,
          replacement: CommonLoader(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Withdraw from wallet to bank account',
                style: Theme.of(context).textTheme.tsMedium18,
              ),
              Divider(
                thickness: 1,
                height: 36,
              ),
              Text(
                "KYC required for withdrawals. Daily limit: ₹200 to ₹1000",
                style: Theme.of(context).textTheme.tsRegular16,
              ),
              SizedBox(height: 16),
              CommonCard(
                margin: EdgeInsets.zero,
                children: [
                  Row(
                    children: [
                      Text(
                        'StoxHero Wallet',
                        style: Theme.of(context).textTheme.tsRegular16,
                      ),
                      Spacer(),
                      Text(
                        FormatHelper.formatNumbers(
                          controller.totalCashAmount.value,
                          decimal: 0,
                        ),
                        style: Theme.of(context).textTheme.tsMedium20,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              CommonTextField(
                hintText: 'Amount',
                controller: controller.amountTextController,
                prefixIcon: Icon(Icons.money),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: controller.onCancel,
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.tsRegular16,
                    ),
                  ),
                  SizedBox(width: 8),
                  CommonFilledButton(
                    height: 42,
                    width: 120,
                    label: 'Confirm',
                    onPressed: controller.onConfirm,
                  ),
                ],
              ),
              SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
