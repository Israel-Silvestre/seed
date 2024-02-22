enum Terra { boa, beiraDoCaminho, espinhos, pedregais }

class Semeador {
  final int id;
  final String nome;
  final String imageUrl;
  final String cardUrl; // Novo atributo
  List<Terra> tiposTerra = [];

  Semeador({required this.id,required this.nome, required this.imageUrl, required this.cardUrl, required this.tiposTerra});
}
