import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:talent_app/constants/config.dart';
import 'package:talent_app/controllers/user_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPerformanceScreen extends StatelessWidget {
  final String testid;

  MainPerformanceScreen({super.key, required this.testid});

  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(webUrl)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('${printReport}/mains/${userController.userId}/$testid'));
    debugPrint('${printReport}mains/${userController.userId}/$testid');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Performance Report'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
