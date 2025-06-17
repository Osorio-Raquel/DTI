import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

final image1Provider = StateProvider<File?>((ref) => null);
final image2Provider = StateProvider<File?>((ref) => null);
final image3Provider = StateProvider<File?>((ref) => null);

final permissionsProvider = FutureProvider<void>((ref) async {
  await Permission.camera.request();
  await Permission.photos.request();
});