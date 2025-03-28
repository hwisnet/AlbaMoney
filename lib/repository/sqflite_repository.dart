import 'package:flutter_project/controller/sqflite_controller.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/model/attendance_model.dart';

class SqfliteRepository {
  static Future<int> insertAlbaData(AlbaModel alba) async {
    return await SqfliteController.to.database
        .insert(AlbaDbInfo.table, alba.toMap());
  }

  static Future<int> insertAttendData(AttendModel attend) async {
    return await SqfliteController.to.database
        .insert(AttendDbInfo.table, attend.toMap());
  }

  static Future<int> deleteAttendData(int id, String date) async {
    return await SqfliteController.to.database.delete(AttendDbInfo.table,
        where:
            '${AttendDbInfo.attendId} = ? AND ${AttendDbInfo.attendDate} = ?',
        whereArgs: [id, date]);
  }

  static Future<List<AlbaModel>> readAlbaData() async {
    final db = SqfliteController.to.database;
    final queryResult = await db.query(AlbaDbInfo.table);

    return queryResult.isNotEmpty
        ? queryResult.map((json) => AlbaModel.fromJson(json)).toList()
        : [];
  }

  static Future<List<AttendModel>> readAttendData() async {
    final db = SqfliteController.to.database;
    final queryResult = await db.query(AttendDbInfo.table);

    return queryResult.isNotEmpty
        ? queryResult.map((json) => AttendModel.fromJson(json)).toList()
        : [];
  }

  static Future<List<AttendModel>> readCurrentMonthAttnedData(
      DateTime currentDate) async {
    final db = SqfliteController.to.database;
    final queryResult = await db.query(
      AttendDbInfo.table,
      where: '${AttendDbInfo.attendDate} BETWEEN ? AND ?',
      whereArgs: [
        '${currentDate.year}-${currentDate.month}-01T00:00:00.000Z',
        '${currentDate.year}-${currentDate.month}-31T23:59:59.999Z'
      ],
    );

    return queryResult.isNotEmpty
        ? queryResult.map((json) => AttendModel.fromJson(json)).toList()
        : [];
  }
}
