import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:uuid/uuid.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PaymentView extends StatefulWidget {
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String body = "";
  String checksum = "";
  String baseURL = "https://webhook.site/callback-url";
  String saltIndex = "1";
  String apiEndpoint = "/pg/v1/pay";
  String environment = "PRODUCTION";
  String appId = "42cfbc6993624af5b061665f58797533";
  String saltKey = "92333ad2-4277-4e69-86f1-b86a83161b74";
  String merchantId = "STOXONLINE";

  Object? result;

  // @override
  // void initState() {
  //   super.initState();
  //   initPaymentSDK();
  // }

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
    getInstalledUpiAppsForAndroid();
  }

  // Future startPGTransaction() async {
  //   try {
  //     await generatePaymentData();
  //     var response = await PhonePePaymentSdk.startPGTransaction(
  //       body,
  //       baseURL,
  //       checksum,
  //       {},
  //       "/pg/v1/pay",
  //       "com.phonepe.app",
  //     );
  //     print(response.toString());
  //   } catch (error) {
  //     print(error);
  //   }
  //   return null;
  // }

  Future generatePaymentData() async {
    final data = {
      "merchantId": merchantId,
      "merchantTransactionId": Uuid().v4(),
      "merchantUserId": Uuid().v1(),
      "amount": 1000,
      "callbackUrl": baseURL,
      "mobileNumber": "9767361687",
      "paymentInstrument": {
        "type": "PAY_PAGE",
      }
      // "paymentInstrument": {
      //   "type": "UPI_INTENT",
      //   "targetApp": "com.phonepe.app",
      // },
      // "deviceContext": {
      //   "deviceOS": "ANDROID",
      // }
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

  void getInstalledUpiAppsForAndroid() {
    if (Platform.isAndroid) {
      PhonePePaymentSdk.getInstalledUpiAppsForAndroid()
          .then((apps) => {
                setState(() {
                  if (apps != null) {
                    Iterable l = json.decode(apps);
                    List<UPIApp> upiApps = List<UPIApp>.from(l.map((model) => UPIApp.fromJson(model)));
                    String appString = '';
                    for (var element in upiApps) {
                      appString += "${element.applicationName} ${element.version} ${element.packageName}";
                    }
                    result = 'Installed Upi Apps - $appString';
                  } else {
                    result = 'Installed Upi Apps - 0';
                  }
                  print(result);
                })
              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    }
  }

  void startPGTransaction() async {
    try {
      await generatePaymentData();
      PhonePePaymentSdk.startPGTransaction(
        body,
        baseURL,
        checksum,
        {"Content-Type": "application/json"},
        apiEndpoint,
        "com.phonepe.app",
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
          children: [
            CommonCard(
              children: [
                Row(
                  children: [
                    Text(
                      'Currently payment method is only available on the web,\nvisit  to top-up your wallet.',
                    ),
                  ],
                ),
              ],
            )
            // CommonFilledButton(
            //   label: 'Start Transaction',
            //   onPressed: startPGTransaction,
            // ),
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

class UPIApp {
  final String? packageName;
  final String? applicationName;
  final String? version;

  UPIApp(
    this.packageName,
    this.applicationName,
    this.version,
  );

  factory UPIApp.fromJson(Map<String, dynamic> data) {
    return UPIApp(
      data['packageName'],
      data['applicationName'],
      data['version'].toString(),
    );
  }
}
