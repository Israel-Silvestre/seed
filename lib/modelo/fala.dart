import 'package:flutter/material.dart';
import 'package:seed/controladores/fala_controller.dart';
import 'package:seed/visao/video.dart'; // Importe a tela do vídeo aqui

class Balaodefala extends StatefulWidget {
  final FalaController controller;
  final double transparencia;
  final int typingSpeed; // Velocidade de digitação em milissegundos

  const Balaodefala({Key? key, required this.controller, this.transparencia = 0.5, this.typingSpeed = 800}) : super(key: key);

  @override
  _BalaodefalaState createState() => _BalaodefalaState();
}

class _BalaodefalaState extends State<Balaodefala> {
  late String _displayedText;

  @override
  void initState() {
    super.initState();
    _displayedText = '';
    _startTyping();
  }

  void _startTyping() {
    Future.delayed(Duration(milliseconds: widget.typingSpeed), () {
      setState(() {
        _displayedText = widget.controller.currentFala;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (widget.controller.currentIndex == widget.controller.falas.length - 1) {
              // Se for a última fala, navegue para a nova tela
              _navigateToNewScreen();
            } else {
              // Avance para a próxima fala
              widget.controller.nextFala();
              _displayedText = widget.controller.currentFala;
            }
          });
        },
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.black.withOpacity(widget.transparencia),
          child: Text(
            _displayedText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // Método para navegar para a nova tela
  void _navigateToNewScreen() {
    // Use o Navigator para navegar para a nova tela
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoScreen(videoPath: "assets/video/trailer.mp4",)), // Substitua 'NovaTelaVideo()' pela sua nova tela
    );
  }
}
