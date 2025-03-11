import 'package:flutter/material.dart';
import 'package:talent_app/features/auth/widgets/edit_pen.dart';

class profile extends StatelessWidget {
  const profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.17,
      left: 0,
      right: 0,
      child: const Stack(
        alignment: Alignment.center, // Aligns the children at the center
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/icons/profile.png'),
          ),
          EditPen(),
        ],
      ),
    );
  }
}

