import 'package:dti_rvpod/presentation/painters/dti_logo_painter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.decelerate,
      child: Drawer(
        backgroundColor: Color.fromRGBO(251, 194, 181, 1),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(169, 208, 236, 0.8), 
                Color.fromRGBO(169, 208, 236, 0.5),
                Color.fromRGBO(169, 208, 236, 0.3),
                Color.fromRGBO(169, 208, 236, 0.1)]
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(169, 208, 236, 1),
                    Color.fromRGBO(169, 208, 236, 0.9),
                    Color.fromRGBO(251, 194, 181, 1),
                    ],
                    transform: GradientRotation(-0.6))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: CustomPaint(
                        painter: DtiLogoPainter(130, 130),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Dress\nTo\nImpress',
                        style: GoogleFonts.federo(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Color.fromRGBO(56, 50, 52, 1),),
                title: Text('Home', style: GoogleFonts.outfit(color: Color.fromRGBO(56, 50, 52, 1)),),
                onTap: () {
                  context.go('/');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Color.fromRGBO(56, 50, 52, 1),),
                title: Text('Acerca de la App', style: GoogleFonts.outfit(color: Color.fromRGBO(56, 50, 52, 1)),),
                onTap: () {
                  context.go('/about');
                },
              ),
              ListTile(
                leading: const Icon(Icons.mail, color: Color.fromRGBO(56, 50, 52, 1),),
                title: Text('Contacto', style: GoogleFonts.outfit(color: Color.fromRGBO(56, 50, 52, 1)),),
                onTap: () {
                  context.go('/contact');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}