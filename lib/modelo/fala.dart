import 'dart:async';
import 'package:flutter/material.dart';
import 'package:seed/controladores/fala_controller.dart';

class Balaodefala extends StatefulWidget {
  final FalaController controller;
  final double transparencia;
  final int typingSpeed; // Velocidade de digitação em milissegundos

  const Balaodefala({Key? key, required this.controller, this.transparencia = 0.5, this.typingSpeed = 10}) : super(key: key);

  @override
  _BalaodefalaState createState() => _BalaodefalaState();
}

class _BalaodefalaState extends State<Balaodefala> {
  late String _currentFala;
  late int _currentIndex;
  late Timer _timer;
  late String _displayedText;

  @override
  void initState() {
    super.initState();
    _currentFala = '';
    _currentIndex = 0;
    _displayedText = '';
    _startTyping();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTyping() {
    _timer = Timer.periodic(Duration(milliseconds: widget.typingSpeed), (timer) {
      setState(() {
        _displayedText = widget.controller.currentFala.substring(0, _currentIndex + 1);
        if (_currentIndex < widget.controller.currentFala.length - 1) {
          _currentIndex++;
        } else {
          _timer.cancel();
        }
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
            _currentIndex = 0;
            _displayedText = '';
            widget.controller.nextFala();
            _startTyping();
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
}
