import 'package:seed/modelo/semeador.dart';

class SemeadorController {
  // Método para criar os semeadores
  List<Semeador> criarSemeadores() {
    return [
      Semeador(
        id: 1,
        nome: "Pedro",
        imageUrl: 'assets/personagens/semeador1.png',
        cardUrl: 'assets/cards/card1.png', // Adicionando cardUrl
        tiposTerra: [Terra.espinhos, Terra.pedregais, Terra.beiraDoCaminho, Terra.boa],
      ),
      Semeador(
        id: 2,
        nome: "Matheus",
        imageUrl: 'assets/personagens/semeador2.png',
        cardUrl: 'assets/cards/card2.png', // Adicionando cardUrl
        tiposTerra: [Terra.pedregais, Terra.espinhos, Terra.boa, Terra.beiraDoCaminho],
      ),
      Semeador(
        id: 3,
        nome: "Paulo",
        imageUrl: 'assets/personagens/semeador3.png',
        cardUrl: 'assets/cards/card3.png', // Adicionando cardUrl
        tiposTerra: [Terra.beiraDoCaminho, Terra.boa, Terra.espinhos, Terra.pedregais],
      ),
      Semeador(
        id: 4,
        nome:"João",
        imageUrl: 'assets/personagens/semeador4.png',
        cardUrl: 'assets/cards/card4.png', // Adicionando cardUrl
        tiposTerra: [Terra.boa, Terra.beiraDoCaminho, Terra.pedregais, Terra.espinhos],
      ),
    ];
  }
}
