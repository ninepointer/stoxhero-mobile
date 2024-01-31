import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FlutterWebView extends StatefulWidget {
  const FlutterWebView({Key? key}) : super(key: key);

  @override
  State<FlutterWebView> createState() => _FlutterWebViewState();
}

class _FlutterWebViewState extends State<FlutterWebView> {
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web Bar"),
      ),
      body: InAppWebView(
        initialUrlRequest:
            URLRequest(url: Uri.parse('https://www.stoxhero.com')),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webViewController = controller;
        },
      ),
    );
  }
}
