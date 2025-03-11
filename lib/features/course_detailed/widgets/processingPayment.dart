import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProcessingPayment extends StatelessWidget {
  const ProcessingPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            'assets/lottie/processingpayment.json',
            fit: BoxFit.fill,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Processing payment. Kindly don\'t close or go back.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
