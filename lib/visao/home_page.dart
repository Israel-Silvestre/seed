import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double logoHeight = 500.0; // Ajustável
  TextEditingController senhaController = TextEditingController();
  String aviso = '';

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

          // Campo de Texto Senha
          Positioned(
            top: 320.0, // Mova mais para baixo
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  width: 300.0, // Ajuste a largura do campo de texto
                  decoration: BoxDecoration(
                    color: Colors.white, // Background branco
                    borderRadius: BorderRadius.circular(8.0), // Borda arredondada
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: senhaController,
                      obscureText: true,
                      style: TextStyle(color: Colors.black), // Texto em preto
                      decoration: InputDecoration(
                        border: InputBorder.none, // Remove a borda padrão
                        hintText: 'Senha',
                        hintStyle: TextStyle(color: Colors.grey[400]), // Cor do texto de dica
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Botão Jogar
          Positioned(
            bottom: 150.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  validarSenha();
                },
                child: Text(
                  'Jogar',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),

          // Aviso
          Positioned(
            bottom: 100.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Text(
                aviso,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validarSenha() {
    String senhaDigitada = senhaController.text.trim();

    if (senhaDigitada == 'eu irei') {
      // Senha correta, navegar para a próxima tela
      Navigator.pushNamed(context, '/escolher-grupo');
    } else {
      // Senha incorreta, exibir um aviso
      setState(() {
        aviso = 'Senha incorreta. Tente novamente.';
      });
    }
  }

  @override
  void dispose() {
    senhaController.dispose();
    super.dispose();
  }
}
