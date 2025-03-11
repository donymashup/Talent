import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/course_detailed/screens/checkout_screen.dart';
import 'package:talent_app/models/course_details_model.dart';

class EnrollButton extends StatefulWidget {
  final CourseDetailsModel courseDetailsModel;

  EnrollButton({super.key, required this.courseDetailsModel});

  @override
  _EnrollButtonState createState() => _EnrollButtonState();
}

class _EnrollButtonState extends State<EnrollButton> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return SwipeableButtonView(
      buttonText:
          "Enroll Course - ${widget.courseDetailsModel.details?.price!}/-",
      buttonWidget: Icon(
        Icons.arrow_forward,
        color: AppConstant.primaryColor,
      ),
      activeColor: Color(0xFFEE3239),
      isFinished: isFinished,
      onWaitingProcess: () {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            isFinished = true;
          });
        });
      },
      onFinish: () {
        // Perform action after swipe completion
        setState(() {
          isFinished = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CheckoutScreen(thisCourses: widget.courseDetailsModel)),
        );
      },
    );
  }
}
