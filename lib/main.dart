import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pergunta para Kamilla',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: QuestionScreen(),
    );
  }
}

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  double _buttonNoPosX = 100;
  double _buttonNoPosY = 200;
  double _dx = 5; // Velocidade horizontal
  double _dy = 5; // Velocidade vertical
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startMovingButton();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Função para iniciar o movimento do botão "Não"
  void _startMovingButton() {
    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        _updateButtonPosition();
      });
    });
  }

  // Função para atualizar a posição do botão e inverter a direção nas bordas
  void _updateButtonPosition() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonWidth = 100.0; // Largura do botão
    final buttonHeight = 50.0; // Altura do botão

    // Atualiza a posição do botão
    _buttonNoPosX += _dx;
    _buttonNoPosY += _dy;

    // Verifica colisão com as bordas horizontais
    if (_buttonNoPosX <= 0 || _buttonNoPosX + buttonWidth >= screenWidth) {
      _dx = -_dx; // Inverte a direção horizontal
    }

    // Verifica colisão com as bordas verticais
    if (_buttonNoPosY <= 0 || _buttonNoPosY + buttonHeight >= screenHeight) {
      _dy = -_dy; // Inverte a direção vertical
    }
  }

  // Função para mostrar a resposta
  void showResponse(BuildContext context, String answer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Resposta"),
          content: Text("Kamilla disse: $answer!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta para Kamilla'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        // Plano de fundo com corações feitos com widgets simples
        decoration: BoxDecoration(
          color: Colors.pink[50], // Cor de fundo rosa claro
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Padrão de corações flutuantes no fundo
              Positioned(
                left: 20,
                top: 50,
                child: Icon(
                  Icons.favorite,
                  size: 80,
                  color: Colors.pink[200],
                ),
              ),
              Positioned(
                right: 40,
                top: 150,
                child: Icon(
                  Icons.favorite,
                  size: 60,
                  color: Colors.pink[300],
                ),
              ),
              Positioned(
                left: 100,
                top: 250,
                child: Icon(
                  Icons.favorite,
                  size: 100,
                  color: Colors.pink[100],
                ),
              ),
              Positioned(
                right: 60,
                bottom: 80,
                child: Icon(
                  Icons.favorite,
                  size: 90,
                  color: Colors.pink[400],
                ),
              ),
              Positioned(
                left: 200,
                bottom: 150,
                child: Icon(
                  Icons.favorite,
                  size: 70,
                  color: Colors.pink[300],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kamilla, você ama o Gabriel?",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    // Botão Sim com corações
                    ElevatedButton(
                      onPressed: () => showResponse(context, "Sim 💖🤍"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text("💖 Sim 💖"),
                    ),
                  ],
                ),
              ),
              // Botão Não que se move e "colide" com as bordas
              Positioned(
                left: _buttonNoPosX,
                top: _buttonNoPosY,
                child: ElevatedButton(
                  onPressed: () {}, // Ação de clique não é necessária aqui
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text("❌ Não ❌"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
