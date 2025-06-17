import 'package:dti/screens/results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class LoadPicture extends StatefulWidget {
  const LoadPicture({super.key});

  @override
  State<LoadPicture> createState() => _LoadPictureState();
}

class _LoadPictureState extends State<LoadPicture> {
  File? _image1, _image2, _image3;
  final ImagePicker _picker = ImagePicker();

  Future<File?> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
  
  Future<File?> _takePicture() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.photos.request();
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              transform: GradientRotation(0),
              colors: [
                Color.fromRGBO(169, 208, 236, 0.8), 
                Color.fromRGBO(169, 208, 236, 0.6),
                Color.fromRGBO(169, 208, 236, 0.4),
                Color.fromRGBO(169, 208, 236, 0.3),
                Color.fromRGBO(251, 194, 181, 0.2),]
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/load_picture.png', width: 350),
                imgUpload('¿Cómo luce tu top hoy?', _image1, 1),
                imgUpload('¿Qué piensas usar para la parte de abajo?', _image2, 2),
                imgUpload('¿Con qué zapatos complementarás tu look?', _image3, 3),
                if (_image1 != null && _image2 != null && _image3 != null) ...[
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Results()));
                        },
                        icon: Icon(CupertinoIcons.sparkles, size: 40, color: Colors.white,),
                        label: Text('Calcula mi estilo', style: GoogleFonts.federo(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imgUpload(String title, File? img, int imgNum) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromRGBO(251, 194, 181, 0.65),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: img == null
                        ? const Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                        : Image.file(img, fit: BoxFit.cover),
                  ),
      
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        iconSize: 35,
                        onPressed: () async {
                          final image = await _takePicture();
                          if (image != null) {
                            setState(() {
                              switch(imgNum) {
                                case 1: _image1 = image; break;
                                case 2: _image2 = image; break;
                                case 3: _image3 = image; break;
                              }
                            });
                          }
                        },
                        icon: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(1, 126, 137, 1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.camera_alt_rounded, 
                            color: Color.fromRGBO(169, 208, 236, 1)),
                        ),
                      ),
                      IconButton(
                        iconSize: 35,
                        onPressed: () async {
                          final image = await _pickImageFromGallery();
                          if (image != null) {
                            setState(() {
                              switch(imgNum) {
                                case 1: _image1 = image; break;
                                case 2: _image2 = image; break;
                                case 3: _image3 = image; break;
                              }
                            });
                          }
                        },
                        icon: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(1, 126, 137, 1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.upload_rounded,
                            color: Color.fromRGBO(169, 208, 236, 1)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
