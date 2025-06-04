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
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  
  Future<void> _takePicture() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
      appBar: AppBar(backgroundColor: Color.fromRGBO(56, 52, 50, 1),),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            child: Image.asset('assets/load_picture.png', 
              width: 300,)
          ),
          Positioned(
            top: 250,
            left: 10,
            child: Column(
              children: [
                col('¿Cómo luce tu top hoy?'),
                col('¿Qué piensas usar para la parte de abajo hoy?'),
                col('¿Con qué zapatos complementarás tu look?'),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromRGBO(169, 208, 236, 1), Color.fromRGBO(251, 194, 181, 1)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.sparkles),
                    label: Text('Calcula mi estilo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget col(String text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Text(text),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
              ? Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300
                  ),
                  child: Icon(Icons.camera_alt, size: 100, color: Colors.grey),
                )
              : Image.file(_image!, width: 250, height: 250, fit: BoxFit.cover),

          SizedBox(width: 50),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(1, 126, 137, 1),
                    shape: BoxShape.circle
                ),
                child: IconButton(
                  onPressed: () {
                    _takePicture;
                  },
                  icon: Icon(Icons.camera_alt_rounded, size: 30, color: Color.fromRGBO(169, 208, 236, 1))),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: 	Color.fromRGBO(1, 126, 137, 1),
                  shape: BoxShape.circle
                ),
                child: IconButton(
                  onPressed: () {
                    _pickImageFromGallery;
                  },
                  icon: Icon(Icons.upload_rounded, size: 30, color: Color.fromRGBO(169, 208, 236, 1))),
              ),
            ],
          ),

          SizedBox(height: 20),

          if (_image != null)
            ElevatedButton.icon(
              onPressed: () {
                print("Searching combinations...");
              },
              icon: Icon(CupertinoIcons.sparkles),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color.fromRGBO(56, 52, 50, 1)),
                foregroundColor: WidgetStateProperty.all(Color.fromRGBO(169, 208, 236, 1)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                elevation: WidgetStateProperty.all(8),
              ),
              label: Text("Buscar combinaciones"),
            )
          ],
        ),
      ],
    );
  }
}
