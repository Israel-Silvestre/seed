import 'package:flutter/material.dart';
import 'package:seed/modelo/semeador.dart'; // Importe a classe Semeador

class Fases extends StatefulWidget {
  final Semeador semeador; // Semeador selecionado
  final double positionedWidth; // Largura do widget Positioned
  final double positionedHeight; // Altura do widget Positioned
  final double animationBegin; // Valor inicial da animação Tween
  final double animationEnd; // Valor final da animação Tween

  Fases({
    required this.semeador,
    double? positionedWidth,
    double? positionedHeight,
    double? animationBegin,
    double? animationEnd,
  })  : this.positionedWidth = _getPositionedWidth(semeador, positionedWidth),
        this.positionedHeight = _getPositionedHeight(semeador, positionedHeight),
        this.animationBegin = _getAnimationBegin(semeador, animationBegin),
        this.animationEnd = _getAnimationEnd(semeador, animationEnd);

  // Método para calcular a largura do widget Positioned com base no tipo de semeador
  static double _getPositionedWidth(Semeador semeador, double? customWidth) {
    if (customWidth != null) {
      return customWidth;
    }
    if (semeador.id == 1) {
      return 500; // Largura para o semeador1
    }
    if (semeador.id == 2) {
      return 500; // Largura para o semeador1
    }
    if (semeador.id == 3) {
      return 500; // Largura para o semeador1
    }
    if (semeador.id == 4) {
      return 500; // Largura para o semeador1
    }
    return 200; // Largura padrão
  }

  // Método para calcular a altura do widget Positioned com base no tipo de semeador
  static double _getPositionedHeight(Semeador semeador, double? customHeight) {
    if (customHeight != null) {
      return customHeight;
    }
    if (semeador.id == 1) {
      return 250; // Altura para o semeador1
    }
    if (semeador.id == 2) {
      return 200; // Altura para o semeador1
    }
    if (semeador.id == 3) {
      return 200; // Altura para o semeador1
    }
    if (semeador.id == 4) {
      return 240; // Altura para o semeador1
    }
    return 200; // Altura padrão
  }

  // Método para calcular o valor inicial da animação Tween com base no tipo de semeador
  static double _getAnimationBegin(Semeador semeador, double? customBegin) {
    if (customBegin != null) {
      return customBegin;
    }
    if (semeador.id == 1) {
      return -300; // Início para o semeador1
    }
    if (semeador.id == 2) {
      return -300; // Início para o semeador1
    }
    if (semeador.id == 3) {
      return -300; // Início para o semeador1
    }
    if (semeador.id == 4) {
      return -300; // Início para o semeador1
    }
    return -300; // Início padrão
  }

  // Método para calcular o valor final da animação Tween com base no tipo de semeador
  static double _getAnimationEnd(Semeador semeador, double? customEnd) {
    if (customEnd != null) {
      return customEnd;
    }
    if (semeador.id == 1) {
      return -150; // Fim para o semeador1
    }
    if (semeador.id == 2) {
      return -200; // Fim para o semeador1
    }
    if (semeador.id == 3) {
      return -150; // Fim para o semeador1
    }
    if (semeador.id == 4) {
      return -150; // Fim para o semeador1
    }
    return -20; // Fim padrão
  }

  @override
  _FasesState createState() => _FasesState();
}

class _FasesState extends State<Fases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home.png'), // Caminho para a imagem de background
                fit: BoxFit.cover, // Ajuste para cobrir todo o container
              ),
            ),
          ),

          // Imagem do Semeador
          TweenAnimationBuilder<double>(
            duration: Duration(seconds: 3),
            tween: Tween<double>(
              begin: widget.animationBegin, // Inicia a animação com base no tipo de semeador
              end: widget.animationEnd, // Termina a animação com base no tipo de semeador
            ),
            builder: (BuildContext context, double value, Widget? child) {
              return Positioned(
                bottom: 0, // Coloca a imagem no fundo da tela
                left: value, // Controla a posição horizontal da imagem
                child: Image.asset(
                  widget.semeador.imageUrl,
                  width: widget.positionedWidth, // Usa a largura configurável
                  height: widget.positionedHeight, // Usa a altura configurável
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
