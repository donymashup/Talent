import 'package:flutter/material.dart';
import 'package:talent_app/features/auth/widgets/wave_clipper.dart';

class wave_widget extends StatelessWidget {
  final dynamic height;

  const wave_widget({
    super.key,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: height,
        color: Colors.deepPurple,
      ),
    );
  }
}
