import 'package:dti/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 194, 124, 1),
      appBar: AppBar(
        title: const Text('About', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(56, 52, 50, 1),
        iconTheme: IconThemeData(
          color: Colors.white, // Change to your desired color
        )
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: GradientRotation(0),
            colors: [
              Color.fromRGBO(169, 208, 236, 0.8), 
              Color.fromRGBO(169, 208, 236, 0.6),
              Color.fromRGBO(169, 208, 236, 0.4),
              Color.fromRGBO(169, 208, 236, 0.3),
              Color.fromRGBO(251, 194, 181, 0.2), 
              Color.fromRGBO(251, 194, 181, 0.4)]
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dress To Impress',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Esta aplicación evalua tus outfits en base a 3 imágenes: tu parte de arriba, tu parte de abajo y tus zapatos.\n\n'
                'Nuestra IA analiza color y forma para asignar "Puntos de Estilo" a tu outfit.',
                style: GoogleFonts.outfit(fontSize: 24)
              ),
              const SizedBox(height: 16),
              Text(
                'Version: 1.0.0',
                style: GoogleFonts.outfit(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}