import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final _textcontroller = TextEditingController();
  bool _isloading = false;
  List<String> item = [];

  Future<List<dynamic>> get_data(String word) async {
    String apiKey = "b3b73004-8412-455e-a40a-2cfb3d87e9ee";
    Uri url = Uri.https('www.dictionaryapi.com',
        '/api/v3/references/thesaurus/json/$word', {'key': apiKey});
    var resp = await http.get(url);
    var dec_resp = json.decode(resp.body);
    return dec_resp;
  }

  void getSynonym() async {
    setState(() {
      _isloading = true;
    });
    String word = _textcontroller.text.toString();
    var val = await get_data(word);
    setState(() {
      _isloading = false;
      item = List<String>.from(val[0]["meta"]["syns"][0]);
    });
  }

  void getAntonym() async {
    setState(() {
      _isloading = true;
    });
    String word = _textcontroller.text.toString();
    var val = await get_data(word);
    setState(() {
      _isloading = false;
      item = List<String>.from(val[0]["meta"]["ants"][0]);
    });
  }

  void getDefinition() async {
    setState(() {
      _isloading = true;
    });
    String word = _textcontroller.text.toString();
    var val = await get_data(word);
    setState(() {
      _isloading = false;
      item = [val[0]["def"][0]["sseq"][0][0][1]["dt"][0][1]];
    });
  }

  void getSentence() async {
    setState(() {
      _isloading = true;
    });
    String word = _textcontroller.text.toString();
    var val = await get_data(word);
    setState(() {
      // item = List<String>.from(val[0]["def"][0]["sseq"][0][0][1]["dt"][1][1][0]["t"]);
      _isloading = false;
      String sen = val[0]["def"][0]["sseq"][0][0][1]["dt"][1][1][0]["t"];
      item = [sen];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Dictionary",
          ),
          backgroundColor: Colors.orangeAccent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: TextField(
                controller: _textcontroller,
                decoration: InputDecoration(
                  labelText: "Enter your word",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: getSynonym, child: Text("Get Synonyms ")),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(onPressed: getAntonym, child: Text("Get Antonyms ")),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: getDefinition, child: Text("Get Definition")),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: getSentence, child: Text("Get Sentence ")),
            SizedBox(
              height: 5,
            ),
            if (_isloading)
              Center(
                child: CircularProgressIndicator(),
              ),
            if (item.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          item[index],
                          style: TextStyle(fontSize: 20),
                        ));
                  },
                ),
              ),
          ],
        ));
  }
}
