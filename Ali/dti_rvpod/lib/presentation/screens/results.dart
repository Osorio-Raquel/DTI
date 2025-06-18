import 'dart:io';
import 'package:dti_rvpod/application/api_providers.dart';
import 'package:dti_rvpod/application/load_picture_providers.dart';
import 'package:dti_rvpod/presentation/screens/home/home_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Results extends ConsumerWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image1 = ref.watch(image1Provider);
    final image2 = ref.watch(image2Provider);
    final image3 = ref.watch(image3Provider);
    
    final analysis = ref.watch(outfitAnalysisProvider);

    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 194, 124, 1),
      appBar: AppBar(backgroundColor: Color.fromRGBO(56, 52, 50, 1), iconTheme: IconThemeData(color: Colors.white),),
      body: analysis.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (results) {
          return SingleChildScrollView(
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
                                Text('${results['score']}\n', 
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
                    Card(
                      elevation: 3,
                      color: Color.fromRGBO(251, 194, 181, 0.8),
                      margin: EdgeInsets.all(30),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            transform: GradientRotation(0),
                            colors: [
                              Color.fromRGBO(169, 208, 236, 0),
                              Color.fromRGBO(169, 208, 236, 0.6),
                            ]
                          )
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              children: [
                                Text('Sugerencia\n', 
                                  style: GoogleFonts.federo(
                                    fontSize: 30, 
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(56, 50, 52, 1)),
                                ),
                                Text('${results['sugerencia']}\n', 
                                  style: GoogleFonts.outfit(
                                    fontSize: 23,
                                    color: Color.fromRGBO(56, 50, 52, 1)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    description('Top', results['descripcionTop'], image1),
                    description('Bottom', results['descripcionBottom'], image2),
                    description('Zapatos', results['descripcionShoes'], image3),
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
                            ref.invalidate(image1Provider);
                            ref.invalidate(image2Provider);
                            ref.invalidate(image3Provider);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeWrapper()));
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
          );
        },
      ),
    );
  }

  Widget description(String name, Map descr, File? img){
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(name, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),)
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300,
                      ),
                      child: img == null
                        ? const Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                        : Image.file(img, fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Color: ${descr['color']}", style: GoogleFonts.outfit(fontSize: 20), textAlign: TextAlign.left, softWrap: true,),
                        Text("Estilo: ${descr['estilo']}", style: GoogleFonts.outfit(fontSize: 20), textAlign: TextAlign.left, softWrap: true,),
                        Text("Forma: ${descr['forma']}", style: GoogleFonts.outfit(fontSize: 20), textAlign: TextAlign.left, softWrap: true,),
                        Text("Tipo: ${descr['tipo']}", style: GoogleFonts.outfit(fontSize: 20), textAlign: TextAlign.left, softWrap: true,),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

