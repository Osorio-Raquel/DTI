import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

final tickerProvider = Provider<TickerProvider>((ref) {
  throw UnimplementedError('TickerProvider should be overridden');
});

final waveControllerProvider = Provider<AnimationController>((ref) {
  final vsync = ref.watch(tickerProvider);
  final controller = AnimationController(
    vsync: vsync,
    duration: const Duration(seconds: 5),
  )..repeat();
  ref.onDispose(() => controller.dispose());
  return controller;
}, dependencies: [tickerProvider]);

final starsControllerProvider = Provider<AnimationController>((ref) {
  final vsync = ref.watch(tickerProvider);
  final controller = AnimationController(
    vsync: vsync,
    duration: const Duration(milliseconds: 2500),
  )..repeat(reverse: true);
  ref.onDispose(() => controller.dispose());
  return controller;
}, dependencies: [tickerProvider]);

final waveAnimationProvider = Provider<Animation<double>>((ref) {
  final controller = ref.watch(waveControllerProvider);
  return Tween<double>(begin: 0, end: 2 * pi).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ),
  );
}, dependencies: [waveControllerProvider]);

final starsAnimationProvider = Provider<Animation<double>>((ref) {
  final controller = ref.watch(starsControllerProvider);
  return Tween<double>(begin: 0.1, end: 0.8).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ),
  );
}, dependencies: [starsControllerProvider]);