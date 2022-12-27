import 'package:datasystem/database/database_init.dart';
import 'package:datasystem/modles/user_model.dart';
import 'package:datasystem/screens/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class Reading extends StatefulWidget {
  const Reading({Key key}) : super(key: key);

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  @override
   initState() {
  getData();
    super.initState();
  }

  List<Employee> data = [];

  getData() async {
    Database database = await DatabaseIntialization.db;
    await database.rawQuery("SELECT * FROM employees").then((value) {
      for (int i = 0; i < value.length; i++) {
        data.add(Employee.fromJson(value[i]));
      }
    });
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Emolyees'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index)
        {
          return InkWell(onTap: (){

        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) =>  UpdateScreen(data:data[index] )),
        );
          },
            child: Card(
              child: ListTile(
                title: Text(data[index].name),
                trailing: Text('Salary:${data[index].salary}'),
                subtitle: Text('accNumber:${data[index].accountNumber}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
