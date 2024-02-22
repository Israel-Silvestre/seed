import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Launch extends StatefulWidget {
  final String backgroundImage;
  final Function(String) onPhotoTaken;

  const Launch({
    required this.backgroundImage,
    required this.onPhotoTaken,
  });

  static void navigate(BuildContext context, String backgroundImage, Function(String) onPhotoTaken) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Launch(backgroundImage: backgroundImage, onPhotoTaken: onPhotoTaken)),
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
              child: Text('Tirar Foto', style: TextStyle(color: Colors.white)),
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
      MaterialPageRoute(builder: (context) => CameraScreen(camera)),
    );

    if (result != null) {
      setState(() {
        _capturedImage = result;
      });
      widget.onPhotoTaken(result);
    }
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  CameraScreen(this.camera);

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
      appBar: AppBar(title: Text('Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            Navigator.pop(context, image.path);
          } catch (e) {
            print(e);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
