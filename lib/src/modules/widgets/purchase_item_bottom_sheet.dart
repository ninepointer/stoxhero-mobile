import 'package:flutter/material.dart';
import '../../app/app.dart';

class PurchaseItemBottomSheet extends StatelessWidget {
  final num walletBalance;
  final int buyItemPrice;
  final VoidCallback onSubmit;

  PurchaseItemBottomSheet({
    required this.walletBalance,
    required this.buyItemPrice,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Column(
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
                'Choose how to pay',
                style: AppStyles.tsSecondarySemiBold20,
              ),
              SizedBox(height: 16),
              Text(
                'Your payment is encrypted and you can change your payment method at anytime.',
                textAlign: TextAlign.center,
                style: AppStyles.tsGreyRegular14,
              ),
              SizedBox(height: 36),
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
                          walletBalance,
                          decimal: 0,
                        ),
                        style: Theme.of(context).textTheme.tsMedium20,
                      ),
                    ],
                  ),
                ],
              ),
              if (buyItemPrice <= walletBalance)
                Column(
                  children: [
                    SizedBox(height: 24),
                    CommonFilledButton(
                      label: 'Proceed',
                      onPressed: onSubmit,
                    ),
                  ],
                ),
              if (buyItemPrice >= walletBalance)
                Column(
                  children: [
                    SizedBox(height: 24),
                    Text(
                      'Your wallet balance is low kindly refer more users on this platform to buy this subscription.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.tsRegular14,
                    ),
                    SizedBox(height: 24),
                    ReferralCodeCard(),
                  ],
                ),
              SizedBox(height: 56),
            ],
          ),
        ),
      ],
    );
  }
}
