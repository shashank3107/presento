import 'dart:io';

import 'package:the_attendence_manager_app/DatabaseDetails/databaseHelper.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  final String tableName = "list";
  final String columnId = "id";
  final String columnItemName = "itemName";

  final String columnRegisNo = "registrationNO";
  final String columnDaysPresent = "daysPresent";
  final String columnDaysAbsent = "daysAbsent";
  final String columnTotalDays = "totalDays";


  static Database _db;

  Future<Database> get db async {
   /* if (_db != null) {
      return _db;
    }*/
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "itemlist.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, $columnItemName TEXT, $columnRegisNo TEXT, $columnDaysPresent INTEGER, $columnDaysAbsent INTEGER, $columnTotalDays INTEGER)");
    print("Table is created");
  }

//insertion
  Future<int> saveItem(NoDoItem item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", item.toMap());
    print(res.toString());
    return res;
  }

  //Get
  Future<List> getItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnItemName ASC"); //ASC

    return result.toList();

//    if (result.length == 0) return [];
//    var users = [];
//
//    for (Map<String, dynamic> map in result) {
//       users.add(new User.fromMap(map));
//    }
//
//    return users;

  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT COUNT(*) FROM $tableName"
    ));
  }
//
  Future<NoDoItem> getItem(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE id = $id");
    if (result.length == 0) return null;
    return new NoDoItem.fromMap(result.first);
  }

  //deletion
//  Future<int> deleteItem(int id) async {
//    var dbClient = await db;
//    var result = await dbClient.rawQuery("DELETE FROM $tableName WHERE id = $id");
//    if (result.length == 0) return null;
//    return result.first as int;
//  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableName,
        where: "$columnId = ?", whereArgs: [id]);

  }
  Future<int> updateItem(NoDoItem item) async {
    var dbClient = await db;
    return await dbClient.update("$tableName", item.toMap(),
        where: "$columnId = ?", whereArgs: [item.id]);

  }

  Future upDP(int id2) async {
    var dbClient = await db;
    await dbClient.rawQuery("UPDATE $tableName SET $columnDaysPresent = $columnDaysPresent + 1, $columnTotalDays =$columnTotalDays + 1 WHERE Id = $id2");

  }

  Future upAP(int id2) async {
    var dbClient = await db;
    await dbClient.rawQuery("UPDATE $tableName SET $columnDaysAbsent = $columnDaysAbsent + 1, $columnTotalDays =$columnTotalDays + 1 WHERE Id = $id2");

  }


  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}