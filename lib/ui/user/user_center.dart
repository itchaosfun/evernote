import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../common/user_manager.dart';
import '../../data/user.dart';
import '../../platform/widget/select_gender_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserCenter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return UserCenterWidget();
  }
}

class UserCenterWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UserCenterState();
  }
}

class UserCenterState extends State<UserCenterWidget>{

  var isEditing = false;

  UserInfo userInfo = UserManager.getInstance().userInfo;

  Widget userCenterHeaderWidget() => Container(
    height: 200,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.teal,Colors.blueGrey,Colors.blueGrey,Colors.blueGrey,Colors.blueGrey,Colors.blueGrey,Colors.teal],
          begin: Alignment.topCenter,end: Alignment.bottomCenter)
    ),

    child: Center(
      child: GestureDetector(
        child: Container(
          width: 100,height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(image: (userInfo.header==null||userInfo.header.isEmpty)?
                    AssetImage("image/register_header_bg.jpg",):FileImage(File((userInfo.header)),),fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(100))
          ),
        ),

        onTap: (){
          if(isEditing){
            selectHeader();
          }
        },
      ),
    ),
  );

  Widget userNameWidget() => Container(
    height: 60,
    padding: EdgeInsets.only(left: 20,right: 20),
    child: Center(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("用户名：",style: TextStyle(fontSize: 16),)
          ),
          Expanded(
            child: TextField(
              textDirection: TextDirection.rtl,
              controller: TextEditingController.fromValue(TextEditingValue(
                text: userInfo.userName,
                selection: TextSelection.fromPosition(TextPosition(
                  offset: userInfo.userName.length
                ))
              )),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              readOnly: !isEditing,
              autofocus: false,
              onChanged: (inputUserName){
                 userInfo.userName = inputUserName;
              },
            ),
            flex: 1,
          )
        ],
      ),
    ),
  );

  Widget phoneWidget() => Container(
    height: 60,
    padding: EdgeInsets.only(left: 20,right: 20),
    child: Center(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("电话：",style: TextStyle(fontSize: 16),)
          ),
          Expanded(
            child: TextField(
              textDirection: TextDirection.rtl,
              controller: TextEditingController.fromValue(TextEditingValue(
                text: userInfo.phone,
                selection: TextSelection.fromPosition(TextPosition(
                  offset: userInfo.phone.length
                ))
              )),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              readOnly: !isEditing,
              autofocus: false,
              onChanged: (inputPhone){
                userInfo.phone = inputPhone;
              },
            ),
            flex: 1,
          )
        ],
      ),
    ),
  );

  Widget genderWidget() => Container(
    height: 60,
    padding: EdgeInsets.only(left: 20,right: 20),
    child: Center(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("性别：",style: TextStyle(fontSize: 16),)
          ),
          Expanded(
            child: TextField(
              textDirection: TextDirection.rtl,
              controller: TextEditingController(
                  text: userInfo.gender==0?"男":"女"
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              readOnly: true,
              autofocus: false,
              onTap: (){
                if(isEditing){
                  selectGender();
                }
              },
            ),
            flex: 1,
          )
        ],
      ),
    ),
  );

  Widget birthdayWidget() => Container(
    height: 60,
    padding: EdgeInsets.only(left: 20,right: 20),
    child: Center(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("生日：",style: TextStyle(fontSize: 16),)
          ),
          Expanded(
            child: TextField(
              textDirection: TextDirection.rtl,
              controller: TextEditingController(
                  text: userInfo.birthday==0?
                  "未知":
                  "${DateTime.fromMillisecondsSinceEpoch(userInfo.birthday).year}年"
                  "${DateTime.fromMillisecondsSinceEpoch(userInfo.birthday).month}月"
                  "${DateTime.fromMillisecondsSinceEpoch(userInfo.birthday).day}日"
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              readOnly: true,
              autofocus: false,
              onTap: (){
                if(isEditing){
                  selectDate();
                }
              },
            ),
            flex: 1,
          )
        ],
      ),
    ),
  );

  Widget ageWidget() => Container(
    height: 60,
    padding: EdgeInsets.only(left: 20,right: 20),
    child: Center(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("年龄：",style: TextStyle(fontSize: 16),)
          ),
          Expanded(
            child: TextField(
              textDirection: TextDirection.rtl,
              controller: TextEditingController(
                  text: getAge()
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              readOnly: true,
              autofocus: false,
            ),
            flex: 1,
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blueGrey)
      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "个人中心",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
          ),
          actions: <Widget>[
            Center(
              child: GestureDetector(
                child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(isEditing?"提交":"编辑",style: TextStyle(color: Colors.white,fontSize: 14),),
                ),
                onTap: (){
                  setState(() {
                    if(isEditing){
                      submit();
                    }else{
                      isEditing = !isEditing;
                    }
                  });
                },
              )
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                userCenterHeaderWidget(),
                userNameWidget(),
                Divider(height: 1,),
                phoneWidget(),
                Divider(height: 1,),
                genderWidget(),
                Divider(height: 1,),
                birthdayWidget(),
                ageWidget()
              ],
          ),
        ),
      ),
    );
  }

  String getAge() {
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateTime.fromMillisecondsSinceEpoch(userInfo.birthday == 0? currentDate.millisecondsSinceEpoch:userInfo.birthday);

    int currentYear = currentDate.year;
    int currentMonth = currentDate.month;
    int currentDay = currentDate.day;

    int birthYear = birthDate.year;
    int birthMonth = birthDate.month;
    int birthDay = birthDate.day;

    int age = 0;
    age = currentYear - birthYear;
    if(currentMonth < birthMonth){
      age--;
    }else{
      if(currentMonth == birthMonth && currentDay < birthDay){
        age--;
      }
    }
    return "$age岁";
  }

  void selectDate() async {
    var dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1970,1,1),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,);

    if(dateTime == null || !(dateTime is DateTime)){
      return;
    }

    setState(() {
      userInfo.birthday = dateTime.millisecondsSinceEpoch;
    });
  }

  void selectHeader() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image.path);
    setState(() {
      userInfo.header = image.path;
    });
  }


  void selectGender() {
    showDialog(context: context,builder: (BuildContext context) {
      return SelectGenderDialog((gender){
        setState(() {
          userInfo.gender = gender;
        });
      });
    });
  }

  void submit() async{
    var i = await UserManager.getInstance().updateUserInfo(userInfo);
    Fluttertoast.showToast(msg: "提交成功",toastLength: Toast.LENGTH_SHORT);
    setState(() {
      isEditing = !isEditing;
    });
  }
}
