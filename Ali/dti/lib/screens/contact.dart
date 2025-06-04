import 'package:dti/app_drawer.dart';
import 'package:flutter/material.dart';

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
          color: Colors.white, // Change to your desired color
        )
      ),
      drawer: const AppDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información de Contacto',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('support@dti.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+591 123-4567'),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('123 Fashion St.\nStyle City, ST 12345'),
            ),
            SizedBox(height: 16),
            Text(
              '¡Apreciamos tu feedback y sugerencias!',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}