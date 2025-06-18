// api_providers.dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  /// Envia las 3 imágenes (top, bottom, shoes) al backend Flask
  Future<String> sendOutfit(List<File> imagenes) async {
    print('[LOG] Iniciando envío de outfit...');

    if (imagenes.length != 3) {
      return '[ERROR] Debes enviar 3 imágenes: top, bottom y zapatos';
    }

    var uri = Uri.parse(
      "http://10.0.2.2:5000/predict",
    ); // Cambia a tu IP local si usas físico

    try {
      var request = http.MultipartRequest('POST', uri);

      for (var i = 0; i < imagenes.length; i++) {
        print('[LOG] Agregando imagen ${i + 1}: ${imagenes[i].path}');
        var file = await http.MultipartFile.fromPath(
          'images',
          imagenes[i].path,
          filename: basename(imagenes[i].path),
        );
        request.files.add(file);
      }

      print('[LOG] Enviando solicitud...');
      var response = await request.send().timeout(const Duration(seconds: 10));
      print('[LOG] Solicitud enviada, esperando respuesta...');

      print('[LOG] Respuesta recibida, status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final respuesta = await response.stream.bytesToString();
        print('[SUCCESS] Respuesta del backend: $respuesta');
        return respuesta;
      } else {
        return '[ERROR] Código de estado HTTP: ${response.statusCode}';
      }
    } on SocketException {
      return '[ERROR] No se pudo conectar al servidor. ¿Está activo el backend?';
    } on TimeoutException {
      return '[ERROR] Tiempo agotado esperando respuesta del backend.';
    } catch (e) {
      return '[ERROR] Excepción inesperada: $e';
    }
  }

  /// Analiza el JSON recibido y extrae los campos clave del outfit
  Future<Map<String, dynamic>> parseResponse(String respuestaJson) async {
    try {
      final data = json.decode(respuestaJson);
      return {
        "score": data["compatibility_score"],
        "sugerencia": data["suggestion"],
        "descripcionTop": data["descripcion_outfit"]["top"],
        "descripcionBottom": data["descripcion_outfit"]["bottom"],
        "descripcionShoes": data["descripcion_outfit"]["shoes"],
      };
    } catch (e) {
      print('[ERROR] No se pudo parsear el JSON: $e');
      return {};
    }
  }
}

final outfitAnalysisProvider = StateNotifierProvider<OutfitAnalysisNotifier, AsyncValue<Map<String, dynamic>>>(
  (ref) => OutfitAnalysisNotifier(ref),
);

class OutfitAnalysisNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final Ref ref;
  
  OutfitAnalysisNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> analyzeOutfit(List<File> images) async {
    state = const AsyncValue.loading();
    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.sendOutfit(images);
      final parsed = await apiService.parseResponse(response);
      state = AsyncValue.data(parsed);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}