import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double heightOffset = 75;
    var path = Path();
    path.moveTo(0, heightOffset);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, heightOffset);
    path.conicTo(size.width / 2, -heightOffset, 0, heightOffset, 0.9);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
