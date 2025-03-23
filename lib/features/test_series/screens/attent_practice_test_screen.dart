import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/constants/config.dart';
import 'package:talent_app/controllers/user_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AttendPracticeTestScreen extends StatelessWidget {
  final String testid;

  AttendPracticeTestScreen({super.key, required this.testid});

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
          Uri.parse('$attendPracticeTest/${userData.userid}/$testid'));
    debugPrint('$attendPracticeTest/${userData.userid}/$testid');
    return PopScope(
      canPop: true,
      child: Scaffold(
        // appBar: AppBar(title: const Text('Test Performance Report')),
        body: SafeArea(child: WebViewWidget(controller: controller)),
      ),
    );
  }
}
