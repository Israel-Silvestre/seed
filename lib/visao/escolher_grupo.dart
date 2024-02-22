import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'fases.dart'; // Importe a tela de fases
import 'package:seed/modelo/semeador.dart'; // Importe a classe Semeador

class EscolhaGrupo extends StatefulWidget {
  final List<Semeador> semeadores; // Lista de semeadores

  EscolhaGrupo({required this.semeadores}); // Construtor

  @override
  _EscolhaGrupoState createState() => _EscolhaGrupoState();
}

class _EscolhaGrupoState extends State<EscolhaGrupo> {
  int _grupoSelecionado = 0; // Índice do semeador selecionado

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

          // Título
          Positioned(
            top: 50.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Text(
                'Escolha seu Grupo',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Carrossel de Imagens
          Positioned(
            top: 120.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Column(
                children: [
                  CarouselWidget(
                    semeadores: widget.semeadores, // Passando a lista de semeadores
                    onSemeadorSelected: (index) {
                      setState(() {
                        _grupoSelecionado = index; // Atualizando o semeador selecionado
                        // Navegar para a tela de fases e passar o semeador selecionado
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Fases(semeador: widget.semeadores[_grupoSelecionado])),
                        );
                      });
                    },
                    onCardChanged: (index) {
                      setState(() {
                        _grupoSelecionado = index; // Atualiza o semeador selecionado conforme o card em evidência no carrossel
                      });
                    },
                  ),

                  // Título abaixo do CarouselWidget
                  Text(
                    widget.semeadores[_grupoSelecionado].nome, // Exibe o atributo "nome" do semeador selecionado
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Carrossel
class CarouselWidget extends StatelessWidget {
  final List<Semeador> semeadores; // Lista de semeadores
  final double imageHeight;
  final double itemPadding;
  final ValueChanged<int> onSemeadorSelected; // Evento para quando um semeador for selecionado
  final ValueChanged<int> onCardChanged; // Evento para quando o card em evidência mudar

  const CarouselWidget({
    Key? key,
    required this.semeadores,
    required this.onSemeadorSelected,
    required this.onCardChanged,
    this.imageHeight = 400.0, // Altura padrão da imagem
    this.itemPadding = 3.0, // Espaçamento padrão entre os itens
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: semeadores.map((semeador) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: itemPadding),
              child: Container(
                height: imageHeight,
                width: MediaQuery.of(context).size.width, // Largura igual à largura da tela
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: GestureDetector(
                    onTap: () {
                      // Notificar que um semeador foi selecionado
                      onSemeadorSelected(semeadores.indexOf(semeador));
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        semeador.cardUrl, // Usando cardUrl como imagem
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: imageHeight,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          onCardChanged(index); // Notificar quando o card em evidência mudar
        },
      ),
    );
  }
}
