import 'package:flutter/material.dart';
import 'expenses.dart';

final vvk_image =
    "https://static.vecteezy.com/system/resources/previews/009/146/852/original/vvk-logo-vvk-letter-vvk-letter-logo-design-initials-vvk-logo-linked-with-circle-and-uppercase-monogram-logo-vvk-typography-for-technology-business-and-real-estate-brand-vector.jpg";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
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
        title: Center(child: Text('App Bulider')),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(vvk_image),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Expenses()),
              );
            },
            child: Text('Go to App'),
          ),
        ],
      ),
    );
  }
}
