import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseIntialization {
  static Future<Database> get db async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "bank"); //change here
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      await _loadDataBaseFormAssets(path);
    }

    return await openDatabase(
      path,
    );
  }

  static _loadDataBaseFormAssets(path) async {
    ByteData data =
        await rootBundle.load(join('assets/database', "bank.db")); //change here
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }
}
