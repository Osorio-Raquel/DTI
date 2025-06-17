import 'package:dti_rvpod/application/animation_providers.dart';
import 'package:dti_rvpod/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        tickerProvider.overrideWithValue(this),
      ],
      child: const Home(),
    );
  }
}