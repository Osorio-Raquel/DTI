import 'dart:math';
import 'package:dti/loadPicture.dart';
import 'package:dti/painters/WavePainter.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; 


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioCache _audioCache = AudioCache(prefix: 'assets/');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
    
    _waveAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 194, 124, 1),
      appBar: AppBar(backgroundColor: Color.fromRGBO(56, 52, 50, 1),),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                // Positioned(
                //   top: 0,
                //   left: 0,
                //   child: ClipRect(
                //     child: Align(
                //       alignment: Alignment.topCenter,
                //       heightFactor: 1.0,
                //       child: Image.asset('assets/pattern.jpg', fit: BoxFit.cover,),
                //     ),
                //   ),
                // ),
                AnimatedBuilder(
                  animation: _waveAnimation,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: WavePainter(_waveAnimation.value),
                      child: Container(
                        color: Color.fromRGBO(255, 255, 255, 0.9)
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
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
                      playClickSound();
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
                      style: TextStyle(fontSize: 20, color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void playClickSound() async {
    await _audioCache.play('click.mp3');
  }

  }