import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double logoHeight = 500.0; // Ajustável

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),

          // Logo
          Positioned(
            top: -30.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: logoHeight, // Use a variável
              ),
            ),
          ),

          // Botão Jogar
          Positioned(
            bottom: 100.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navegar para a tela de Escolha do Grupo
                  Navigator.pushNamed(context, '/escolher-grupo');
                },
                child: Text(
                  'Jogar',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
