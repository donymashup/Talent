
import 'package:flutter/material.dart';

class colorDot extends StatelessWidget {
  final top;
  final double? right;
  final double? left;
  final width;
  final height;
  final Color;
  const colorDot({
    required this.top,
    this.right,
    required this.width,
    required this.height,
    required this.Color,
    super.key, this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color,
        ),
      ),
    );
  }
}

