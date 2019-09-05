import '../data/user.dart';
import '../database/user_table_manager.dart';
import '../common/errorcode.dart';
import '../common/constance_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constance_business.dart';

class UserManager {

  String userId;
  String userName;
  String password;
  String phone;
  num birthday;
  String header;
  int gender;
  int id;

  bool loginStatus = false;

  UserInfo userInfo;

  static UserManager _userManager;

  static UserManager getInstance(){
    if(_userManager == null){
      _userManager = UserManager();
    }
    return _userManager;
  }

  void saveUser(UserInfo userInfo){
    this.id = userInfo.id;
    this.userId = userInfo.userId;
    this.userName = userInfo.userName;
    this.password = userInfo.password;
    this.phone = userInfo.phone;
    this.birthday = userInfo.birthday;
    this.header = userInfo.header;
    this.gender = userInfo.gender;
  }

  Future<ErrorCode> initUser(String userId) async{
    var userInfo = await UserDbManager.getInstance().getUserInfoByUserId(userId);
    print("userInfo = ${userInfo.toString()}");

    if(userInfo == null){
      return ErrorCode(USER_NOT_EXITS_CODE,USER_NOT_EXITS_DESC);
    }
    saveUser(userInfo);

    this.loginStatus = true;

    this.userInfo = userInfo;

    return ErrorCode(SUCCESS_CODE,SUCCESS_DESC);
  }

  Future<ErrorCode> checkLogin(String userId,String password)async {
    var userInfo = await UserDbManager.getInstance().getUserInfoByUserName(userId);
    print("userInfo = ${userInfo.toString()}");

    if(userInfo == null){
      return ErrorCode(USER_NOT_EXITS_CODE,USER_NOT_EXITS_DESC);
    }
    if(userInfo.password != password){
      return ErrorCode(PASSWORD_NOT_CORRECT_CODE,PASSWORD_NOT_CORRECT_DESC);
    }

    saveUser(userInfo);

    this.loginStatus = true;

    this.userInfo = userInfo;

    var instance = await SharedPreferences.getInstance();
    instance.setString(SP_LOGINED_USERID, userInfo.userId);

    return ErrorCode(SUCCESS_CODE,SUCCESS_DESC);
  }

  Future<int> register(UserInfo userInfo) async{
   return await UserDbManager.getInstance().insertUser(userInfo);
  }

  Future<int> updatePwd(String password) async {
    userInfo.password = password;
    this.password = password;
    print(userInfo.toString());
    return await UserDbManager.getInstance().updateUser(userInfo);
  }

  Future<int> updateUserInfo(UserInfo userInfo) async{
    var int = await UserDbManager.getInstance().updateUser(userInfo);
    this.userInfo = userInfo;
    saveUser(userInfo);
    return int;
  }

  void logout(){
    this.loginStatus = false;
  }

  Future<String> hasLogined() async{
    var instance =  await SharedPreferences.getInstance();
    var loginedUser = instance.getString(SP_LOGINED_USERID);
    return loginedUser;
  }

  Future<bool> hasWelcome() async{
    var instance = await SharedPreferences.getInstance();
    var hasWelcome = instance.getBool(SP_ENTER_WELCOME);
    return hasWelcome;
  }

  void setWelcome() async{
    var instance = await SharedPreferences.getInstance();
    instance.setBool(SP_ENTER_WELCOME, true);
  }
}