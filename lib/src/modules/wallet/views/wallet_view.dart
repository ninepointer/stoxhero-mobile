import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class WalletView extends GetView<WalletController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  WalletCard(
                    label: 'Deposit',
                    value: '₹ 0.00',
                    iconData: Icons.account_balance_wallet_rounded,
                    buttonLabel: 'Add Money',
                    onPressed: null,
                  ),
                  WalletCard(
                    label: 'Cash',
                    value: FormatHelper.formatNumbers(controller.totalCashAmount.value),
                    iconData: Icons.payments_rounded,
                    buttonLabel: 'Withdrawal',
                    onPressed: () => showBottomModalSheet(context),
                  ),
                  WalletCard(
                    label: 'Bonus',
                    value: '₹ 0.00',
                    iconData: Icons.redeem_rounded,
                    buttonLabel: 'Redeem',
                    onPressed: null,
                  ),
                  SizedBox(height: 16),
                  if (controller.walletTransactionsList.isNotEmpty)
                    CommonTile(label: 'Recent Transactions'),
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
                          amount: trans.amount,
                        );
                      },
                    ),
                  SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
