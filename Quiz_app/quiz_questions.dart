import 'package:flutter/material.dart';

class Second extends StatefulWidget {
  const Second({Key? key, required this.text}) : super(key: key);
  final Widget text;

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  int i = 0;
  int score = 0;
  List<String> ques = ['q1', 'q2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("questions")),
      body: Center(
        child: i < ques.length
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(ques[i]),
                  btn('A', true),
                  btn('B', false),
                ],
              )
            : Text('Your score: $score'),
      ),
    );
  }

  Widget btn(String text, bool check) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (check) {
            score++;
          }
          if (i < ques.length - 1) {
            i++;
          } else {
            i++; // This ensures the display changes to the score after the last question
          }
        });
      },
      child: Text(text),
    );
  }
}
