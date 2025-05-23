import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart'; 

class LoadPicture extends StatefulWidget {
  const LoadPicture({super.key});

  @override
  State<LoadPicture> createState() => _LoadPictureState();
}

class _LoadPictureState extends State<LoadPicture> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioCache _audioCache = AudioCache(prefix: 'assets/');

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
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 194, 124, 1),
      appBar: AppBar(backgroundColor: Color.fromRGBO(56, 52, 50, 1),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/load_picture.png', 
                width: 300,)
              )
            ),
            _image == null
                ? Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200
                    ),
                    child: Icon(Icons.camera_alt, size: 100, color: Colors.grey),
                  )
                : Image.file(_image!, width: 250, height: 250, fit: BoxFit.cover),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(1, 126, 137, 1),
                      shape: BoxShape.circle
                  ),
                  child: IconButton(
                    onPressed: () {
                      playClickSound();
                      _takePicture;
                    },
                    icon: Icon(Icons.camera_alt_rounded, size: 30, color: Color.fromRGBO(169, 208, 236, 1))),
                ),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: 	Color.fromRGBO(1, 126, 137, 1),
                    shape: BoxShape.circle
                  ),
                  child: IconButton(
                    onPressed: () {
                      playClickSound();
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
                  playClickSound();
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
              ),
          ],
        ),
      ),
    );
  }

  void playClickSound() async {
    await _audioCache.play('click.mp3');
  }

}
