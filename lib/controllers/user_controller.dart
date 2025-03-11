import 'package:alpha/models/user_details_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var username = 'User'.obs;
  var userId = '0'.obs; // Corrected default value
  var profilePictureUrl = RxnString(); // Allow null values

  @override
  void onInit() {
    super.onInit();
    loadUsername();
    loadProfilePicture();
    loadUserId();
    loadUserData();
  }

  /// Loads the username from SharedPreferences
  Future<void> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('firstName') ?? 'User';
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('firstName') ?? 'User';
    userId.value = prefs.getString('userId') ?? '0';
    profilePictureUrl.value = prefs.getString('image');
  }
 // Method to update user details dynamically
  void updateUserDetails(UserDetailsModel userDetails) {
    username.value = userDetails.user!.firstName!;
    profilePictureUrl.value = userDetails.user!.image!;
    update(); // Force UI update
  }

  /// Loads the userId from SharedPreferences
  Future<void> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('userId') ?? '0';
  }

  /// Loads the profile picture from SharedPreferences
  Future<void> loadProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUrl = prefs.getString('image');
    if (savedUrl != null) {
      profilePictureUrl.value = savedUrl;
    }
  }

  /// Updates the profile picture URL and stores it in SharedPreferences
  Future<void> updateProfilePicture(String newUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('image', newUrl);

    profilePictureUrl.value = newUrl; // Update state
    update(); // Force UI update (alternative: profilePictureUrl.refresh())
  }
}
