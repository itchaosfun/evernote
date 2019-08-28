import '../data/user.dart';
import '../database/user_table_manager.dart';
import '../common/errorcode.dart';
import '../common/constance.dart';

class UserManager {

  String userId;
  String userName;
  String password;
  String phone;
  String birthday;
  String header;
  int gender;

  static UserManager _userManager;

  static UserManager getInstance(){
    if(_userManager == null){
      _userManager = UserManager();
    }
    return _userManager;
  }

  void saveUser(UserInfo userInfo){
    this.userId = userInfo.userId;
    this.userName = userInfo.userName;
    this.password = userInfo.password;
    this.phone = userInfo.phone;
    this.birthday = userInfo.birthday;
    this.header = userInfo.header;
    this.gender = userInfo.gender;
  }

  Future<ErrorCode> checkLogin(String userName,String password)async {
    print("登录用户校验");
    var userInfo = await UserDbManager.getInstance().getUserInfoByUserName(userName);
    print("userInfo = ${userInfo.toString()}");

    if(userInfo == null){
      return ErrorCode(USER_NOT_EXITS_CODE,USER_NOT_EXITS_DESC);
    }
    if(userInfo.password != password){
      return ErrorCode(PASSWORD_NOT_CORRECT_CODE,PASSWORD_NOT_CORRECT_DESC);
    }

    saveUser(userInfo);

    return ErrorCode(SUCCESS_CODE,SUCCESS_DESC);
  }

  Future<int> register(UserInfo userInfo) async{
   return await UserDbManager.getInstance().insertUser(userInfo);
  }
}