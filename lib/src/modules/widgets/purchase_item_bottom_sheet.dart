import 'package:flutter/material.dart';
import '../../app/app.dart';

class PurchaseItemBottomSheet extends StatefulWidget {
  final num buyItemPrice;
  final VoidCallback onSubmit;

  PurchaseItemBottomSheet({
    required this.buyItemPrice,
    required this.onSubmit,
  });

  @override
  State<PurchaseItemBottomSheet> createState() => _PurchaseItemBottomSheetState();
}

class _PurchaseItemBottomSheetState extends State<PurchaseItemBottomSheet> {
  num? walletBalance;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    calculateUserWalletAmount();
  }

  void calculateUserWalletAmount() async {
    isLoading = true;
    setState(() {});
    num amount = 0;
    var response = await Get.find<WalletRepository>().getWalletTransactionsList();
    var list = response.data?.data?.transactions ?? [];
    for (var e in list) amount += e.amount ?? 0;
    walletBalance = amount;
    isLoading = false;
    setState(() {});
  }

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
          child: Visibility(
            visible: !isLoading,
            replacement: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: CommonLoader(),
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
                // CommonCard(
                //   onTap: () async {
                //     var data = await Get.toNamed(AppRoutes.payment);
                //     print(data);
                //   },
                //   margin: EdgeInsets.only(top: 16),
                //   padding: EdgeInsets.all(16),
                //   children: [
                //     Text('Pay using Bank Account/UPI'),
                //   ],
                // ),
                if (walletBalance == null || widget.buyItemPrice <= walletBalance!)
                  Column(
                    children: [
                      SizedBox(height: 24),
                      CommonFilledButton(
                        height: 42,
                        label: 'Proceed',
                        onPressed: widget.onSubmit,
                      ),
                    ],
                  ),
                if (walletBalance != null && widget.buyItemPrice >= walletBalance!)
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
        ),
      ],
    );
  }
}
