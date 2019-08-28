import 'package:flutter/material.dart';


class ForgetPwd extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ForgetPwdWidget();
  }
}

class ForgetPwdWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ForgetPwdState();
  }
}

class ForgetPwdState extends State<ForgetPwdWidget>{
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
            "重置密码",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
          ),
        ),

        body: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(

          ),
        ),
      ),
    );
  }
}