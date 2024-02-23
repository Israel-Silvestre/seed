import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seed/modelo/semeador.dart';
import 'package:seed/visao/video.dart'; // Importe a classe VideoScreen

class AnalizaTerra extends StatefulWidget {
  final Semeador semeador;
  final String imagePath;

  AnalizaTerra({required this.semeador, required this.imagePath});

  @override
  _AnalizaTerraState createState() => _AnalizaTerraState();
}

class _AnalizaTerraState extends State<AnalizaTerra> {
  @override
  Widget build(BuildContext context) {
    // Verifica se o índice atual está dentro dos limites da lista de terras do semeador
    if (widget.semeador.indice < widget.semeador.tiposTerra.length) {
      Terra tipoTerra = widget.semeador.tiposTerra[widget.semeador.indice];
      String videoPath = '';

      // Determina o caminho do vídeo com base no tipo de terra atual
      switch (tipoTerra) {
        case Terra.boa:
          videoPath = 'assets/resultados/boa.mp4'; // Caminho do vídeo correspondente à terra boa
          break;
        case Terra.beiraDoCaminho:
          videoPath = 'assets/resultados/beiradocaminho.mp4'; // Caminho do vídeo correspondente à terra beira do caminho
          break;
        case Terra.espinhos:
          videoPath = 'assets/resultados/espinhais.mp4'; // Caminho do vídeo correspondente à terra com espinhos
          break;
        case Terra.pedregais:
          videoPath = 'assets/resultados/pedregais.mp4'; // Caminho do vídeo correspondente à terra com pedregais
          break;
      }

      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(widget.imagePath), // Usando o caminho da imagem diretamente
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Incrementa o índice do semeador
                    widget.semeador.setIndice(widget.semeador.indice + 1);

                    // Navega para a tela de vídeo
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoScreen(videoPath: videoPath, semeador: widget.semeador)),
                    );
                  },
                  child: Text('Continuar'),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Se o índice estiver além dos limites da lista de terras do semeador
      return Scaffold(
        body: Container(
          color: Colors.black, // Define uma cor de fundo preta
          child: Center(
            child: Text(
              'Todas as terras foram analisadas',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }
}
