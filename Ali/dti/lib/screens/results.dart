import 'package:dti/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 194, 124, 1),
      appBar: AppBar(backgroundColor: Color.fromRGBO(56, 52, 50, 1), iconTheme: IconThemeData(color: Colors.white),),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              transform: GradientRotation(180),
              colors: [
                Color.fromRGBO(169, 208, 236, 0.8), 
                Color.fromRGBO(169, 208, 236, 0.6),
                Color.fromRGBO(169, 208, 236, 0.4),
                Color.fromRGBO(251, 194, 181, 0.6),
                Color.fromRGBO(251, 194, 181, 0.9),]
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/results.png', width: 400),
                Card(
                  elevation: 5,
                  color: Color.fromRGBO(169, 208, 236, 0.8),
                  margin: EdgeInsets.all(50),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        transform: GradientRotation(0.6),
                        colors: [
                          Color.fromRGBO(238, 194, 124, 0),
                          Color.fromRGBO(238, 194, 124, 0.6),
                        ]
                      )
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Column(
                          children: [
                            Text('Tu outfit tiene\n', 
                              style: GoogleFonts.outfit(
                                fontSize: 30, 
                                color: Color.fromRGBO(56, 50, 52, 1)),
                            ),
                            Text('87\n', 
                              style: GoogleFonts.federo(
                                fontSize: 50, 
                                fontWeight: FontWeight.bold, 
                                color: Color.fromRGBO(56, 50, 52, 1)),
                            ),
                            Text('Puntos de Estilo', 
                              style: GoogleFonts.federo(
                                fontSize: 30, 
                                fontStyle: FontStyle.italic, 
                                color: Color.fromRGBO(56, 50, 52, 1)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                description('Blusa', 'Muy bonita'),
                description('Faldita', 'Preciosa'),
                description('Zapatitos Chic', 'Bellisimos'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color.fromRGBO(169, 208, 236, 1), Color.fromRGBO(251, 194, 181, 1)],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      },
                      icon: Icon(CupertinoIcons.back, size: 40, color: Colors.white,),
                      label: Text('Volver', style: GoogleFonts.federo(
                        fontSize: 25, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget description(String name, String descr){
    return Card(
      elevation: 2,
      color: Color.fromRGBO(251, 194, 181, 1),
      margin: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            transform: GradientRotation(-0.6),
            colors: [
              Color.fromRGBO(251, 194, 181, 0.2),
              Color.fromRGBO(238, 194, 124, 0.4),
            ]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(name, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/pattern.jpg', width: 100, fit: BoxFit.scaleDown,),
                  ),
                  Text(descr, style: GoogleFonts.outfit(fontSize: 22),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}