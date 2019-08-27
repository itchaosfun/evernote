import 'package:flutter/material.dart';

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
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(

          ),
        ),
      ),
    );
  }
}