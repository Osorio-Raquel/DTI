import 'dart:math';
import 'package:dti/painters/dti_logo_painter.dart';
import 'package:dti/painters/star_painter.dart';
import 'package:dti/app_drawer.dart';
import 'package:dti/screens/load_picture.dart';
import 'package:dti/painters/wave_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _starsController;
  late Animation<double> _waveAnimation;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _starsController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );
    
    _waveAnimation = Tween<double>(
      begin: 0, 
      end: 2 * pi
      ).animate(CurvedAnimation(parent: _waveController, curve: Curves.linear)
    );
    
    _blinkAnimation = Tween<double>(
      begin: 0.1,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _starsController,
        curve: Curves.easeInOut,
      ),
    );

    _waveController.repeat();
    _starsController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _starsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      animation: _waveAnimation,
                      builder: (context, child) {
                        return ClipPath(
                          clipper: WavePainter(_waveAnimation.value),
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
                  AnimatedBuilder(
                    animation: _starsController,
                    builder: (context, child) {
                      return Positioned(
                        top: 10,
                        right: 60,
                        child: CustomPaint(
                          painter: StarPainter(50, 50, _blinkAnimation.value),
                        )
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _starsController,
                    builder: (context, child) {
                      return Positioned(
                        top: 40,
                        left: 10,
                        child: CustomPaint(
                          painter: StarPainter(40, 40, _blinkAnimation.value),
                        )
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _starsController,
                    builder: (context, child) {
                      return Positioned(
                        top: 130,
                        left: 100,
                        child: CustomPaint(
                          painter: StarPainter(25, 30, _blinkAnimation.value),
                        )
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _starsController,
                    builder: (context, child) {
                      return Positioned(
                        top: 180,
                        right: 80,
                        child: CustomPaint(
                          painter: StarPainter(20, 20, _blinkAnimation.value),
                        )
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _starsController,
                    builder: (context, child) {
                      return Positioned(
                        top: 240,
                        left: 0,
                        child: CustomPaint(
                          painter: StarPainter(45, 45, _blinkAnimation.value),
                        )
                      );
                    },
                  ),
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

  }