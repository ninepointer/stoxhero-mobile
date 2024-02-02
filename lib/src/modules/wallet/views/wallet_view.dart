import 'package:flutter/material.dart';

import '../../../app/app.dart';

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
                    margin: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.0306,
                    ),
                    child: Column(
                      children: [
                        CommonCard(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.0306,
                          ),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CommonCardTile(
                                    label: 'Name',
                                    value: '${controller.getUserFullName()}',
                                  ),
                                ),
                                Expanded(
                                  child: CommonCardTile(
                                    label: 'KYC Status',
                                    value:
                                        '${controller.walletDetails.value.userId?.kYCStatus}',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.0306,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonCardTile(
                                    label: 'Bank Details Status',
                                    value:
                                        (controller.walletDetails.value.userId
                                                        ?.bankName !=
                                                    null ||
                                                controller.walletDetails
                                                        .value.userId?.ifscCode !=
                                                    null ||
                                                controller
                                                        .walletDetails
                                                        .value
                                                        .userId
                                                        ?.accountNumber !=
                                                    null ||
                                                controller
                                                        .walletDetails
                                                        .value
                                                        .userId
                                                        ?.nameAsPerBankAccount !=
                                                    null)
                                            ? 'Updated'
                                            : 'Not Updated',
                                  ),
                                ),
                                Expanded(
                                  child: CommonCardTile(
                                    label: 'State',
                                    value: (controller.walletDetails.value
                                                .userId?.state !=
                                            null)
                                        ? '${controller.walletDetails.value.userId?.state}'
                                        : 'Not Updated',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.0306,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: WalletCard(
                                label: 'Cash',
                                value: FormatHelper.formatNumbers(
                                    controller.totalCashAmount.value),
                                iconData: Icons.payments_rounded,
                                buttonLabel: 'Withdraw',
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0306,
                            ),
                            Expanded(
                              child: WalletCard(
                                label: 'HeroCash',
                                value: FormatHelper.formatNumbers(
                                  controller.calculateBonus(
                                      controller.walletTransactionsList),
                                  showSymbol: false,
                                ),
                                iconData: Icons.redeem_rounded,
                                buttonLabel: 'Redeem',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.0306,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CommonFilledButton(
                                backgroundColor: Get.isDarkMode
                                    ? AppColors.darkGreen
                                    : AppColors.lightGreen,
                                height: 42,
                                label: 'Withdraw',
                                onPressed: () =>
                                    BottomSheetHelper.openBottomSheet(
                                  context: context,
                                  child: WalletTransactionBottomSheet(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.0306,
                            ),
                            Expanded(
                              child: CommonFilledButton(
                                backgroundColor: Get.isDarkMode
                                    ? AppColors.darkGreen
                                    : AppColors.lightGreen,
                                height: 42,
                                label: 'Add Money',
                                onPressed: () =>
                                    BottomSheetHelper.openBottomSheet(
                                  context: context,
                                  child: PaymentBottomSheet(
                                    productType: ProductType.wallet,
                                    productId: "",
                                    paymentTransactionType:
                                        PaymentTransactionType.credit,
                                    buyItemPrice: 0,
                                    onSubmit: () {},
                                    onPaymentSuccess: () {},
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        CommonCard(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.0306,
                          ),
                          padding: EdgeInsets.zero,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.width *
                                            0.0306,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    color: AppColors.secondary.withOpacity(0.1),
                                  ),
                                  child: Text(
                                    AppStrings.important,
                                    style: Theme.of(context)
                                        .textTheme
                                        .tsSecondaryMedium16,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.0306,
                                    vertical:
                                        MediaQuery.of(context).size.width *
                                            0.0306,
                                  ),
                                  child: Text(
                                    '''1. Please ensure you have filled your bank details and completed your KYC before proceeding with your withdrawal.

2. Your full name on StoxHero, Bank Account, Aadhaar Card and PAN Card should match.

3. TDS has already been deducted from your net winnings.

4. Transfer might take upto 24-48 working hours to reflect in your bank account.

5. You can only make one withdrawal in a day.

6. The minimum withdrawal amount is ${FormatHelper.formatNumbers(controller.readSetting.value.minWithdrawal, decimal: 0)}.

7. The maximum withdrawal limit for a day is ${FormatHelper.formatNumbers(controller.readSetting.value.maxWithdrawal, decimal: 0)}.

8. The minimum StoxHero wallet balance should be  ${FormatHelper.formatNumbers(controller.readSetting.value.minWalletBalance, decimal: 0)}''',
                                    style:
                                        Theme.of(context).textTheme.tsRegular14,
                                  ),
                                ),
                              ],
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
                            var trans =
                                controller.walletTransactionsList[index];
                            return WalletTransactionCard(
                              label: trans.title,
                              subtitle: trans.description,
                              dateTime: FormatHelper.formatDateTimeToIST(
                                  trans.transactionDate),
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
                          itemCount:
                              controller.withdrawalTransactionsList.length,
                          itemBuilder: (BuildContext context, index) {
                            var trans =
                                controller.withdrawalTransactionsList[index];
                            if (trans.withdrawalStatus == 'Processed') {
                              return WithdrawalTransactionCard(
                                label: trans.withdrawalStatus,
                                walletTransactionId: trans.walletTransactionId,
                                dateTime: FormatHelper.formatDateTimeToIST(
                                    trans.withdrawalRequestDate),
                                amount: trans.amount,
                                mode: trans.settlementMethod,
                                transferTransactionId:
                                    trans.settlementTransactionId,
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
