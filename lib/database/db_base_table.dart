import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'database_manager.dart';

abstract class BaseDbTable{
  bool isTableExits = false;

  createTableString();

  tableName();

  ///创建表sql语句
  tableBaseString(String sql) {
    return sql;
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await DatabaseManager.getInstance().checkTableIsExits(name);
    if (!isTableExits) {
      Database db = await DatabaseManager.getInstance().database;
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), createTableString());
    }
    return await DatabaseManager.getInstance().database;
  }
}