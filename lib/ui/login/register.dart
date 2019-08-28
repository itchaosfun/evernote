import 'package:flutter/material.dart';
import 'package:flutter1/platform/widget/common_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/user_manager.dart';
import '../../data/user.dart';
import 'login.dart';
import '../../platform/widget/tips_dialog.dart';

class Register extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return RegisterWidget();
  }
}

class RegisterWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<RegisterWidget>{

  int gender = 0;
  String userName = "";
  String phone = "";
  bool isSelectHeader = false;
  String headerUrl = "";
  String birthday = "";

  Widget headerWidget() => Container(
    height: 200,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage("image/register_header_bg.jpg"),fit: BoxFit.fill)
    ),
    child: Center(
      child: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.blueGrey,
                  image: isSelectHeader? DecorationImage(image: FileImage(File(headerUrl)),fit: BoxFit.cover): null
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),

            Text("点击选择头像",style: TextStyle(inherit:false,color: Colors.white,fontSize: 14),)
          ],
        ),

        onTap: (){
          selectHeader();
        },
      ),
    ),
  );

  Widget userNameWidget() => Container(
    padding: EdgeInsets.only(left:20,right:20,top: 20,bottom: 10),
    child: TextField(
      maxLength: 20,
      maxLines: 1,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "请输入用户名",
        labelText: "用户名",
        labelStyle: TextStyle(inherit: true,color: Colors.blue),
        contentPadding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey,width: 1,style: BorderStyle.solid),
            borderRadius:BorderRadius.all(Radius.circular(6))
        )
      ),

      onChanged: (userName){
        setState(() {
          this.userName = userName;
        });
      },
    ),
  );

  Widget phoneWidget() => Container(
    padding: EdgeInsets.only(left:20,right:20),
    child: TextField(
      maxLength: 11,
      maxLines: 1,
      autofocus: false,
      decoration: InputDecoration(
          hintText: "请输入手机号",
          labelText: "手机号",
          labelStyle: TextStyle(inherit: true,color: Colors.blue),
          contentPadding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey,width: 1,style: BorderStyle.solid),
              borderRadius:BorderRadius.all(Radius.circular(6))
          )
      ),
      onChanged: (phone){
        setState(() {
          this.phone = phone;
        });
      },
    )
  );

  Widget genderWidget() => Container(
    padding: EdgeInsets.only(left:20,right:20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Text("性 别： ${gender==0?"男":"女"}",style: TextStyle(inherit: true,fontSize: 16)),
          flex: 2,
        ),

        Expanded(
          child: RadioListTile<int>(
            value: 0,
            title: Text("男",style: TextStyle(fontSize: 14),),
            groupValue: gender,
            onChanged: (gender){
              setState(() {
                this.gender = gender;
              });
            }
          ),
          flex: 1,
        ),

        Expanded(
          child: RadioListTile<int>(
              value: 1,
              title: Text("女",style: TextStyle(fontSize: 14),),
              groupValue: gender,
              onChanged: (gender){
                setState(() {
                  this.gender = gender;
                });
              }
          ),
          flex: 1,
        ),
      ],
    ),
  );

  Widget birthdayWidget() => Container(
    width: 200,
    padding: EdgeInsets.only(left: 20,right: 20),
    child: TextField(
      controller: TextEditingController.fromValue(TextEditingValue(
          text: birthday,
      )),
      maxLines: 1,
      autofocus: false,
      readOnly: true,
      decoration: InputDecoration(
          labelText: "生日",
          labelStyle: TextStyle(inherit: true,color: Colors.blue),
          contentPadding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey,width: 1,style: BorderStyle.solid),
              borderRadius:BorderRadius.all(Radius.circular(6))
          )
      ),

      onTap: (){
        selectDate();
        print("onTap");
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Welcome To Note",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ),

        body: Container(
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  headerWidget(),
                  userNameWidget(),
                  phoneWidget(),
                  genderWidget(),
                  birthdayWidget(),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 30),
                    child: CommonButton("注  册",(context){
                      startRegister(context,);
                    }),
                  )
                ],
              )
          ),
        )
      ),
    );
  }

  void selectHeader() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image.path);
    setState(() {
      this.isSelectHeader = true;
      headerUrl = image.path;
    });
  }

  void selectDate() async {
    var dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1970,1,1),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,);

    setState(() {
      birthday = "${dateTime.year}年${dateTime.month}月${dateTime.day}日";
    });
  }

  void startRegister(context) async{
    if(userName == null || userName.isEmpty){
      Fluttertoast.showToast(
          msg: "用户名不能为空",
          toastLength: Toast.LENGTH_SHORT
      );
      return;
    }
    if(phone == null || phone.isEmpty){
      Fluttertoast.showToast(
          msg: "手机号不能为空",
          toastLength: Toast.LENGTH_SHORT
      );
      return;
    }

    var userInfo = UserInfo();
    userInfo.userName = userName;
    userInfo.phone = phone;
    userInfo.birthday = birthday.isEmpty?"2000年1月1日": birthday;
    userInfo.header = headerUrl;
    userInfo.gender = gender;
    userInfo.password = phone;
    userInfo.userId = "evernote${DateTime.now().millisecondsSinceEpoch}";

    await UserManager.getInstance().register(userInfo);

    showDialog(
      context: context,
      builder: (BuildContext context){
        return TipsDialogWidget("注册成功！\n将为您跳转到登录页面", 3, (){
          Navigator.of(context).pop(
              MaterialPageRoute(builder: (context) => Login())
          );
        });
      }
    );
  }
}