import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:seed/visao/lancar_semente.dart'; // Importe a classe Launch aqui

class VideoScreen extends StatefulWidget {
  final String videoPath;

  const VideoScreen({required this.videoPath});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _showSkipText = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            _navigateToLaunch(); // Substitua a chamada para NovaTela pela função _navigateToLaunch
          }
        });
      });
    // Exibir o texto "Pular" após 5 segundos
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _showSkipText = true;
      });
    });
    // Ocultar o texto "Pular" após 3 segundos de inatividade
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _showSkipText = false;
      });
      timer.cancel();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _navigateToLaunch() {
    // Pausa o vídeo antes de navegar para a nova tela
    _controller.pause();

    // Configura a orientação de volta para retrato (vertical)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Navega para a nova tela
    Launch.navigate(
      context,
      'assets/images/background.png', // Defina o caminho da imagem de fundo da tela Launch
          (String imagePath) {
        // Aqui você pode tratar a foto tirada
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return Container(
              child: Stack(
                children: [
                  Center(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : CircularProgressIndicator(),
                  ),
                  AnimatedOpacity(
                    opacity: _showSkipText ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          _navigateToLaunch(); // Substitua a chamada para NovaTela pela função _navigateToLaunch
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Pular',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
