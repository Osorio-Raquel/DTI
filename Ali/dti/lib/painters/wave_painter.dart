import 'dart:math';
import 'package:flutter/material.dart';

class WavePainter extends CustomClipper<Path> {
  final double waveProgress;

  WavePainter(this.waveProgress);

  @override
  Path getClip(Size size) {
    final path = Path();

    final waveHeight = 20.0;

    for (double y = 0; y <= size.height; y++) {
      double x = sin((y / size.height * 2 * pi * (-1)) + waveProgress) * waveHeight + size.width * 0.8;
      if (y == 0){
        path.moveTo(x, y);
      }
      else{
        path.lineTo(x, y);
      }
    }

    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}