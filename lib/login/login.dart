
import 'package:flutter/material.dart';
import 'register.dart';
import 'forgetpwd.dart';

void main() => runApp(Login());

class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return LoginWidget();
  }
}

class LoginWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}


class LoginState extends State<LoginWidget>{

  bool isShowPwd = false;
  String pwd = "";
  String userName = "";

  @override
  Widget build(BuildContext buildContext) {

    var userNameTextField = Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: TextField(
          autofocus: false,
          maxLines: 1,
          maxLength: 20,
          decoration: InputDecoration(
            hintText: "请输入用户名",
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green,width: 1,style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(6))
            ),
          ),
          onChanged: (userName){
            this.userName = userName;
          },
        )
    );

    var passwordTextField = Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: TextField(
        controller: TextEditingController.fromValue(TextEditingValue(
          text: pwd,
          selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: pwd.length
          ))
        )),
        autofocus: false,
        maxLength: 16,
        maxLines: 1,
        obscureText: !isShowPwd,
        decoration: InputDecoration(
          suffixIcon: IconButton(icon: ImageIcon(AssetImage(isShowPwd? "image/eye_open.png":"image/eye_close.png")), onPressed: (){
            setState(() {
              isShowPwd = !isShowPwd;
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
          pwd = password;
        },
      ),
    );

    var extralInfoText = Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ForgetPwdText(),
          RegisterText()
        ],
      ),
    );

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blueGrey)
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Wekcome To Note",style: TextStyle(inherit: true,color: Colors.white,fontSize: 20),),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userNameTextField,
            Padding(padding: EdgeInsets.only(top: 10)),
            passwordTextField,
            extralInfoText
          ],
        ),
      ),
    );
  }
}

class ForgetPwdText extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            child: Text(
              "忘记密码？",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16
              ),
            ),
            onTap: () {
              pushToForgetPwd(context);
            }
        )
    );
  }

  void pushToForgetPwd(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPwd()));
  }
}

class RegisterText extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            child: Text(
              "立即注册",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16
              ),
            ),
            onTap: () {
              pushToRegister(context);
            }
        )
    );
  }

  void pushToRegister(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
  }
}