import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

/// Envia las 3 imágenes (top, bottom, shoes) al backend Flask
Future<String> enviarOutfit(List<File> imagenes) async {
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

    print('[LOG] Esperando respuesta...');
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
Future<Map<String, dynamic>> analizarRespuesta(String respuestaJson) async {
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
