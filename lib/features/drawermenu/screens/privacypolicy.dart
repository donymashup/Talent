import 'package:flutter/material.dart';
import 'package:talent_app/constants/config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacypolicyPage extends StatelessWidget {
  const PrivacypolicyPage({super.key});

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
            if (request.url.startsWith(Privacy)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(Privacy));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Privacy Policy',style: TextStyle(fontWeight: FontWeight.bold),)),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
