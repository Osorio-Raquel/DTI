import 'dart:io';
import 'package:dti_rvpod/application/api_providers.dart';
import 'package:dti_rvpod/application/load_picture_providers.dart';
import 'package:dti_rvpod/presentation/screens/results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class LoadPicture extends ConsumerWidget {
  const LoadPicture({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(permissionsProvider);
    
    final image1 = ref.watch(image1Provider);
    final image2 = ref.watch(image2Provider);
    final image3 = ref.watch(image3Provider);
    final picker = ref.read(imagePickerProvider);

    final analysisNotifier = ref.read(outfitAnalysisProvider.notifier);

    Future<File?> pickImageFromGallery() async {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      return pickedFile != null ? File(pickedFile.path) : null;
    }
    
    Future<File?> takePicture() async {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      return pickedFile != null ? File(pickedFile.path) : null;
    }

    void updateImage(File? image, int imgNum) {
      switch(imgNum) {
        case 1: ref.read(image1Provider.notifier).state = image; break;
        case 2: ref.read(image2Provider.notifier).state = image; break;
        case 3: ref.read(image3Provider.notifier).state = image; break;
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 194, 124, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 52, 50, 1), 
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              transform: GradientRotation(0),
              colors: [
                const Color.fromRGBO(169, 208, 236, 0.8), 
                const Color.fromRGBO(169, 208, 236, 0.6),
                const Color.fromRGBO(169, 208, 236, 0.4),
                const Color.fromRGBO(169, 208, 236, 0.3),
                const Color.fromRGBO(251, 194, 181, 0.2),
              ]
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/load_picture.png', width: 350),
                _ImgUpload(
                  title: '¿Cómo luce tu top hoy?',
                  img: image1,
                  onCameraPressed: () async => updateImage(await takePicture(), 1),
                  onGalleryPressed: () async => updateImage(await pickImageFromGallery(), 1),
                ),
                _ImgUpload(
                  title: '¿Qué piensas usar para la parte de abajo?',
                  img: image2,
                  onCameraPressed: () async => updateImage(await takePicture(), 2),
                  onGalleryPressed: () async => updateImage(await pickImageFromGallery(), 2),
                ),
                _ImgUpload(
                  title: '¿Con qué zapatos complementarás tu look?',
                  img: image3,
                  onCameraPressed: () async => updateImage(await takePicture(), 3),
                  onGalleryPressed: () async => updateImage(await pickImageFromGallery(), 3),
                ),
                if (image1 != null && image2 != null && image3 != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(169, 208, 236, 1), 
                            Color.fromRGBO(251, 194, 181, 1)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final dialogContext = Navigator.of(context, rootNavigator: true).context;
                          
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (dialogContext) => AlertDialog(
                              content: Row(
                                children: [
                                  const CircularProgressIndicator(color: Color.fromRGBO(1, 126, 137, 1),),
                                  const SizedBox(width: 16, height: 10),
                                  Text('Analizando outfit...', style: GoogleFonts.outfit(),),
                                ],
                              ),
                            ),
                          );

                          await analysisNotifier.analyzeOutfit([image1, image2, image3]);
                          Navigator.of(dialogContext).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (currentContext) => const Results()),
                          );
                        },
                        icon: const Icon(
                          CupertinoIcons.sparkles, 
                          size: 40, 
                          color: Colors.white,
                        ),
                        label: Text(
                          'Calcula mi estilo', 
                          style: GoogleFonts.federo(
                            fontSize: 25, 
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24, 
                            vertical: 16,
                          ),
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
}

class _ImgUpload extends StatelessWidget {
  final String title;
  final File? img;
  final Future<void> Function() onCameraPressed;
  final Future<void> Function() onGalleryPressed;

  const _ImgUpload({
    required this.title,
    required this.img,
    required this.onCameraPressed,
    required this.onGalleryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color.fromRGBO(251, 194, 181, 0.65),
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
                        : Image.file(img!, fit: BoxFit.cover),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        iconSize: 35,
                        onPressed: onCameraPressed,
                        icon: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(1, 126, 137, 1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.camera_alt_rounded, 
                            color: Color.fromRGBO(169, 208, 236, 1),
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 35,
                        onPressed: onGalleryPressed,
                        icon: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(1, 126, 137, 1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.upload_rounded,
                            color: Color.fromRGBO(169, 208, 236, 1),
                          ),
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