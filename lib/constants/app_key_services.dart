import 'dart:convert';
import 'package:talent_app/constants/config.dart';
import 'package:http/http.dart' as http;

class AppKeyServices {
  Future<String> fetchOpenAIKey() async {
    final response = await http.get(Uri.parse(baseUrl + getOpenAiKeyUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['key'];
    } else {
      throw Exception('Failed to load OpenAI key');
    }
  }

  Future<String> fetchRazorpayKey() async {
    final response = await http.get(Uri.parse(baseUrl + getRazorPayKeyUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['key'];
    } else {
      throw Exception('Failed to load Razorpay key');
    }
  }
}
