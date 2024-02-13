import 'package:flutter/material.dart';
import 'package:seed/modelo/semeador.dart';
import 'package:seed/modelo/fala.dart'; // Importe o widget BalaoDeFala

class Fases extends StatefulWidget {
  final Semeador semeador; // Semeador selecionado
  final double positionedWidth; // Largura do widget Positioned
  final double positionedHeight; // Altura do widget Positioned
  final double animationBegin; // Valor inicial da animação Tween
  final double animationEnd; // Valor final da animação Tween
  final double balaoHeight; // Altura do balão

  Fases({
    required this.semeador,
    double? positionedWidth,
    double? positionedHeight,
    double? animationBegin,
    double? animationEnd,
    double? balaoHeight, // Adicionando a altura do balão
  })  : this.positionedWidth = positionedWidth ?? _getPositionedWidth(semeador),
        this.positionedHeight = positionedHeight ?? _getPositionedHeight(semeador),
        this.animationBegin = animationBegin ?? _getAnimationBegin(semeador),
        this.animationEnd = animationEnd ?? _getAnimationEnd(semeador),
        this.balaoHeight = balaoHeight ?? 80; // Valor padrão de altura do balão

  static double _getPositionedWidth(Semeador semeador) {
    return [1, 2, 3, 4].contains(semeador.id) ? 500 : 200; // Largura para o semeador1, semeador2, semeador3 ou semeador4
  }

  static double _getPositionedHeight(Semeador semeador) {
    if (semeador.id == 1) {
      return 250; // Altura para o semeador1
    } else if ([2, 3].contains(semeador.id)) {
      return 200; // Altura para o semeador2 ou semeador3
    } else if (semeador.id == 4) {
      return 240; // Altura para o semeador4
    }
    return 200; // Altura padrão
  }

  static double _getAnimationBegin(Semeador semeador) {
    return -300; // Valor inicial padrão da animação
  }

  static double _getAnimationEnd(Semeador semeador) {
    if (semeador.id == 1) {
      return -150; // Fim para o semeador1
    } else if ([2, 3].contains(semeador.id)) {
      return -200; // Fim para o semeador2 ou semeador3
    } else if (semeador.id == 4) {
      return -150; // Fim para o semeador4
    }
    return -20; // Fim padrão
  }

  @override
  _FasesState createState() => _FasesState();
}

class _FasesState extends State<Fases> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _showBalao = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _controller.forward().whenComplete(() {
      setState(() {
        _showBalao = true;
      });
    });
  }

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
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: 0, // Coloca a imagem no fundo da tela
                left: Tween<double>(
                  begin: widget.animationBegin,
                  end: widget.animationEnd,
                ).animate(_controller).value,
                child: child!,
              );
            },
            child: Image.asset(
              widget.semeador.imageUrl,
              width: widget.positionedWidth, // Usa a largura configurável
              height: widget.positionedHeight, // Usa a altura configurável
            ),
          ),

          // Balão de Fala
          if (_showBalao)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: widget.balaoHeight, // Use a altura fornecida
                padding: EdgeInsets.all(16),
                color: Colors.black.withOpacity(0.4), // Define a transparência do preto
                child: Text(
                  'Olá! meu nome é israel.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
