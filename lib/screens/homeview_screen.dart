import 'package:datasystem/database/database_init.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'read_screens.dart';

class HomeView extends StatelessWidget {
  HomeView({Key key}) : super(key: key);
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _accountNumber = TextEditingController();
  final _salary = TextEditingController();
  final _debt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('employee',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          actions: [
            InkWell(
                onTap: () async {
                  Database database = await DatabaseIntialization.db;
                  await database.rawQuery("DELETE FROM employees");
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.delete),
                ))
          ],
        ),
        drawer: SafeArea(
            child: Drawer(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Reading()),
                      );
                    },
                    child: ListView(children: const [
                      Card(
                        color: Colors.white60,
                        child: ListTile(
                            title: Text(
                          'Employees data',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ])))),
        body: ListView(
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
