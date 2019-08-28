import 'package:flutter/material.dart';
import 'dart:async';

class TipsDialogWidget extends StatefulWidget{

  String text;
  int count;
  Function onCountDownEvent;

  TipsDialogWidget(this.text, this.count,this.onCountDownEvent);

  @override
  State<StatefulWidget> createState() {
    return TipsState(text,count,onCountDownEvent);
  }
}

class TipsState extends State<TipsDialogWidget>{

  String text;
  int count;
  Function onCountDownEvent;
  Timer timer;

  TipsState(this.text,this.count,this.onCountDownEvent);

  @override
  Widget build(BuildContext context) {

    if(timer == null){
      startCount();
    }

    return Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center( //保证控件居中效果
        child: SizedBox(
          width: 220.0,
          height: 140.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text("$count",style: TextStyle(
                    color: Colors.blue,fontSize: 24
                ),),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Center(
                    child:Text(
                      text,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.3,
                          letterSpacing: 1,
                          fontSize: 14.0),
                      textAlign: TextAlign.center,

                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startCount() {
    timer = Timer.periodic(Duration(seconds: 1), (time){
      print("count = $count");
      if(count <= 0){
        // ignore: unnecessary_statements
        timer?.cancel();
        Navigator.of(context).pop();
        onCountDownEvent();
      }
      count--;
      if(count > 0){
        setState(() {
        });
      }
    });
  }
}