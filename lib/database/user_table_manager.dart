import 'database_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../data/user.dart';
import 'db_base_table.dart';

class UserDbManager extends BaseDbTable{


  String userTable = "UserTable";

  String id = "id";
  String userId = "userId";
  String userName = "userName";
  String password = "password";
  String phone = "phone";
  String birthday = "birthday";
  String header = "header";
  String gender = "gender";

  static UserDbManager _noteDbManager;

  static UserDbManager getInstance(){
    if(_noteDbManager == null){
      _noteDbManager = UserDbManager();
    }
    return _noteDbManager;
  }
  Database _database;

  @override
  createTableString() {
    return "CREATE TABLE $userTable($id INTEGER PRIMARY KEY,"
        "$userId TEXT,$userName TEXT,$password TEXT,$phone TEXT,"
        "$birthday TEXT,$header TEXT,$gender INTEGER)";
  }

  @override
  tableName() {
    return userTable;
  }

  Future<Database> get database async{
    if(_database == null){
      _database =await DatabaseManager.getInstance().database;
    }
    return _database;
  }

  Future<int> insertUser(UserInfo userInfo) async{
    var client = await getDataBase();
    var json = userInfo.toJson();
    var result = client.insert(userTable, json);
    return result;
  }

  Future<UserInfo> getUserInfoByUserName(String name) async{
    var dbClient = await getDataBase();
    var result = await dbClient.query(userTable,where: "$userName=?",whereArgs: [name]);

    print("result = $result");

    if(result == null || result.isEmpty){
      return null;
    }

    return UserInfo.fromSql(result.first);
  }

  Future<int> updateNote(UserInfo userInfo) async {
    var dbClient = await getDataBase();
    return await dbClient.update(userName, userInfo.toJson(),where: "$userId=?",whereArgs: [userInfo.userId]);
  }

}