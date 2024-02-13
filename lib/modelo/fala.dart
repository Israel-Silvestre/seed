import 'package:flutter/material.dart';

class Balaodefala extends StatefulWidget {
  final double transparencia;

  const Balaodefala({Key? key, this.transparencia = 0.5}) : super(key: key);

  @override
  _BalaodefalaState createState() => _BalaodefalaState();
}

class _BalaodefalaState extends State<Balaodefala> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  List<String> _mensagens = [
    "Olá, eu sou uma mensagem.",
    "Estou animado!",
    "Clique em mim para ver mais.",
  ];
  int _indice = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _mensagens[_indice].length * 100), // Ajuste a duração baseada no comprimento do texto inicial
    );
    _animation = IntTween(begin: 0, end: _mensagens[_indice].length).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _trocarMensagem() {
    setState(() {
      _indice = (_indice + 1) % _mensagens.length;
      _controller.duration = Duration(milliseconds: _mensagens[_indice].length * 100); // Atualize a duração da animação com base no novo texto
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _trocarMensagem,
      child: Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.black.withOpacity(widget.transparencia), // Definindo a transparência da cor preta
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final text = _mensagens[_indice].substring(0, _animation.value);
              return Text(
                text,
                style: TextStyle(color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}
