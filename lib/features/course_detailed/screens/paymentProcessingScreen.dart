import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/course_detailed/services/course_details_services.dart';
import 'package:alpha/features/course_detailed/widgets/paymentFailedWidget.dart';
import 'package:flutter/material.dart';
import '../widgets/paymentSuccessfull.dart';
import '../widgets/processingPayment.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final String amount, courseid, promo_code, orderid, paymentid, signature;

  const PaymentProcessingScreen(
      {Key? key,
      required this.amount,
      required this.courseid,
      required this.promo_code,
      required this.orderid,
      required this.paymentid,
      required this.signature})
      : super(key: key);

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  bool _isPaymentProcessing = true;
  bool _isPaymentSuccess = false;

  final CourseDetailsService _courseDetailsService = CourseDetailsService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enrollStudent();
  }

  void enrollStudent() {
    _courseDetailsService
        .enrollStudent(
            amount: widget.amount,
            userid: userData.userid,
            courseid: widget.courseid,
            promo_code: widget.promo_code,
            orderid: widget.orderid,
            paymentid: widget.paymentid,
            signature: widget.signature,
            context: context)
        .then((value) {
      if (value!.type == "success") {
        setState(() {
          _isPaymentProcessing = !_isPaymentProcessing;
          _isPaymentSuccess = !_isPaymentSuccess;
        });
      } else {
        setState(() {
          _isPaymentProcessing = !_isPaymentProcessing;
        });
      }
    }).catchError((onError) {
      setState(() {
        _isPaymentProcessing = !_isPaymentProcessing;
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
