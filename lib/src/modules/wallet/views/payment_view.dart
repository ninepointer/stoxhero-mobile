import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:stoxhero/main.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PaymentView extends StatefulWidget {
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late WalletController controller;
  String body = "";
  String checksum = "";
  String callBackUrl = AppUrls.paymentCallBackUrl;
  String saltIndex = "1";
  String apiEndpoint = "/pg/v1/pay";
  String environment = "PRODUCTION";
  String appId = !isProd ? "63dff75c930b42a9af0f216bb6af6e16" : "42cfbc6993624af5b061665f58797533";
  String saltKey = "92333ad2-4277-4e69-86f1-b86a83161b74";
  String merchantId = "STOXONLINE";

  Object? result;

  @override
  void initState() {
    super.initState();
    controller = Get.find<WalletController>();
    initPaymentSDK();
  }

  String generateUniqueTransactionId() {
    const int maxLength = 36;
    const String allowedCharacters = "0123456789";

    String timestampPart = "mtid" + DateTime.now().millisecondsSinceEpoch.toString();
    int remainingLength = maxLength - timestampPart.length;
    String randomChars = List.generate(remainingLength, (index) {
      return allowedCharacters[math.Random().nextInt(allowedCharacters.length)];
    }).join('');

    return timestampPart + randomChars;
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
  }

  Future generatePaymentData() async {
    LoginDetailsResponse userDetails = AppStorage.getUserDetails();
    String mtId = generateUniqueTransactionId();
    String muid = 'muid${userDetails.sId}';

    final data = {
      "merchantId": merchantId,
      "merchantTransactionId": mtId,
      "merchantUserId": muid,
      "amount": 100,
      "callbackUrl": callBackUrl,
      "mobileNumber": userDetails.mobile,
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

    PaymentRequest paymentData = PaymentRequest();

    await controller.initPaymentRequest(paymentData);

    setState(() {});
  }

  String generateSha256Hash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void startPGTransaction() async {
    try {
      await generatePaymentData();
      PhonePePaymentSdk.startPGTransaction(
        body,
        callBackUrl,
        checksum,
        {"Content-Type": "application/json"},
        apiEndpoint,
        "",
      )
          .then((response) => {
                setState(() {
                  if (response != null) {
                    print(response);
                    String status = response['status'].toString();
                    String error = response['error'].toString();
                    if (status == 'SUCCESS') {
                      result = "Flow Completed - Status: Success!";
                    } else {
                      result = "Flow Completed - Status: $status and Error: $error";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
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
