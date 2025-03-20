import 'package:flutter_project/model/alba_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SqfliteController extends GetxService {
  static SqfliteController get to => Get.find();

  late Database _database;

  Database get database {
    return _database;
  }

  Future<bool> initDatabase() async {
    var databasePath = path.join(await getDatabasesPath(), 'almoney.db');
    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return true;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      create Table ${AlbaDbInfo.table} (
        ${AlbaDbInfo.id} integer primary key autoincrement,
        ${AlbaDbInfo.albaPlace} text not null,
        ${AlbaDbInfo.albaDays} text not null,
        ${AlbaDbInfo.startDate} text not null,
        ${AlbaDbInfo.startTime} text not null,
        ${AlbaDbInfo.endTime} text not null,
        ${AlbaDbInfo.albaPay} integer not null,
        ${AlbaDbInfo.albaBreakTime} integer not null,
        ${AlbaDbInfo.albaHolidayPay} bool not null
      )
    ''');
  }

  Future<int> deleteDatabase() async {
    return await _database.delete(AlbaDbInfo.table);
  }
}
