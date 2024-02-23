import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:seed/modelo/semeador.dart'; // Importe a classe Semeador
import 'package:seed/visao/analiza_terra.dart'; // Importe a classe AnalizaTerra aqui

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;
  final Semeador semeador; // Novo parâmetro Semeador

  CameraScreen(this.camera, this.semeador); // Atualizado o construtor

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                child: Icon(Icons.camera),
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    final image = await _controller.takePicture();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnalizaTerra(imagePath: image.path, semeador: widget.semeador)), // Passando semeador como parâmetro
                    );
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
