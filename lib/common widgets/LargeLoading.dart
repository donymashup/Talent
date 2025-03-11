import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LargeLoading extends StatelessWidget {
  const LargeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/images/orangeripple.json',
        fit: BoxFit.fill,
      ),
    );
  }
}
