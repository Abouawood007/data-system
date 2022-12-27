import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_init.dart';
import '../modles/user_model.dart';

class UpdateScreen extends StatefulWidget {
   Employee data ;
   UpdateScreen({this.data})  ;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
 final TextEditingController _accountNumber = TextEditingController();
 final TextEditingController _salary = TextEditingController();
 final TextEditingController _debt = TextEditingController();

  @override
  initState() {
    super.initState();
    _name.text = widget.data.name;
    _age.text = widget.data.age;
    _accountNumber.text = widget.data.accountNumber;
    _salary.text = widget.data.salary;
    _debt.text = widget.data.debt;
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(body: ListView(
      children: [
        const SizedBox(height: 10),
        TextFormField(
          controller: _name,
          decoration: const InputDecoration(
              filled: true,
              border: InputBorder.none,
              label: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('name'),
              )),
        ),
        const SizedBox(height: 3),
        TextFormField(
          controller: _age,
          decoration: const InputDecoration(
              filled: true,
              border: InputBorder.none,
              label: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Age'),
              )),
        ),
        const SizedBox(height: 3),
        TextFormField(
          controller: _accountNumber,
          decoration: const InputDecoration(
              filled: true,
              border: InputBorder.none,
              label: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Account number'),
              )),
        ),
        const SizedBox(height: 3),
        TextFormField(
          controller: _salary,
          decoration: const InputDecoration(
              filled: true,
              border: InputBorder.none,
              label: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Salary'),
              )),
        ),
        const SizedBox(height: 3),
        TextFormField(
            controller: _debt,
            decoration: const InputDecoration(
                filled: true,
                border: InputBorder.none,
                label: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('debt'),
                ))),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           ElevatedButton(
                onPressed: () async {
                  String name = _name.value.text;
                  String salary = _salary.value.text;
                  String debt = _debt.value.text;
                  String age = _age.value.text;
                  String accountNumber = _accountNumber.value.text;
                  if (name.isNotEmpty &&
                      salary.isNotEmpty &&
                      debt.isNotEmpty &&
                      age.isNotEmpty &&
                      accountNumber.isNotEmpty) {
                    Database database = await DatabaseIntialization.db;
                    await database
                        .rawInsert(
                        "INSERT INTO employees (name, salary, debt, age, accountNumber) VALUES ('$name', '$salary', '$debt', '$age', '$accountNumber')")
                    // ignore: avoid_print
                        .then((value) => print(value));
                    await database
                        .rawQuery("SELECT * FROM employees")
                    // ignore: avoid_print
                        .then((value) => print(value));
                  }
                },
                child: const Text('ADD')),
            ElevatedButton(
                onPressed: () async {}, child: const Text('Cancel'))
          ],
        )
      ],
    ));
  }
}
