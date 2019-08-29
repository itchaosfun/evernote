import 'package:flutter/material.dart';
import 'package:flutter1/platform/widget/common_button.dart';
import 'register.dart';
import 'forgetpwd.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/user_manager.dart';
import '../../common/constance.dart';
import '../home/home_page.dart';
import '../../platform/widget/tips_dialog.dart';
import 'setpwd.dart';

void main(){ runApp(Login());}

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

    var noteIcon = Container(
      padding: EdgeInsets.only(top: 20,bottom: 20),
      child: Image.asset("image/note.png"),
    );

    var userNameTextField = Container(
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
          onChanged: (username){
            userName = username;
            setState(() {
            });
          },
        )
    );

    var passwordTextField = Container(
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
          setState(() {
          });
        },
      ),
    );

    var extralInfoText = Container(
      padding: EdgeInsets.only(top: 20,bottom: 20),
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
        body: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                noteIcon,
                userNameTextField,
                Padding(padding: EdgeInsets.only(top: 10)),
                passwordTextField,
                extralInfoText,
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: CommonButton("登  录",(context){
                    startLogin(context,);
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startLogin(context) {
    if(userName == null ||userName.isEmpty){
       Fluttertoast.showToast(
          msg: "用户名不能为空",
          toastLength: Toast.LENGTH_SHORT
       );

       return;
    }

    if(pwd == null ||pwd.isEmpty){
      Fluttertoast.showToast(
          msg: "密码不能为空",
          toastLength: Toast.LENGTH_SHORT
      );
      return;
    }

    login(context);
  }

  void login(context)async{
    print("开始登陆");
    var errorCode = await UserManager.getInstance().checkLogin(userName, pwd);
    print("errorCode = ${errorCode.errorString}");
    Fluttertoast.showToast(
        msg: errorCode.errorString,
        toastLength: Toast.LENGTH_SHORT
    );

    if(errorCode.errorCode == SUCCESS_CODE){
      if(UserManager.getInstance().password == UserManager.getInstance().phone){
        //首次登录需要设置密码
        showDialog(
            context: context,
            builder: (BuildContext context){
              return TipsDialogWidget("您还未设置密码，\n正在为您跳转到设置密码页面",3,(){
                //倒计时结束，跳转到设置密码界面
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SetPwd()),(route) => false
                );
              });
            }
        );
      }else{
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => NoteList()),(route)=>false
        );
      }
    }
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPwd()));
            }
        )
    );
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
            }
        )
    );
  }
}
