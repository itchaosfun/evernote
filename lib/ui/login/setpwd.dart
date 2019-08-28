import 'package:flutter/material.dart';

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
      ),
    );
  }
}