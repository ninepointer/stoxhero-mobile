import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoxhero/main.dart';
import '../../../app/app.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VirtualCandleStickChartView extends StatefulWidget {
  final String? chartName;
  VirtualCandleStickChartView({
    this.chartName, // Fix the typo here
    Key? key,
  }) : super(key: key);

  @override
  State<VirtualCandleStickChartView> createState() =>
      _VirtualCandleStickChartViewState();
}

class _VirtualCandleStickChartViewState
    extends State<VirtualCandleStickChartView> {
  WebViewController controller = WebViewController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    String credentials = base64Encode(utf8.encode('${AppStorage.getToken()}'));

    Map<String, String> headers = {'Authorization': 'Basic $credentials'};

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(
          Uri.parse(
            "${isProd ? 'https://stoxhero.com' : 'https://43.204.7.180'}/chart?instrument=${widget.chartName}",
          ),
          headers: headers)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          if (progress == 100) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = true;
            });
          }
        },
        onPageStarted: (url) {},
        onPageFinished: (url) {},
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.chartName}"),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
