import 'package:flutter/material.dart';

class DtiLogoPainter extends CustomPainter {
  double w, h;
  DtiLogoPainter(this.w, this.h);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path m = Path();
    // Estrella pequeña
    m.moveTo(1 * w/8, 6.5 * h/8);
    m.quadraticBezierTo(1.25 * w/8, 6.5 * h/8, 1.5 * w/8, 6 * h/8);
    m.quadraticBezierTo(1.75 * w/8, 6.5 * h/8, 2 * w/8, 6.5 * h/8);
    m.quadraticBezierTo(1.75 * w/8, 6.5 * h/8, 1.5 * w/8, 7 * h/8);
    m.quadraticBezierTo(1.25 * w/8, 6.5 * h/8, 1 * w/8, 6.5 * h/8);

    // Estrella grande
    m.moveTo(1 * w/8, 5 * h/8);
    m.quadraticBezierTo(2 * w/8, 5 * h/8, 3 * w/8, 3 * h/8);
    m.quadraticBezierTo(4 * w/8, 5 * h/8, 5 * w/8, 5 * h/8);
    m.quadraticBezierTo(4 * w/8, 5 * h/8, 3 * w/8, 7 * h/8);
    m.quadraticBezierTo(2 * w/8, 5 * h/8, 1 * w/8, 5 * h/8);

    canvas.drawPath(m, paint);

    // Bolso
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    m.moveTo(1.5 * w/8, 4 * h/8);
    m.lineTo(2 * w/8, 2 * h/8);
    m.lineTo(6 * w/8, 2 * h/8);
    m.lineTo(7 * w/8, 6 * h/8);
    m.quadraticBezierTo(5.5 * w/8, 6.7 * h/8, 4 * w/8, 6.5 * h/8);
    m.moveTo(3 * w/8, 2 * h/8);
    m.cubicTo(
      3 * w/8, 1 * h/8, 
      5 * w/8, 1 * h/8, 
      5 * w/8, 2 * h/8
    );

    canvas.drawPath(m, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}