import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:flutter1/data/note.dart';

class DatabaseManager {

  String noteTable = "noteTable";
  String id = "id";
  String note = "note";
  String content= "content";
  String isFavorite= "isFavorite";
  String time= "time";
  String imageList = "imageList";


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
    var db = await openDatabase(path,version: 2,onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $noteTable($id INTEGER_PRIMARY KEY,$note TEXT,$content TEXT,$imageList TEXT,$isFavorite TEXT,$time INTEGER)");
  }

  Future<int> insertNote(NoteData note) async{
    var client = await database;
    var result = client.insert(noteTable, note.toJson());
    return result;
  }

  Future<List<NoteData>> getNotes({int limit,int offset}) async{
    var dbClient = await database;
    var result = await dbClient.query(
        noteTable,
        columns: [id,note,content,imageList,isFavorite,time],
        limit: limit,
        offset: offset
    );

    List<NoteData> notes = [];
    result.forEach((item) =>
      notes.add(NoteData.fromSql(item))
    );

    return notes;
  }

  Future<int> removeNote(NoteData note) async{
    var dbClient = await database;
    return dbClient.delete(noteTable,where: "$id=?",whereArgs: [note.id]);
  }

  Future<int> updateNote(NoteData note) async {
    var dbClient = await database;
    return await dbClient.update(noteTable, note.toJson(),where: "$id=?",whereArgs: [note.id]);
  }

}
