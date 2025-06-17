import 'package:dti_rvpod/presentation/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 194, 124, 1),
      appBar: AppBar(
        title: const Text('Contactános', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(56, 52, 50, 1),
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
            transform: GradientRotation(1.2),
            colors: [
              Color.fromRGBO(169, 208, 236, 0.8), 
              Color.fromRGBO(169, 208, 236, 0.6),
              Color.fromRGBO(169, 208, 236, 0.3),
              Color.fromRGBO(251, 194, 181, 0.2), 
              Color.fromRGBO(251, 194, 181, 0.8)]
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/contact.png',
                fit: BoxFit.contain
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('support@dti.com', style: GoogleFonts.outfit(fontSize: 24),),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('+591 123-4567', style: GoogleFonts.outfit(fontSize: 24),),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('123 Fashion St.\nStyle City, ST 12345', style: GoogleFonts.outfit(fontSize: 24),),
              ),
              SizedBox(height: 16),
              Text(
                '¡Apreciamos tu feedback y sugerencias!',
                style: GoogleFonts.outfit(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}