import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math' as math;

import '../../app/app.dart';
import 'package:crypto/crypto.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PaymentBottomSheet extends StatefulWidget {
  final ProductType productType;
  final String productId;
  final num buyItemPrice;
  final VoidCallback onSubmit;
  final VoidCallback onPaymentSuccess;
  final PaymentTransactionType paymentTransactionType;

  PaymentBottomSheet({
    required this.productType,
    required this.productId,
    required this.buyItemPrice,
    required this.onSubmit,
    required this.onPaymentSuccess,
    this.paymentTransactionType = PaymentTransactionType.debit,
  });

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  late WalletController controller;
  num? walletBalance;

  bool isLoading = false;

  String body = "";
  String checksum = "";
  String callBackUrl = AppUrls.paymentCallBackUrl;
  String saltIndex = "1";
  String apiEndpoint = "/pg/v1/pay";
  String environment = "PRODUCTION";
  String appId = "dcc929b3b7904f93997b89d23de36df3";
  // String appId = "63dff75c930b42a9af0f216bb6af6e16";
  String saltKey = "92333ad2-4277-4e69-86f1-b86a83161b74";
  String merchantId = "STOXONLINE";

  Object? result;
  bool paymentStatus = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<WalletController>();
    controller.removeCouponCode();
    controller.isLoading(false);
    controller.addMoneyAmountTextController.clear();
    controller.subscriptionAmount(widget.buyItemPrice.toDouble());
    controller.actualSubscriptionAmount(widget.buyItemPrice.toDouble());
    if (widget.paymentTransactionType == PaymentTransactionType.debit)
      calculateUserWalletAmount();
    initPaymentSDK();
  }

  bool get isWalletPayment =>
      widget.paymentTransactionType == PaymentTransactionType.credit;

  String generateSha256Hash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future initPaymentSDK() async {
    await PhonePePaymentSdk.init(
      environment,
      appId,
      merchantId,
      true,
    )
        .then((isInitialized) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $isInitialized';
                print(result);
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });

    String signature =
        await PhonePePaymentSdk.getPackageSignatureForAndroid() ?? '';
    print('Signature : $signature');
  }

  String generateUniqueTransactionId() {
    const int maxLength = 36;
    const String allowedCharacters = "0123456789";

    String timestampPart =
        "mtid" + DateTime.now().millisecondsSinceEpoch.toString();
    int remainingLength = maxLength - timestampPart.length;
    String randomChars = List.generate(remainingLength, (index) {
      return allowedCharacters[math.Random().nextInt(allowedCharacters.length)];
    }).join('');

    return timestampPart + randomChars;
  }

  void startPaymentTransaction(BuildContext context) async {
    controller.isLoading(true);
    FocusScope.of(context).unfocus();
    LoginDetailsResponse userDetails = AppStorage.getUserDetails();
    String mtId = generateUniqueTransactionId();
    String muId = 'muid${userDetails.sId}';
    String mobile = userDetails.mobile ?? '';

    await generatePaymentData(mtId, muId, mobile);
    PaymentRequest paymentData = PaymentRequest();
    if (isWalletPayment) {
      num amount =
          num.parse(controller.addMoneyAmountTextController.text) * 100;
      paymentData = PaymentRequest(
        bonusRedemption: 0,
        coupon: controller.isCouponCodeAdded == true
            ? controller.couponCodeTextController.text
            : '',
        // paymentFor: '',
        merchantTransactionId: mtId,
        amount: amount,
      );
    } else {
      num amount = controller.couponCodeSuccessText.isNotEmpty
          ? controller.subscriptionAmount.value
          : widget.buyItemPrice;
      amount = amount * 100;
      paymentData = PaymentRequest(
        bonusRedemption: 0,
        coupon: controller.isCouponCodeAdded == true
            ? controller.couponCodeTextController.text
            : '',
        productId: widget.productId,
        paymentFor: controller.getPaymentProductType(widget.productType),
        merchantTransactionId: mtId,
        amount: amount,
      );
    }

    print('PaymentData : ${paymentData.toJson()}');

    await controller.initPaymentRequest(paymentData);

    await startPhonePePayment();
    Get.back();

    if (paymentStatus) {
      SnackbarHelper.showSnackbar('Transaction successful');
    } else {
      bool status = await controller.checkPaymentStatus(mtId);
      if (status) SnackbarHelper.showSnackbar('Transaction successful');
    }
    if (isWalletPayment) controller.loadData();
    widget.onPaymentSuccess();
    controller.isLoading(false);
  }

  Future generatePaymentData(String mtId, String muId, String mobile) async {
    num amount = 1000;
    if (isWalletPayment) {
      amount = num.parse(controller.addMoneyAmountTextController.text) * 100;
    } else {
      amount = controller.couponCodeSuccessText.isNotEmpty
          ? controller.subscriptionAmount.value
          : widget.buyItemPrice;
      amount = amount * 100;
    }

    final data = {
      "merchantId": merchantId,
      "merchantTransactionId": mtId,
      "merchantUserId": muId,
      "amount": amount,
      "callbackUrl": callBackUrl,
      "mobileNumber": mobile,
      "paymentInstrument": {
        "type": "PAY_PAGE",
      }
    };

    print('PaymentData : $data');

    String jsonString = jsonEncode(data);
    String base64Data = jsonString.toBase64;
    String dataToHash = base64Data + apiEndpoint + saltKey;
    String sHA256 = generateSha256Hash(dataToHash);

    print(base64Data);
    print("$sHA256###$saltIndex");

    body = base64Data;
    checksum = "$sHA256###$saltIndex";

    setState(() {});
  }

  Future startPhonePePayment() async {
    try {
      await PhonePePaymentSdk.startPGTransaction(
        body,
        callBackUrl,
        checksum,
        {"Content-Type": "application/json"},
        apiEndpoint,
        "",
      )
          .then((response) => {
                setState(() {
                  paymentStatus = false;
                  if (response != null) {
                    print(response);
                    String status = response['status'].toString();
                    String error = response['error'].toString();
                    if (status == 'SUCCESS') {
                      paymentStatus = true;
                      result = "Flow Completed - Status: Success!";
                    } else {
                      result =
                          "Flow Completed - Status: $status and Error: $error";
                    }
                  } else {
                    result = "Flow Incomplete";
                  }
                  print(result);
                })
              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  void handleError(error) {
    setState(() {
      if (error is Exception) {
        result = error.toString();
      } else {
        result = {"error": error};
      }
      print(result);
    });
  }

  void calculateUserWalletAmount() async {
    isLoading = true;
    setState(() {});
    num amount = 0;
    var response = await controller.repository.getWalletTransactionsList();
    var list = response.data?.data?.transactions ?? [];
    for (var e in list) {
      if (e.transactionType == 'Cash') {
        amount += e.amount ?? 0;
      }
    }
    walletBalance = amount;
    isLoading = false;
    setState(() {});
  }

  // num amountToPayAfterHeroCashDiscount() {
  //   num amountToPay = 0;
  //   num subAmount = (controller.couponCodeSuccessText.isNotEmpty
  //       ? controller.subscriptionAmount.value
  //       : widget.buyItemPrice);
  //   num discount = subAmount * 10 / 100;

  //   if (controller.isHeroCashAdded.value) {
  //     amountToPay = subAmount - discount;
  //   } else {
  //     amountToPay = subAmount;
  //   }

  //   return amountToPay;
  // }

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
                    isWalletPayment
                        ? 'Add money to\nwallet from bank account'
                        : 'Choose how to pay',
                    style: AppStyles.tsSecondarySemiBold20,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your payment is encrypted and you can change your payment method at anytime.',
                    style: AppStyles.tsGreyRegular14,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  if (!isWalletPayment)
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
                              style: Theme.of(context)
                                  .textTheme
                                  .tsMedium18
                                  .copyWith(
                                    color: AppColors.success,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    CommonTextField(
                      controller: controller.addMoneyAmountTextController,
                      padding: EdgeInsets.only(top: 16),
                      hintText: 'Enter amount',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  if (controller.couponCodeSuccessText.isNotEmpty)
                    GestureDetector(
                      onTap: controller.removeCouponCode,
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .tsMedium12
                                    .copyWith(
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
                  // if (!isWalletPayment)
                  if (walletBalance == null ||
                      widget.buyItemPrice <= walletBalance!)
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
                              backgroundColor: Get.isDarkMode
                                  ? AppColors.darkGreen
                                  : AppColors.lightGreen,
                              labelColor: Get.isDarkMode
                                  ? AppColors.darkGreen
                                  : AppColors.lightGreen,
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
                  if (!isWalletPayment)
                    CommonCard(
                      onTap: () => controller.selectedPaymentValue('wallet'),
                      margin: EdgeInsets.only(top: 16),
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'wallet',
                              groupValue: controller.selectedPaymentValue.value,
                              onChanged: (value) {
                                controller.selectedPaymentValue.value =
                                    value as String;
                              },
                              visualDensity: VisualDensity.compact,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Pay from StoxHero wallet',
                              style: Theme.of(context).textTheme.tsRegular14,
                            ),
                            Spacer(),
                            Text(
                              FormatHelper.formatNumbers(
                                walletBalance,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .tsMedium18
                                  .copyWith(
                                    color: AppColors.success,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  // if (!isWalletPayment)
                  //   Padding(
                  //     padding: EdgeInsets.only(left: 10),
                  //     child: Row(
                  //       children: [
                  //         Checkbox(
                  //           value: controller.isHeroCashAdded.value,
                  //           onChanged: (value) =>
                  //               controller.isHeroCashAdded(value),
                  //         ),
                  //         Text(
                  //             'Use ${(controller.couponCodeSuccessText.isNotEmpty ? controller.subscriptionAmount.value : widget.buyItemPrice) * (10 / 100)} HeroCash (1 HeroCash = \u{20B9}1)'),
                  //       ],
                  //     ),
                  //   ),
                  if (!isWalletPayment)
                    CommonCard(
                      onTap: () => controller.selectedPaymentValue('gateway'),
                      margin: EdgeInsets.only(top: 8),
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'gateway',
                              groupValue: controller.selectedPaymentValue.value,
                              onChanged: (value) {
                                controller.selectedPaymentValue.value =
                                    value as String;
                              },
                              visualDensity: VisualDensity.compact,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Pay from Bank Account/UPI',
                              style: Theme.of(context).textTheme.tsRegular14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  //dbfbhf

                  //fdhfhbd
                  if (walletBalance != null &&
                      widget.buyItemPrice >= walletBalance!)
                    Column(
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Your wallet balance is low kindly refer more users on this platform to buy this subscription.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.tsRegular14,
                        ),
                        SizedBox(height: 16),
                        ReferralCodeCard(),
                      ],
                    ),
                  Column(
                    children: [
                      SizedBox(height: 16),
                      CommonFilledButton(
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen,
                        isLoading: controller.isLoadingStatus,
                        height: 42,
                        label: 'Proceed',
                        onPressed: isWalletPayment ||
                                controller.selectedPaymentValue.value ==
                                    'gateway'
                            ? () => startPaymentTransaction(context)
                            : walletBalance != null &&
                                    widget.buyItemPrice >= walletBalance!
                                ? () {
                                    SnackbarHelper.showSnackbar(
                                        'Low wallet balance!');
                                  }
                                : widget.onSubmit,
                      ),
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
