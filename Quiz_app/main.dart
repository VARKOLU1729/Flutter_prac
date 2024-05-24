import 'package:flutter/material.dart';
import 'quiz_app.dart';

void main() {
  runApp(MaterialApp(
    home: First(),
  ));
}

class First extends StatefulWidget {
  First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Page-1')),
        backgroundColor: Colors.red,
      ),
      body: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Second(text: Text('Passed from first'))),
          );
        },
        child: Text('Press me'),
      ),
    );
  }
}
