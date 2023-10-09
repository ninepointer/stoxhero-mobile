import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
  String saltIndex = "1";
  String saltKey = "92333ad2-4277-4e69-86f1-b86a83161b74";
  String apiEndpoint = "/pg/v1/pay";

  String paymentGatewayBaseUrl = "https://api.phonepe.com/apis/hermes/pg/v1/pay";
  String paymentUrl = "https://stoxhero.com/";

  bool isViewLoaded = false;
  var result;

  @override
  void initState() {
    super.initState();
    // processPayment();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getPackageSignatureForAndroid();
    // PhonePePaymentSdk.init("PRODUCTION", result ?? "", "STOXONLINE", false);
    // startPGTransaction();
  }

  Future getPackageSignatureForAndroid() async {
    if (Platform.isAndroid) {
      PhonePePaymentSdk.getPackageSignatureForAndroid()
          .then((packageSignature) => {
                setState(() {
                  result = 'getPackageSignatureForAndroid - $packageSignature';
                  print(result.toString());
                })
              })
          .catchError((error) {
        return <dynamic>{};
      });
    }
  }

  Future startPGTransaction() async {
    try {
      var response = await PhonePePaymentSdk.startPGTransaction(
        "eyJtZXJjaGFudElkIjoiTUVSQ0hBTlRVQVQiLCJtZXJjaGFudFRyYW5zYWN0aW9uSWQiOiJNVDc4NTA1OTAwNjgxODgxMDQiLCJtZXJjaGFudFVzZXJJZCI6Ik1VSUQxMjMiLCJhbW91bnQiOiIxMDAiLCJyZWRpcmVjdFVybCI6Imh0dHBzOi8vd2ViaG9vay5zaXRlL3JlZGlyZWN0LXVybCIsInJlZGlyZWN0TW9kZSI6IlBPU1QiLCJjYWxsYmFja1VybCI6Imh0dHBzOi8vd2ViaG9vay5zaXRlL2NhbGxiYWNrLXVybCIsIm1vYmlsZU51bWJlciI6Ijk5OTk5OTk5OTkiLCJwYXltZW50SW5zdHJ1bWVudCI6eyJ0eXBlIjoiUEFZX1BBR0UifX0=",
        "",
        "65949249f15b119630fc86bf2ae9a9b713a02cb58c693904fdf9eb6fea0b62ac###1",
        {},
        "/pg/v1/pay",
        "",
      );
      print(response);
    } catch (error) {}
    return null;
  }

  Future processPayment() async {
    try {
      final jsonData = {
        "merchantId": "STOXONLINE",
        "merchantTransactionId": Uuid().v4(),
        "merchantUserId": Uuid().v4(),
        "amount": '100',
        "mobileNumber": "9999999999",
        "redirectMode": "POST",
        "redirectUrl": "https://stoxhero.com/",
        "callbackUrl": "https://stoxhero.com/",
        "paymentInstrument": {"type": "PAY_PAGE"}
      };

      String jsonString = jsonEncode(jsonData);
      String base64Data = jsonString.toBase64;
      String dataToHash = base64Data + apiEndpoint + saltKey;
      String sha256 = generateSha256Hash(dataToHash);
      String checkSum = "$sha256###$saltIndex";

      print(base64Data);
      print("$sha256###$saltIndex");

      final response = await Dio().post(
        paymentGatewayBaseUrl,
        data: {'request': base64Data},
        options: Options(
          headers: {
            'accept': 'application/json',
            'X-VERIFY': checkSum,
            'Content-Type': 'application/json',
          },
        ),
      );
      print(response);

      var data = response.data;
      paymentUrl = data['data']['instrumentResponse']['redirectInfo']['url'];
      isViewLoaded = true;

      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  String generateSha256Hash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isViewLoaded
            ? InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(paymentUrl),
                ),
                onUpdateVisitedHistory: ((controller, url, androidIsReload) {
                  print(url.toString());
                  if (url!.host.contains("stoxhero.com")) {
                    Navigator.of(context).pop('success');
                  }
                }),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

extension EncodingExtensions on String {
  String get toBase64 => base64.encode(toUtf8);
  List<int> get toUtf8 => utf8.encode(this);
  String get toSha256 => sha256.convert(toUtf8).toString();
}
