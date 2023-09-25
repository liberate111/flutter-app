import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  Map<String, dynamic> item = {};
  var controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    item = Get.arguments;
    controller.loadRequest(Uri.parse(item['url']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${item['sourceName']}')),
      body: WebViewWidget(controller: controller),
    );
  }
}
