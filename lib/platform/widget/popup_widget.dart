import 'package:flutter/material.dart';

class PopWidget extends StatelessWidget{

  final Widget child;
  final Function onClick; //点击child事件
  final double left; //距离左边位置
  final double right;
  final double top; //距离上面位置
  final double width;
  final double height;

  PopWidget({
    this.child,
    this.onClick,
    this.left,
    this.right,
    this.top,
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {

    return new Material(color: Colors.transparent,child: GestureDetector(child: Stack(
      children: <Widget>[
        Container(width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent),
        Positioned(child: GestureDetector(child: child,onTap: (){
          if(onClick != null){
            Navigator.of(context).pop();
          }
        },),
          width: width,
          height: height,
          right: right,
          left: left,
          top: top,
        )
      ],
    ),
    onTap: (){
      Navigator.of(context).pop();
    },
    ),);
  }

}