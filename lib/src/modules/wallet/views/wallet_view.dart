import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class WalletView extends GetView<WalletController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: !controller.isLoadingStatus,
        replacement: CommonLoader(),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                WalletCard(
                  label: 'Deposite',
                  value: '₹ 500',
                  iconData: Icons.account_balance_wallet_rounded,
                  buttonLabel: 'Add Money',
                  onPressed: () {},
                ),
                WalletCard(
                  label: 'Cash',
                  value: '₹ 250',
                  iconData: Icons.payments_rounded,
                  buttonLabel: 'Withdraw',
                  onPressed: () {},
                ),
                WalletCard(
                  label: 'Bouns',
                  value: '₹ 3,500',
                  iconData: Icons.redeem_rounded,
                  buttonLabel: 'Redeem',
                  onPressed: () {},
                ),
                SizedBox(height: 16),
                if (controller.walletTransactionsList.isNotEmpty)
                  ListTile(
                    tileColor: AppColors.netural.shade600,
                    title: Text(
                      'Recent Transactions',
                      style: AppStyles.tsPrimaryRegular18,
                    ),
                  ),
                if (controller.walletTransactionsList.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.walletTransactionsList.length,
                    itemBuilder: (context, index) {
                      var trans = controller.walletTransactionsList[index];
                      return WalletTransactionCard(
                        label: trans.title,
                        subtitle: trans.description,
                        dateTime: FormatHelper.formatDate(trans.transactionDate),
                        amount: FormatHelper.formatNumbers(trans.amount),
                      );
                    },
                  ),
                SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
