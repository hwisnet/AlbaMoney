import 'package:flutter_project/controller/sqflite_controller.dart';
import 'package:flutter_project/model/alba_model.dart';

class SqfliteRepository {
  static Future<int> createAlbaData(AlbaModel alba) async {
    return await SqfliteController.to.database
        .insert(AlbaDbInfo.table, alba.toMap());
  }

  static Future<List<AlbaModel>> readAlbaData() async {
    final db = SqfliteController.to.database;
    final queryResult = await db.query(AlbaDbInfo.table);

    return queryResult.isNotEmpty
        ? queryResult.map((json) => AlbaModel.fromJson(json)).toList()
        : [];
  }
}
