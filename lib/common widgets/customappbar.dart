import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/controllers/user_controller.dart';
import 'package:talent_app/features/home/widgets/custom_Image_Button.dart';
import 'package:talent_app/features/notification/screen/notifications.dart';
import 'package:talent_app/features/profile/screen/my_profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appbarTitle;
  final UserController userController = Get.put(UserController());

  CustomAppBar({required this.appbarTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Obx(() => Text(
            userController.username.value, // Updated name
            style: TextStyle(
              color: AppConstant.titlecolor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
      backgroundColor: AppConstant.backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Image.asset(
            'assets/images/talentlogo.png',
            height: 40,
            width: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/icons/notification.png',
                height: 24,
                width: 24,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: Obx(() {
              return userController.profilePictureUrl.value != null
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userController.profilePictureUrl.value!),
                    )
                  : CustonImageButtom(path: 'assets/icons/profile.png');
            }),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
