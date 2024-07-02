// import 'package:ffi/ffi.dart';

import 'package:flutter/material.dart';

class calci extends StatefulWidget {
  const calci({Key? key}) : super(key: key);

  @override
  State<calci> createState() => _calciState();
}

class _calciState extends State<calci> {
  final TextEditingController _textcontroller = TextEditingController();
  double value_to_display = 0;
  bool isDigit(String c) {
    int ascii = c.codeUnitAt(0);
    if (ascii >= 48 && ascii <= 57) return true;
    return false;
  }

  double findValue(String expression) {
    int n = expression.length;
    List<double> stack = [];
    String last_sign = '+';
    int cur_dig = 0;
    for (int i = 0; i < n; i++) {
      if (isDigit(expression[i])) {
        cur_dig = cur_dig * 10 + int.parse(expression[i]);
      } else if ((!isDigit(expression[i]) && expression[i] != ' ')) {
        if (last_sign == "+") {
          stack.add(cur_dig.toDouble());
        } else if (last_sign == "-") {
          stack.add(-cur_dig.toDouble());
        } else if (last_sign == "*") {
          double temp = stack.removeLast();
          stack.add(temp * cur_dig);
        } else if (last_sign == '/') {
          double temp = stack.removeLast();
          stack.add(temp / cur_dig);
        }
        last_sign = expression[i];
        cur_dig = 0;
      }
    }
    //adding the last digit
    if (last_sign == "+") {
      stack.add(cur_dig.toDouble());
    } else if (last_sign == "-") {
      stack.add(-cur_dig.toDouble());
    } else if (last_sign == "*") {
      double temp = stack.removeLast();
      stack.add(temp * cur_dig);
    } else if (last_sign == '/') {
      double temp = stack.removeLast();
      stack.add(temp / cur_dig);
    }
    double ans = 0;
    // print(stack);
    // print(last_sign);
    while (stack.isNotEmpty) {
      // print(ans);
      ans += stack.removeLast();
    }
    // print("ans printing done");
    return ans;
  }

  void calculate() {
    // print("calculate called");
    String expression = _textcontroller.text;
    double val = findValue(expression);
    // print(val);
    setState(() {
      value_to_display = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10.0), // Example radius value
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: _textcontroller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // decoration: InputDecoration(
                //   labelText: value_to_display.toString(),
                // ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("="),
              onPressed: calculate,
            ),
            SizedBox(
              height: 20,
            ),
            if (value_to_display != 0)
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10.0), // Example radius value
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                padding: EdgeInsets.all(10.0), // Example padding value
                child: Text(
                  value_to_display.toString(),
                  style: TextStyle(fontSize: 18.0), // Example font size
                ),
              ),
          ],
        ));
  }
}
