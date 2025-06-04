import 'dart:io';
import 'package:dti/archivo.dart'; // Aquí tienes enviarOutfit y analizarRespuesta
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const LookAIApp());

class LookAIApp extends StatelessWidget {
  const LookAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'LookAI', home: OutfitScreen());
  }
}

class OutfitScreen extends StatefulWidget {
  @override
  _OutfitScreenState createState() => _OutfitScreenState();
}

class _OutfitScreenState extends State<OutfitScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> imagenes = [];

  double? _compatibilidad;
  String? _sugerencia;
  Map<String, dynamic>? _descripcionOutfit;

  Future<void> _seleccionarImagen(int index) async {
    final XFile? seleccionada = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (seleccionada != null) {
      setState(() {
        if (imagenes.length > index) {
          imagenes[index] = File(seleccionada.path);
        } else {
          imagenes.add(File(seleccionada.path));
        }
      });
    }
  }

  Future<void> _enviar() async {
    if (imagenes.length < 3) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Selecciona 3 imágenes')));
      return;
    }

    final respuesta = await enviarOutfit(imagenes);
    final detalles = await analizarRespuesta(respuesta);

    setState(() {
      _compatibilidad = detalles['score'];
      _sugerencia = detalles['sugerencia'];
      _descripcionOutfit = {
        "Top": detalles['descripcionTop'],
        "Bottom": detalles['descripcionBottom'],
        "Zapatos": detalles['descripcionShoes'],
      };
    });
  }

  Widget _buildDescripcion(String titulo, Map descripcion) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("Color: ${descripcion['color']}"),
            Text("Estilo: ${descripcion['estilo']}"),
            Text("Forma: ${descripcion['forma']}"),
            Text("Tipo: ${descripcion['tipo']}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LookAI – Sugerencia de Outfit')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (var i = 0; i < 3; i++)
              ElevatedButton(
                onPressed: () => _seleccionarImagen(i),
                child: Text('Seleccionar imagen ${i + 1}'),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviar,
              child: const Text('Enviar al backend'),
            ),
            const SizedBox(height: 20),
            if (_compatibilidad != null && _sugerencia != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "✅ Compatibilidad: ${(_compatibilidad! * 100).toStringAsFixed(1)}%",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "💡 Sugerencia: $_sugerencia",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            if (_descripcionOutfit != null)
              Column(
                children: _descripcionOutfit!.entries
                    .map((entry) => _buildDescripcion(entry.key, entry.value))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
