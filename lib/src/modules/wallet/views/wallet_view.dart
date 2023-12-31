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
            RefreshIndicator(
              onRefresh: controller.loadData,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: controller.isRecentLoadingStatus,
                  child: ListViewShimmer(
                    shimmerCard: SmallCardShimmer(),
                  ),
                  replacement: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: WalletCard(
                                label: 'Cash',
                                value: FormatHelper.formatNumbers(controller.totalCashAmount.value),
                                iconData: Icons.payments_rounded,
                                buttonLabel: 'Withdraw',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: WalletCard(
                                label: 'HeroCash',
                                value: '₹0.00',
                                iconData: Icons.redeem_rounded,
                                buttonLabel: 'Redeem',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CommonFilledButton(
                                backgroundColor: AppColors.success,
                                height: 42,
                                label: 'Withdraw',
                                onPressed: () => BottomSheetHelper.openBottomSheet(
                                  context: context,
                                  child: WalletTransactionBottomSheet(),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: CommonFilledButton(
                                height: 42,
                                label: 'Add Money',
                                onPressed: () => BottomSheetHelper.openBottomSheet(
                                  context: context,
                                  child: PaymentBottomSheet(
                                    productType: ProductType.wallet,
                                    productId: "",
                                    paymentTransactionType: PaymentTransactionType.credit,
                                    buyItemPrice: 0,
                                    onSubmit: () {},
                                    onPaymentSuccess: () {},
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     const url = 'https://stoxhero.com/';
                        //     if (await canLaunchUrl(Uri.parse(url))) {
                        //       await launchUrl(Uri.parse(url));
                        //     } else {
                        //       throw 'Could not launch $url';
                        //     }
                        //   },
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16).copyWith(
                        //       top: 0,
                        //     ),
                        //     child: RichText(
                        //       textAlign: TextAlign.center,
                        //       text: TextSpan(
                        //         style: AppStyles.tsGreyRegular14,
                        //         children: [
                        //           TextSpan(
                        //             text: 'Currently payment method is only available on the web, visit ',
                        //           ),
                        //           TextSpan(
                        //             text: 'www.stoxhero.com',
                        //             style: AppStyles.tsPrimaryMedium14.copyWith(
                        //               decoration: TextDecoration.underline,
                        //             ),
                        //           ),
                        //           TextSpan(
                        //             text: ' to top-up your wallet.',
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
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
    );
  }
}
