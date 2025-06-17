import 'dart:math';
import 'package:dti_rvpod/application/animation_providers.dart';
import 'package:dti_rvpod/presentation/painters/dti_logo_painter.dart';
import 'package:dti_rvpod/presentation/painters/star_painter.dart';
import 'package:dti_rvpod/presentation/app_drawer.dart';
import 'package:dti_rvpod/presentation/screens/load_picture.dart';
import 'package:dti_rvpod/presentation/painters/wave_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waveAnimation = ref.watch(waveAnimationProvider);
    final blinkAnimation = ref.watch(starsAnimationProvider);

    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 194, 124, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(56, 52, 50, 1),
        title: SizedBox(
          height: 50,
          width: 50,
          child: CustomPaint(
            painter: DtiLogoPainter(50, 50),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
          )
        ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: GradientRotation(-0.8),
            colors: [
              Color.fromRGBO(169, 208, 236, 0.8), 
              Color.fromRGBO(169, 208, 236, 0.6),
              Color.fromRGBO(169, 208, 236, 0.4),
              Color.fromRGBO(169, 208, 236, 0.3),
              Color.fromRGBO(251, 194, 181, 0.4), 
              Color.fromRGBO(251, 194, 181, 0.8)]
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: waveAnimation,
                      builder: (context, child) {
                        return ClipPath(
                          clipper: WavePainter(waveAnimation.value),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Color.fromRGBO(255, 255, 255, 1),
                              BlendMode.modulate,
                            ),
                            child: Image.asset(
                              'assets/pattern.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  _buildStar(10, 60, 50, 50, blinkAnimation),
                  _buildStar(40, 10, 40, 40, blinkAnimation, isLeft: true),
                  _buildStar(130, 100, 25, 30, blinkAnimation, isLeft: true),
                  _buildStar(180, 80, 20, 20, blinkAnimation),
                  _buildStar(240, 0, 45, 45, blinkAnimation, isLeft: true),
                  _buildStar(-40, 60, 50, 50, blinkAnimation, isBottom: true, isLeft: true),
                  _buildStar(-60, 70, 40, 40, blinkAnimation, isBottom: true),
                  _buildStar(-130, 100, 25, 30, blinkAnimation, isBottom: true),
                  _buildStar(-180, 80, 20, 20, blinkAnimation, isBottom: true, isLeft: true),
                  _buildStar(-240, 70, 45, 45, blinkAnimation, isBottom: true),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Image.asset(
                            'assets/dti_logo.png',
                            fit: BoxFit.contain
                          ),
                        ),
                          
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoadPicture()));
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Color.fromRGBO(56, 52, 50, 1)),
                            foregroundColor: WidgetStateProperty.all(Color.fromRGBO(169, 208, 236, 1)),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            padding: WidgetStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            ),
                            elevation: WidgetStateProperty.all(8),
                          ),
                          child: Text(
                            "Empezar",
                            style: GoogleFonts.outfit(fontSize: 20, color: Color.fromRGBO(255, 255, 255, 1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar(
    double top,
    double left,
    double width,
    double height,
    Animation<double> animation, {
    bool isBottom = false,
    bool isLeft = false,
  }) {
    return Positioned(
      top: isBottom ? null : top,
      bottom: isBottom ? -top : null,
      left: isLeft ? left : null,
      right: isLeft ? null : left,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return CustomPaint(
            painter: StarPainter(width, height, animation.value),
          );
        },
      ),
    );
  }
}