import 'package:flutter/material.dart';

class CustonImageButtom extends StatelessWidget {
  final String path; // Change to String type for image path
  final VoidCallback? onTap; // Add onTap callback

  const CustonImageButtom({
    required this.path,
    this.onTap, // Add optional onTap parameter
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        path,
        height: 40,
        width: 40,
      ),
      onPressed: onTap, // Trigger the onTap callback when pressed
    );
  }
}
