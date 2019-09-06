import 'package:flutter/material.dart';
import '../../platform/widget/common_button.dart';
import '../../common/user_manager.dart';
import '../login/login.dart';
import 'modifypwd.dart';

class Setting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SettingWidget();
  }
}

class SettingWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context) {

    Widget modifyPwdWidget() => GestureDetector(
      child:  Container(
          color: Color.fromARGB(0xff, 0x68, 0x83, 0x8b),
          child: ListTile(
            title: Text("修改密码",style: TextStyle(color: Colors.white),),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,),
          )
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ModifyPwd())
        );
      },
    );

    Widget resetPwdWidget() => GestureDetector(
      child: Container(
          color: Color.fromARGB(0xff, 0x68, 0x83, 0x8b),
          child: ListTile(
            title: Text("重置密码",style: TextStyle(color: Colors.white),),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,),
          )
      ),
      onTap: (){

      },
    );

    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.blueGrey
          )
      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "设 置",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),
          ),
        ),

        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    modifyPwdWidget(),
                    Divider(height: 1,),
                    resetPwdWidget(),
                    Divider(height: 1,),
                  ],
                ),
                flex: 1,
              ),

              CommonButton("退 出 登 录", (context){
                logout();
              },top: 12,bottom: 15,)
            ],
          ),
        ),
      ),
    );
  }

  void logout() async {
    await UserManager.getInstance().logout();
    Navigator.pushAndRemoveUntil(this.context,MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}