import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  double w, h;
  final double opacity;
  StarPainter(this.w, this.h, this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromRGBO(255, 255, 255, opacity)
      ..style = PaintingStyle.fill;

    Path m = Path();
    m.moveTo(1 * w/4, 2 * h/4);
    m.quadraticBezierTo(1.8 * w/4, 2 * h/4, 2 * w/4, 0);
    m.quadraticBezierTo(2.2 * w/4, 2 * h/4, 3 * w/4, 2 * h/4);
    m.quadraticBezierTo(2.2 * w/4, 2 * h/4, 2 * w/4, h);
    m.quadraticBezierTo(1.8 * w/4, 2 * h/4, 1 * w/4, 2 * h/4);

    canvas.drawPath(m, paint);
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return true;
  }
}