import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:seed/modelo/semeador.dart'; // Importe a classe Semeador
import 'package:seed/modelo/camera.dart';

class Launch extends StatefulWidget {
  final String backgroundImage;
  final Function(String) onPhotoTaken;
  final Semeador semeador; // Novo parâmetro Semeador

  const Launch({
    required this.backgroundImage,
    required this.onPhotoTaken,
    required this.semeador, // Adicionando semeador ao construtor
  });

  static void navigate(BuildContext context, String backgroundImage, Function(String) onPhotoTaken, Semeador semeador) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Launch(backgroundImage: backgroundImage, onPhotoTaken: onPhotoTaken, semeador: semeador)), // Passando semeador como parâmetro
    );
  }

  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  late String _currentBackgroundImage;
  String? _capturedImage;

  @override
  void initState() {
    super.initState();
    _currentBackgroundImage = widget.backgroundImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackgroundImage(),
          if (_capturedImage != null) _buildCapturedImage(),
          Center(
            child: ElevatedButton(
              onPressed: () => _openCamera(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('Escanear Terra', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      _currentBackgroundImage,
      fit: BoxFit.cover,
    );
  }

  Widget _buildCapturedImage() {
    return Image.file(
      File(_capturedImage!),
      fit: BoxFit.cover,
    );
  }

  Future<void> _openCamera(BuildContext context) async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen(camera, widget.semeador)), // Passando semeador como parâmetro
    );

    if (result != null) {
      setState(() {
        _capturedImage = result;
      });
      widget.onPhotoTaken(result);
    }
  }
}
