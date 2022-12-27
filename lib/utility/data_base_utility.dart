import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../modles/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    String path = join(await getDatabasesPath(), "UserData.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        ''' CREATE TABLE $tableEmployee($columnId INTEGER PRIMARY KEY ,
         $columnName TEXT  , $columnAge TEXT  ,
          $columnAccountNumber TEXT , $columnSalary TEXT ,
           $columnDebt TEXT)''');
  }

  Future<void> insertEmployee(Employee employee) async {
    var dbCartProduct = await db;
    await dbCartProduct.insert("employee", employee.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateEmployee(Employee employee) async {
    var dbCartProduct = await db;
    await dbCartProduct.update("employee", employee.toJson(),
        where: '$columnId=?', whereArgs: [employee.id]);
  }

  Future<Employee> getEmployee(int id) async {
    var employee = await db;
    List<Map> maps =
        await employee.query("employee", where: '$columnId=?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Employee.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Employee>> getAllEmployee() async {
    List<Employee> data = [];
    var employees = await db;
    var result = await employees.query("employee");
    for (var element in result) {
      data.add(Employee.fromJson(element));
    }
    return data;
  }

  Future<void> deleteEmployee(int id) async {
    var dbCartProduct = await db;
    await dbCartProduct
        .delete("employee", where: '$columnId=?', whereArgs: [id]);
  }

// Future<int> getCount() async {
//   var dbCartProduct = await db;
//   return Sqflite.firstIntValue(
//       await dbCartProduct.rawQuery("SELECT COUNT(*) FROM CartProducts"));
// }
//
//
// Future<CartProduct> getCartProduct(int id) async {
//   var dbCartProduct = await db;
//   var result = await dbCartProduct
//       .rawQuery("SELECT * FROM CartProducts WHERE id = $id");
//   if (result.length == 0) return null;
//   return new CartProduct.fromJson(result.first);
// }

// Future<int> deleteCartProducts() async {
//   var dbCartProducts = await db;
//
//   int res = await dbCartProducts.rawDelete('DELETE FROM CartProducts');
//   return res;
// }
//
// deleteCartProduct(int id) async {
//   final dbCartProduct = await db;
//   dbCartProduct.rawDelete('DELET E FROM CartProducts WHERE id = $id');
// }
//
// Future<int> updateCount({int count, int id}) async {
//   var dbCartProduct = await db;
//
//   return await dbCartProduct
//       .rawUpdate('UPDATE CartProducts SET count = $count WHERE id=$id');
// }*/

// Future close() async {
//   var dbCartProduct = await db;
//   return dbCartProduct.close();
// }
}
