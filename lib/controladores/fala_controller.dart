class FalaController {
  final List<String> falas;
  int currentIndex = 0;

  FalaController()
      : falas = [
    'Olá!',
    'Hoje vamos aprender a semear de uma maneira divertida.',
    'Preparado para essa aventura?',
    'Então vamos lá, partiu semear!',
  ];

  String get currentFala => falas[currentIndex];

  void nextFala() {
    currentIndex = (currentIndex + 1) % falas.length;
  }

  void previousFala() {
    currentIndex = (currentIndex - 1 + falas.length) % falas.length;
  }
}
