
class UserInfo{
  int id;
  String userId;
  String userName;
  String password;
  String phone;
  num birthday;
  String header;
  int gender;

  UserInfo();

  @override
  String toString() {
    return "id = $id, userId = $userId, userName = $userName, phone = $phone, "
        "password = $password, birthday = $birthday, header = $header, gender = ${gender==0?"男":"女"}";
  }

  Map<String,Object> toJson(){
    Map data = new Map<String,Object>();
    if(id != null){
      data["id"] = id;
    }
    data["userId"] = userId;
    data["userName"] = userName;
    data["password"] = password;
    data["phone"] = phone;
    data["birthday"] = birthday;
    data["header"] = header;
    data["gender"] = gender;
    print(data);
    return data;
  }

  UserInfo.fromSql(Map<String, dynamic> json) {
    if(json == null || json.isEmpty){
      return;
    }
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    password = json['password'];
    phone = json['phone'];
    birthday = json['birthday'];
    header = json['header'];
    gender = json['gender'];

    print("json = ${json.toString()}");
  }
}