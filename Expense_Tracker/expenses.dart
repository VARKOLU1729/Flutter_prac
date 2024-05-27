import 'package:flutter/material.dart';

class Expense {
  const Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.cat});
  final String title;
  final double amount;
  final DateTime date;
  final String cat;
}

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _myexpenses = [
    Expense(title: 'Flutter', amount: 20, date: DateTime.now(), cat: 'work'),
    Expense(title: 'biksha', amount: 21, date: DateTime.now(), cat: 'eat')
  ];

  final _titlectrl = TextEditingController();
  final _pricectrl = TextEditingController();
  final _datectrl = TextEditingController();
  final _catctrl = TextEditingController();

  @override
  void dispose() {
    _titlectrl.dispose();
    _pricectrl.dispose();
    _datectrl.dispose();
    _catctrl.dispose();
    super.dispose();
  }

  void _saveExpense() {
    var t = Expense(
        title: _titlectrl.text,
        amount: double.parse(_pricectrl.text),
        date: DateTime.parse(_datectrl.text),
        cat: _catctrl.text);
    print(t.date);
    setState(() {
      _myexpenses.add(t);
    });
    Navigator.of(context).pop();
  }

  void _pickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // final lastDate = DateTime(now.year+1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    if (pickedDate != null) {
      setState(() {
        _datectrl.text = pickedDate.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                          children: [
                            TextField(
                              controller: _titlectrl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                label: Text("Title"),
                              ),
                            ),
                            TextField(
                              controller: _pricectrl,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label: Text("Amount"),
                              ),
                            ),
                            TextField(
                              controller: _datectrl,
                              onTap: _pickDate,
                              decoration: InputDecoration(
                                label: Text("Date"),
                              ),
                            ),
                            TextField(
                              controller: _catctrl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                label: Text("Cat"),
                              ),
                            ),
                            TextButton(
                                onPressed: _saveExpense,
                                child: Text("Save expense"))
                          ],
                        ));
              },
              icon: Icon(Icons.add),
              color: Colors.green)
        ],
      ),
      body: ListView.builder(
          itemCount: _myexpenses.length,
          itemBuilder: (context, index) => Card(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(_myexpenses[index].title),
                  Text(_myexpenses[index].amount.toString()),
                  Text(_myexpenses[index].date.toString()),
                  Text(_myexpenses[index].cat),
                  SizedBox(
                    height: 20,
                  )
                ]),
              )),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // Add intl package to pubspec.yaml

// class Expense {
//   const Expense({
//     required this.title,
//     required this.amount,
//     required this.date,
//     required this.cat,
//   });
//   final String title;
//   final double amount;
//   final DateTime date;
//   final String cat;
// }

// class Expenses extends StatefulWidget {
//   const Expenses({Key? key}) : super(key: key);

//   @override
//   State<Expenses> createState() => _ExpensesState();
// }

// class _ExpensesState extends State<Expenses> {
//   final List<Expense> _myexpenses = [
//     Expense(title: 'Flutter', amount: 20, date: DateTime.now(), cat: 'work'),
//     Expense(title: 'biksha', amount: 21, date: DateTime.now(), cat: 'eat'),
//   ];

//   final _titlectrl = TextEditingController();
//   final _pricectrl = TextEditingController();
//   final _datectrl = TextEditingController();
//   final _catctrl = TextEditingController();

//   @override
//   void dispose() {
//     _titlectrl.dispose();
//     _pricectrl.dispose();
//     _datectrl.dispose();
//     _catctrl.dispose();
//     super.dispose();
//   }

//   void _saveExpense() {
//     if (_titlectrl.text.isEmpty ||
//         _pricectrl.text.isEmpty ||
//         _datectrl.text.isEmpty ||
//         _catctrl.text.isEmpty) {
//       return; // Basic validation
//     }

//     var t = Expense(
//       title: _titlectrl.text,
//       amount: double.parse(_pricectrl.text),
//       date: DateTime.parse(_datectrl.text),
//       cat: _catctrl.text,
//     );

//     setState(() {
//       _myexpenses.add(t);
//     });

//     // Clear the text fields after saving
//     _titlectrl.clear();
//     _pricectrl.clear();
//     _datectrl.clear();
//     _catctrl.clear();

//     Navigator.of(context).pop(); // Close the modal sheet
//   }

//   void _presentDatePicker() {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2101),
//     ).then((pickedDate) {
//       if (pickedDate == null) {
//         return;
//       }
//       setState(() {
//         _datectrl.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expense Tracker'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) => Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextField(
//                         controller: _titlectrl,
//                         decoration: InputDecoration(labelText: 'Title'),
//                       ),
//                       TextField(
//                         controller: _pricectrl,
//                         decoration: InputDecoration(labelText: 'Amount'),
//                         keyboardType: TextInputType.number,
//                       ),
//                       TextField(
//                         controller: _datectrl,
//                         decoration: InputDecoration(labelText: 'Date'),
//                         readOnly: true,
//                         onTap: _presentDatePicker,
//                       ),
//                       TextField(
//                         controller: _catctrl,
//                         decoration: InputDecoration(labelText: 'Category'),
//                       ),
//                       ElevatedButton(
//                         onPressed: _saveExpense,
//                         child: Text('Save Expense'),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//             icon: Icon(Icons.add),
//             color: Colors.green,
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _myexpenses.length,
//         itemBuilder: (context, index) => Card(
//           child: ListTile(
//             title: Text(_myexpenses[index].title),
//             subtitle: Text(
//                 '${_myexpenses[index].cat} - ${DateFormat.yMMMd().format(_myexpenses[index].date)}'),
//             trailing: Text('\$${_myexpenses[index].amount.toStringAsFixed(2)}'),
//           ),
//         ),
//       ),
//     );
//   }
// }
