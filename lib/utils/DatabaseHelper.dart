import 'package:sqflite/sqflite.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
class DatabaseHelper {
  static Future<List<Map<String, dynamic>>> ExcuteReaderQuery(String query) async {
    var dbPath = await Utils.databasePath();
    var db = await openDatabase(dbPath);
    var rawQuery = await db.rawQuery(query);
    db.close();
    return rawQuery;
  }
}
