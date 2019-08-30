import 'package:flutter/material.dart';

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
        ),
      ),
    );
  }
}