import '../data/note.dart';
import 'package:flutter1/database/note_table_manager.dart';
import 'dart:async';
import 'dart:core';

class NoteManager {

  static NoteManager noteManager;

  static getInstance() {
    if (noteManager == null) {
      noteManager = NoteManager();
    }
    return noteManager;
  }

  Future<List<NoteData>> getNotes(int limit, int offset){
    var dataBaseManager = NoteDbManager.getInstance();
    return dataBaseManager.getNotes(limit: limit, offset: offset);
  }

  Future<int> addNewNote(NoteData noteData) async{
    var dataBaseManager = NoteDbManager.getInstance();
    return await dataBaseManager.insertNote(noteData);
  }

  Future<int> remove(NoteData note) async {
    return await NoteDbManager.getInstance().removeNote(note);
  }

  Future<int> updateNote(NoteData note) async{
    return await NoteDbManager.getInstance().updateNote(note);
  }

}