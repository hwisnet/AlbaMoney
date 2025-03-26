import 'package:flutter_project/model/alba_model.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
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
        ${AlbaDbInfo.albaPay} text not null,
        ${AlbaDbInfo.breakTime} text not null,
        ${AlbaDbInfo.holidayPay} integer not null
      )
    ''');
  }

  Future<void> deleteTables() async {
    return await _database.execute('DROP TABLE IF EXISTS ${AlbaDbInfo.table}');
  }

  Future<int> deleteColums() async {
    return await _database.delete(AlbaDbInfo.table);
  }

  Future<void> deleteDB() async {
    // 데이터베이스 경로 가져오기
    String path = join(await getDatabasesPath(), 'almoney.db');

    // 데이터베이스 삭제
    try {
      await deleteDatabase(path);
    } catch (e) {
      print(e.toString());
    }
  }
}
