import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/constance_business.dart';
import 'welcome.dart';
import '../login/login.dart';
import '../home/home_page.dart';
import '../../common/user_manager.dart';

void main(){ runApp(MaterialApp(home: InitPage()));}

class InitPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return InitPageWidget();
  }
}

class InitPageWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return InitPageState();
  }
}

class InitPageState extends State<InitPageWidget>{
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();


  @override
  Widget build(BuildContext context) {

    initData();

    return Scaffold(
          key: navigatorKey,
          body: Container(
            color: Colors.blueGrey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("image/note.png"),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text("欢迎来到\nEVERNOTE！",
                    maxLines:2,
                    style: TextStyle(
                        height: 1.1,
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 5,
                        decoration: TextDecoration.none
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
    );
  }

  void initData() async{

    print("initData");

    var instance = await SharedPreferences.getInstance();
    var entered = instance.getBool(SP_ENTER_WELCOME);
    print("entered = $entered");
    if(entered != null && entered){
       String loginedUser =await UserManager.getInstance().hasLogined();
       if(loginedUser != null && loginedUser.isNotEmpty){
          await UserManager.getInstance().initUser(loginedUser);
          enterPage(NoteList());
       }else{
          enterPage(Login());
       }
    }else{
        enterPage(Welcome());
    }
  }

  void enterPage(Widget widgetPage){
    print("enterPage: $widgetPage");
    int countDown = 3;
    Timer.periodic(Duration(seconds: 1), (timer){
        countDown--;
        if(countDown <= 0){
          timer.cancel();
          Navigator.of(navigatorKey.currentContext).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widgetPage), (route)=>false);
        }
    });
  }
}