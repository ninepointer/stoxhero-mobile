import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:uuid/uuid.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PaymentView extends StatefulWidget {
  final int amount;

  const PaymentView({
    super.key,
    this.amount = 0,
  });

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String body = "";
  String checksum = "";
  String baseURL = "-";
  String saltIndex = "1";
  String apiEndpoint = "/pg/v1/pay";
  String environment = "PRODUCTION";
  String appId = "42cfbc6993624af5b061665f58797533";
  String saltKey = "92333ad2-4277-4e69-86f1-b86a83161b74";
  String merchantId = "STOXONLINE";

  @override
  void initState() {
    super.initState();
    initPaymentSDK();
  }

  Future initPaymentSDK() async {
    await PhonePePaymentSdk.init(
      environment,
      appId,
      merchantId,
      true,
    );
  }

  Future startPGTransaction() async {
    try {
      await generatePaymentData();
      var response = await PhonePePaymentSdk.startPGTransaction(
        body,
        baseURL,
        checksum,
        {},
        "/pg/v1/pay",
        "com.phonepe.app",
      );
      print(response.toString());
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future generatePaymentData() async {
    final data = {
      "merchantId": merchantId,
      "merchantTransactionId": Uuid().v4(),
      "merchantUserId": Uuid().v1(),
      "amount": "100",
      "redirectUrl": baseURL,
      "callbackUrl": baseURL,
      "redirectMode": "POST",
      "mobileNumber": "9999999999",
      "paymentInstrument": {"type": "PAY_PAGE"}
    };

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

  String generateSha256Hash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: startPGTransaction,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonFilledButton(
              label: 'Start Transaction',
              onPressed: startPGTransaction,
            ),
          ],
        ),
      ),
    );
  }
}

extension EncodingExtensions on String {
  String get toBase64 => base64.encode(toUtf8);
  List<int> get toUtf8 => utf8.encode(this);
  String get toSha256 => sha256.convert(toUtf8).toString();
}
