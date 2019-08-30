import 'package:flutter/material.dart';
import '../../platform/widget/common_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/user_manager.dart';
import '../../platform/widget/tips_dialog.dart';
import '../home/home_page.dart';

class SetPwd extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SetPwdWidget();
  }
}

class SetPwdWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SetPwdState();
  }
}

class SetPwdState extends State<SetPwdWidget>{

  String inputPwd = "";
  bool inputPwdIsShow = false;

  String confirmPwd = "";
  bool confirmPwdIsShow = false;

  Widget inputPwdWidget() => Container(
      child: TextField(
        controller: TextEditingController.fromValue(TextEditingValue(
            text: inputPwd,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: inputPwd.length
            ))
        )),
        autofocus: false,
        maxLength: 16,
        maxLines: 1,
        obscureText: !inputPwdIsShow,
        decoration: InputDecoration(
            suffixIcon: IconButton(icon: ImageIcon(AssetImage(inputPwdIsShow? "image/eye_open.png":"image/eye_close.png")), onPressed: (){
              setState(() {
                inputPwdIsShow = !inputPwdIsShow;
              });
            }),
            hintText: "请输入密码",
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey,width: 1,style: BorderStyle.none),
                borderRadius: BorderRadius.all(Radius.circular(6))
            )
        ),
        onChanged: (password){
          inputPwd = password;
          setState(() {
          });
        },
      ),
  );

  Widget confirmPwdWidget() => Container(
    padding: EdgeInsets.only(top: 15),
    child: TextField(
      controller: TextEditingController.fromValue(TextEditingValue(
          text: confirmPwd,
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: confirmPwd.length
          ))
      )),
      autofocus: false,
      maxLength: 16,
      maxLines: 1,
      obscureText: !confirmPwdIsShow,
      decoration: InputDecoration(
          suffixIcon: IconButton(icon: ImageIcon(AssetImage(confirmPwdIsShow? "image/eye_open.png":"image/eye_close.png")), onPressed: (){
            setState(() {
              confirmPwdIsShow = !confirmPwdIsShow;
            });
          }),
          hintText: "请确认输入的密码",
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey,width: 1,style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(6))
          )
      ),
      onChanged: (password){
        confirmPwd = password;
        setState(() {
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
          title: Text(
            "设置密码",
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              inputPwdWidget(),
              confirmPwdWidget(),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: CommonButton("设  置", (context){
                  setPwd(context);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setPwd(context)async {
    if(inputPwd == null || inputPwd.isEmpty || confirmPwd == null || confirmPwd.isEmpty){
      Fluttertoast.showToast(msg: "密码不能为空");
      return;
    }

    if(inputPwd != confirmPwd){
      Fluttertoast.showToast(msg: "两次输入的密码不一致");
      return;
    }

    await UserManager.getInstance().updatePwd(inputPwd);

    showDialog(
      context: context,
      builder: (BuildContext context){
        return TipsDialogWidget("设置密码成功！\n正在为您跳转...", 3, (){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => NoteList()),(route)=> false
          );
        });
      }
    );
  }
}