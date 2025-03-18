import 'package:flutter/material.dart';

// class WaveClipper extends CustomClipper<Path> {
//   @override
//  Path getClip(Size size) {

//   final path = Path();
//   path.lineTo(0, size.height);
//   final firstControlPoint = Offset(size.width / 5, size.height);
//   final firstEndPoint = Offset(size.width / 2.25, size.height - 50);
//   path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//       firstEndPoint.dx, firstEndPoint.dy);

//   final secondControlPoint = Offset(size.width - (size.width / 3.24), size.height - 105);
//   final secondEndPoint = Offset(size.width, size.height - 10);
//   path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//       secondEndPoint.dx, secondEndPoint.dy);

//   path.lineTo(size.width, 0);
//   path.close();
//   return path;

// }
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }



import 'package:flutter/material.dart';

class SingleWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.7);

    final controlPoint = Offset(size.width * 0.5, size.height * 1.2);
    final endPoint = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy,
        endPoint.dx, endPoint.dy);
    
    path.lineTo(size.width, 0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
