import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/course_detailed/services/course_details_services.dart';
import 'package:alpha/features/course_detailed/widgets/paymentFailedWidget.dart';
import 'package:alpha/features/course_detailed/widgets/paymentSuccessfull.dart';
import 'package:alpha/features/course_detailed/widgets/processingPayment.dart';
import 'package:flutter/material.dart';

class FreeEnrollmentScreen extends StatefulWidget {
  final String amount;
  final String courseid;
  final String promo_code;

  const FreeEnrollmentScreen({
    super.key,
    required this.amount,
    required this.courseid,
    required this.promo_code,
  });

  @override
  State<FreeEnrollmentScreen> createState() => _FreeEnrollmentScreenState();
}

class _FreeEnrollmentScreenState extends State<FreeEnrollmentScreen> {
  bool _isPaymentProcessing = true;
  bool _isPaymentSuccess = false;

  final CourseDetailsService _courseDetailsService = CourseDetailsService();

  @override
  void initState() {
    super.initState();
    _enrollStudent();
  }

  void _enrollStudent() {
    debugPrint("Enrolling student");
    _courseDetailsService
        .freeEnrollment(
      context: context,
      courseId: widget.courseid,
      promo: widget.promo_code,
      userId: userData.userid, // Replace with actual userId
      amount: widget.amount,
    )
        .then((value) {
      setState(() {
        _isPaymentProcessing = false;
        _isPaymentSuccess = value?.type == "success";
      });
    }).catchError((onError) {
      setState(() {
        _isPaymentProcessing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: _isPaymentProcessing
              ? const ProcessingPayment()
              : _isPaymentSuccess
                  ? const PaymentSuccessfull()
                  : const PaymentFailed(),
        ),
      ),
    );
  }
}
