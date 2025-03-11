import 'package:get/get.dart';
import 'package:talent_app/controllers/is_subscribed_controller.dart';
import 'package:talent_app/controllers/selected_course_controller.dart';
import 'package:talent_app/controllers/user_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(IsSubscribedController());
    Get.put(CourseController());
    Get.put(UserController());
  }
}
