import 'dart:async';
import 'package:flutter1/data/note.dart';
import 'db_base_table.dart';

class NoteDbManager extends BaseDbTable{

  String noteTable = "NoteTable";
  String id = "id";
  String noteId = "noteId";
  String note = "note";
  String content= "content";
  String isFavorite= "isFavorite";
  String time= "time";
  String imageList = "imageList";

  static NoteDbManager noteDbManager;

  static NoteDbManager getInstance(){
    if(noteDbManager == null){
      noteDbManager = NoteDbManager();
    }
    return noteDbManager;
  }

  @override
  createTableString() {
    return "CREATE TABLE $noteTable($id INTEGER PRIMARY KEY,$note TEXT,$content TEXT,$imageList TEXT,$isFavorite TEXT,$time INTEGER)";
  }

  @override
  tableName() {
    return noteTable;
  }

  Future<int> insertNote(NoteData note) async{
    var client = await getDataBase();
    var result = client.insert(noteTable, note.toJson());
    return result;
  }

  Future<List<NoteData>> getNotes({int limit,int offset}) async{
    var dbClient = await getDataBase();
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
    var dbClient = await getDataBase();
    return dbClient.delete(noteTable,where: "$id=?",whereArgs: [note.id]);
  }

  Future<int> updateNote(NoteData note) async {
    var dbClient = await getDataBase();
    return await dbClient.update(noteTable, note.toJson(),where: "$id=?",whereArgs: [note.id]);
  }

}