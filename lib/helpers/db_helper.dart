import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    //Database is the type provided with sqlite package.
    final dbPath = await sql.getDatabasesPath(); //gives path for dataBase
    return sql.openDatabase(
        path.join(
            dbPath, 'places.db'), //finds already existing or creates new one
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)'); //loc_lat and lat= longitude and longitude dataType that's being stored.
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper
        .database(); //dbhelper used coz it's a static function and would look like global function outside of the class
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm
          .replace, //i.e. if we are inserting a data with an id which is already in the table then it'll overrite the existing data in the record
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table); //qery method for getting method.
  }
}
