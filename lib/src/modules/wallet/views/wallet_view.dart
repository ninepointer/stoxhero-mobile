import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class WalletView extends StatefulWidget {
  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  late WalletController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<WalletController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        actions: [
          IconButton(
            splashRadius: 24,
            icon: Icon(
              Icons.circle,
              color: Colors.transparent,
            ),
            onPressed: () => Get.to(() => PaymentView()),
          ),
        ],
      ),
      body: Obx(
        () => CommonTabBar(
          index: controller.selectedTabBarIndex.value,
          onTap: controller.changeTabBarIndex,
          tabsTitle: [
            AppStrings.wallet,
            AppStrings.transactions,
          ],
          tabs: [
            Container(
              child: Column(
                children: [
                  WalletCard(
                    label: 'Deposit',
                    value: '₹0.00',
                    iconData: Icons.account_balance_wallet_rounded,
                    buttonLabel: 'Add Money',
                    // onPressed: () => Get.to(() => PaymentView()),
                  ),
                  WalletCard(
                    label: 'Cash',
                    value: FormatHelper.formatNumbers(controller.totalCashAmount.value),
                    iconData: Icons.payments_rounded,
                    buttonLabel: 'Withdraw',
                    onPressed: () => BottomSheetHelper.openBottomSheet(
                      context: context,
                      child: WalletTransactionBottomSheet(),
                    ),
                  ),
                  WalletCard(
                    label: 'HeroCash',
                    value: '₹0.00',
                    iconData: Icons.redeem_rounded,
                    buttonLabel: 'Redeem',
                    onPressed: null,
                  ),
                ],
              ),
            ),
            CommonTabBar(
              isScrollable: true,
              index: controller.selectedSecondTabBarIndex.value,
              onTap: controller.changeSecondTabBarIndex,
              tabsTitle: [
                AppStrings.recentTransactions,
                AppStrings.successfulTransactions,
              ],
              tabs: [
                RefreshIndicator(
                  onRefresh: controller.getWalletTransactionsList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isRecentLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: SmallCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.walletTransactionsList.isEmpty,
                        child: NoDataFound(
                          label: AppStrings.noDataFound,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.walletTransactionsList.length,
                          itemBuilder: (BuildContext context, index) {
                            var trans = controller.walletTransactionsList[index];
                            return WalletTransactionCard(
                              label: trans.title,
                              subtitle: trans.description,
                              dateTime: FormatHelper.formatDateTimeToIST(trans.transactionDate),
                              amount: trans.amount,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: controller.getMyWithdrawalsTransactionsList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100),
                    child: Visibility(
                      visible: controller.isSuccessLoadingStatus,
                      child: ListViewShimmer(
                        shimmerCard: SmallCardShimmer(),
                      ),
                      replacement: Visibility(
                        visible: controller.withdrawalTransactionsList.isEmpty,
                        child: NoDataFound(
                          label: AppStrings.noDataFound,
                        ),
                        replacement: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.withdrawalTransactionsList.length,
                          itemBuilder: (BuildContext context, index) {
                            var trans = controller.withdrawalTransactionsList[index];
                            if (trans.withdrawalStatus == 'Processed') {
                              return WithdrawalTransactionCard(
                                label: trans.withdrawalStatus,
                                walletTransactionId: trans.walletTransactionId,
                                dateTime: FormatHelper.formatDateTimeToIST(trans.withdrawalRequestDate),
                                amount: trans.amount,
                                mode: trans.settlementMethod,
                                transferTransactionId: trans.settlementTransactionId,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // body: Obx(
      //   () => Visibility(
      //     visible: !controller.isLoadingStatus,
      //     replacement: CommonLoader(),
      //     child: SingleChildScrollView(
      //       child: Container(
      //         child: Column(
      //           children: [
      //             WalletCard(
      //               label: 'Deposit',
      //               value: '₹ 0.00',
      //               iconData: Icons.account_balance_wallet_rounded,
      //               buttonLabel: 'Add Money',
      //               // onPressed: () => Get.to(PaymentView()),
      //             ),
      //             WalletCard(
      //               label: 'Cash',
      //               value: FormatHelper.formatNumbers(controller.totalCashAmount.value),
      //               iconData: Icons.payments_rounded,
      //               buttonLabel: 'Withdrawal',
      //               onPressed: () => BottomSheetHelper.openBottomSheet(
      //                 context: context,
      //                 child: WalletTransactionBottomSheet(),
      //               ),
      //             ),
      //             WalletCard(
      //               label: 'HeroCash',
      //               value: '0',
      //               iconData: Icons.redeem_rounded,
      //               buttonLabel: 'Redeem',
      //               onPressed: null,
      //             ),
      //             if (controller.walletTransactionsList.isNotEmpty)
      //               CommonTile(
      //                 label: 'Recent Transactions',
      //                 margin: EdgeInsets.only(bottom: 0, top: 8),
      //               ),
      //             if (controller.walletTransactionsList.isNotEmpty)
      //               ListView.builder(
      //                 shrinkWrap: true,
      //                 physics: NeverScrollableScrollPhysics(),
      //                 padding: EdgeInsets.zero,
      //                 itemCount: controller.walletTransactionsList.length,
      //                 itemBuilder: (context, index) {
      //                   var trans = controller.walletTransactionsList[index];
      //                   return WalletTransactionCard(
      //                     label: trans.title,
      //                     subtitle: trans.description,
      //                     dateTime: FormatHelper.formatDateTime(trans.transactionDate),
      //                     amount: trans.amount,
      //                   );
      //                 },
      //               ),
      //             SizedBox(height: 36),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
