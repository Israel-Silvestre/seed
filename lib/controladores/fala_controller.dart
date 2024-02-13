import 'package:flutter/material.dart';

class FalaController {
  final List<String> falas;
  int currentIndex = 0;

  FalaController()
      : falas = [
    'Olá!',
    'Como vai?',
    'Estou bem, obrigado!',
    'Qual é o seu nome?',
    'Me conte sobre o seu dia.',
    'Tenha um bom dia!',
  ];

  String get currentFala => falas[currentIndex];

  void nextFala() {
    currentIndex = (currentIndex + 1) % falas.length;
  }

  void previousFala() {
    currentIndex = (currentIndex - 1 + falas.length) % falas.length;
  }
}
