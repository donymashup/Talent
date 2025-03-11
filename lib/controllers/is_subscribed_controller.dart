import 'package:get/get.dart';

class IsSubscribedController extends GetxController {
  var isSubscribed = false.obs; // Observable variable

  // Method to update lock icon visibility
  void setVisibility(bool value) {
    isSubscribed.value = value;
  }
}
