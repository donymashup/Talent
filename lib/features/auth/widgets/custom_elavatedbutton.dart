import 'package:flutter/material.dart';

class CustomElavatedButton extends StatelessWidget {
 final Widget child;
  final onPressed;
  const CustomElavatedButton({
    required this.child,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEE3239),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
      ),
      child:child
    );
  }
}