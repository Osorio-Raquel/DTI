import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StatefulShellWrapper extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  
  const StatefulShellWrapper({
    super.key,
    required this.navigationShell,
  });

  @override
  State<StatefulShellWrapper> createState() => _StatefulShellWrapperState();
}

class _StatefulShellWrapperState extends State<StatefulShellWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
    );
  }
}