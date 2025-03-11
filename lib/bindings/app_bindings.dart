import 'package:alpha/controllers/is_subscribed_controller.dart';
import 'package:alpha/controllers/selected_course_controller.dart';
import 'package:alpha/controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(IsSubscribedController());
    Get.put(CourseController());
    Get.put(UserController());
  }
}
