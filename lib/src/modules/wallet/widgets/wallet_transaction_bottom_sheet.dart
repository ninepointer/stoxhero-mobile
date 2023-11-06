import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withOpacity(0.25),
                ),
                child: Icon(
                  Icons.lock,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Withdraw from\nwallet to bank account',
                style: AppStyles.tsSecondarySemiBold20,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                "KYC required for withdrawals.\nDaily limit: ₹200 to ₹1000",
                style: Theme.of(context).textTheme.tsRegular16,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              CommonCard(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(12),
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
                        style: Theme.of(context).textTheme.tsMedium20.copyWith(
                              color: AppColors.success,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              CommonTextField(
                controller: controller.amountTextController,
                hintText: 'Enter amount',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: CommonOutlinedButton(
                      height: 42,
                      onPressed: controller.onCancel,
                      label: 'Cancel',
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CommonFilledButton(
                      height: 42,
                      width: 120,
                      label: 'Proceed',
                      onPressed: controller.onConfirm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
