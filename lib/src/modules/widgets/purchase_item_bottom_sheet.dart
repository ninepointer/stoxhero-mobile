import 'package:flutter/material.dart';
import '../../app/app.dart';

class PurchaseItemBottomSheet extends StatefulWidget {
  final ProductType productType;
  final num buyItemPrice;
  final VoidCallback onSubmit;

  PurchaseItemBottomSheet({
    required this.productType,
    required this.buyItemPrice,
    required this.onSubmit,
  });

  @override
  State<PurchaseItemBottomSheet> createState() => _PurchaseItemBottomSheetState();
}

class _PurchaseItemBottomSheetState extends State<PurchaseItemBottomSheet> {
  late WalletController controller;
  num? walletBalance;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<WalletController>();
    controller.removeCouponCode();
    controller.subscriptionAmount(widget.buyItemPrice.toDouble());
    controller.actualSubscriptionAmount(widget.buyItemPrice.toDouble());
    calculateUserWalletAmount();
  }

  void calculateUserWalletAmount() async {
    isLoading = true;
    setState(() {});
    num amount = 0;
    var response = await controller.repository.getWalletTransactionsList();
    var list = response.data?.data?.transactions ?? [];
    for (var e in list) amount += e.amount ?? 0;
    walletBalance = amount;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
                  SizedBox(height: 8),
                  Text(
                    'Your payment is encrypted and you can change your payment method at anytime.',
                    textAlign: TextAlign.center,
                    style: AppStyles.tsGreyRegular14,
                  ),
                  SizedBox(height: 36),
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
                              walletBalance,
                            ),
                            style: Theme.of(context).textTheme.tsMedium20.copyWith(
                                  color: AppColors.success,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CommonCard(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.all(12),
                    children: [
                      Row(
                        children: [
                          Text(
                            'Transaction Amount',
                            style: Theme.of(context).textTheme.tsRegular16,
                          ),
                          Spacer(),
                          Text(
                            FormatHelper.formatNumbers(
                              controller.couponCodeSuccessText.isNotEmpty
                                  ? controller.subscriptionAmount.value
                                  : widget.buyItemPrice,
                            ),
                            style: Theme.of(context).textTheme.tsMedium20.copyWith(
                                  color: AppColors.success,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (controller.couponCodeSuccessText.isNotEmpty)
                    GestureDetector(
                      onTap: controller.removeCouponCode,
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(.25),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                controller.couponCodeSuccessText.value,
                                style: Theme.of(context).textTheme.tsMedium12.copyWith(
                                      color: AppColors.success,
                                    ),
                              ),
                            ),
                            Icon(
                              Icons.close,
                              size: 20,
                              color: AppColors.success,
                            )
                          ],
                        ),
                      ),
                    ),
                  if (walletBalance == null || widget.buyItemPrice <= walletBalance!)
                    if (!controller.isCouponCodeAdded.value)
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              controller: controller.couponCodeTextController,
                              padding: EdgeInsets.only(top: 16),
                              hintText: 'Enter your Coupon code',
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            padding: EdgeInsets.only(top: 16, left: 8),
                            child: CommonOutlinedButton(
                              isLoading: controller.isCouponCodeLoadingStatus,
                              label: 'APPLY',
                              onPressed: () => controller.verifyCouponCode(
                                context,
                                widget.productType,
                                widget.buyItemPrice,
                              ),
                            ),
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
                        SizedBox(height: 16),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
