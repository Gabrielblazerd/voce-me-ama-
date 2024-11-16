import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoveQuestionScreen(),
    );
  }
}

class LoveQuestionScreen extends StatefulWidget {
  @override
  _LoveQuestionScreenState createState() => _LoveQuestionScreenState();
}

class _LoveQuestionScreenState extends State<LoveQuestionScreen> {
  double _noButtonPosition = 0.0;
  bool _isMovingRight = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        if (_isMovingRight) {
          _noButtonPosition += 5;
          if (_noButtonPosition >= MediaQuery.of(context).size.width - 100) {
            _isMovingRight = false;
          }
        } else {
          _noButtonPosition -= 5;
          if (_noButtonPosition <= 0) {
            _isMovingRight = true;
          }
        }
      });
    });
  }

  void _showWrongAnswerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resposta Errada'),
        content: Text('Você não pode escolher "não"!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta de Amor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kamilla, você ama o Gabriel?',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Ação para a resposta "sim"
              },
              child: Text('Sim'),
            ),
            Stack(
              children: [
                Positioned(
                  left: _noButtonPosition,
                  child: ElevatedButton(
                    onPressed: _showWrongAnswerDialog,
                    child: Text('Não'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
