import 'package:flutter/material.dart';
import '../../platform/widget/common_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/user_manager.dart';

class ModifyPwd extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ModifyPwdWidget();
  }
}

class ModifyPwdWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ModifyPwdState();
  }
}

class ModifyPwdState extends State<ModifyPwdWidget>{

  String originPwd;
  String newPwd;
  String confirmNewPwd;

  Widget inputOriginPwd() => Container(
    child: TextField(
      obscureText: true,
      maxLength: 16,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: "请输入原密码",
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueGrey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(6))
        )
      ),

      onChanged: (originPwd){
        setState(() {
          this.originPwd = originPwd;
        });
      },
    ),
  );

  Widget inputNewPwd() => Container(
    child: TextField(
      obscureText: true,
      maxLines: 1,
      maxLength: 16,
      decoration: InputDecoration(
        hintText: "请输入新密码",
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueGrey
          ),
          borderRadius: BorderRadius.all(Radius.circular(6))
        )
      ),

      onChanged: (newPwd){
        setState(() {
          this.newPwd = newPwd;
        });
      },
    ),
  );

  Widget inputConfirmNewPwd() => Container(
    child: TextField(
      maxLength: 16,
      maxLines: 1,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "请确认新密码",
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueGrey
          ),
          borderRadius: BorderRadius.all(Radius.circular(6))
        )
      ),

      onChanged: (confirmPwd){
        setState(() {
          this.confirmNewPwd = confirmPwd;
        });
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
          title: Text("修改密码"),
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    inputOriginPwd(),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    inputNewPwd(),
                    Padding(padding: EdgeInsets.only(top: 5),),
                    inputConfirmNewPwd()
                  ],
                ),
                flex: 1,
              ),
              CommonButton("确 认 修 改", (context){
                  modifyPwd();
              })
            ],
          ),
        ),
      ),
    );
  }

  void modifyPwd() async{
    if(originPwd == null || originPwd.isEmpty){
      Fluttertoast.showToast(msg: "原密码不能为空");
      return;
    }

    if(newPwd == null || newPwd.isEmpty){
      Fluttertoast.showToast(msg: "新密码不能为空");
      return;
    }

    if(confirmNewPwd == null || confirmNewPwd.isEmpty || confirmNewPwd != newPwd){
      Fluttertoast.showToast(msg: "两次输入密码不一致");
      return;
    }

    if(originPwd != UserManager.getInstance().password){
      Fluttertoast.showToast(msg: "原密码有误");
      return;
    }

    await UserManager.getInstance().updatePwd(newPwd);

    Fluttertoast.showToast(msg: "密码修改成功");
    Navigator.of(context).pop();
  }
}