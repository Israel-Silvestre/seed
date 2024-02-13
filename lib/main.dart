import 'package:flutter/material.dart';
import 'package:seed/visao/home_page.dart';
import 'package:seed/visao/escolher_grupo.dart';
import 'package:seed/controladores/semeador_controller.dart'; // Importe o controlador de semeadores
import 'package:seed/modelo/semeador.dart'; // Importe a classe Semeador

void main() {
  SemeadorController semeadorController = SemeadorController(); // Instância do controlador de semeadores
  List<Semeador> semeadores = semeadorController.criarSemeadores(); // Lista de semeadores

  runApp(MyApp(semeadores: semeadores)); // Passa a lista de semeadores para o aplicativo
}

class MyApp extends StatelessWidget {
  final List<Semeador> semeadores; // Lista de semeadores

  const MyApp({required this.semeadores}); // Construtor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parábola do Semeador',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      routes: {
        '/escolher-grupo': (context) => EscolhaGrupo(semeadores: semeadores), // Passa a lista de semeadores para a tela de escolha de grupo
      },
    );
  }
}
