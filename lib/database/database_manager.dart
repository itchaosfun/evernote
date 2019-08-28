import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'note_table_manager.dart';

class DatabaseManager {

  static DatabaseManager _instance;

  static DatabaseManager getInstance() {
    if (_instance == null) {
      _instance = DatabaseManager();
    }

    return _instance;
  }

  static Database _database;

  var dbPath = "";

  Future<Database> get database async{
    if(_database == null){
      _database = await initDb();
    }

    return _database;
  }

  initDb() async{
    String databasePath = await getDatabasesPath();
    String path  = join (databasePath,"clever_note.db");
    var db = await openDatabase(path,version: 2,onCreate: (Database db, int version) async {});
    return db;
  }

  Future<bool> checkTableIsExits(String tableName)async{
    var db = await database;
    var res=await db.rawQuery("select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res!=null && res.length >0;
  }
}
