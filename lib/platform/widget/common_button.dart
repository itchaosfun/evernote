import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget{

  Function _onTap;
  String _text;
  double left;
  double right;
  double top;
  double bottom;
  CommonButton(this._text,this._onTap,{this.left = 10,this.right = 10,this.top = 10,this.bottom = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: <Widget>[
            Expanded(child: FlatButton(

                onPressed: (){
                  _onTap(context);
                },
                padding: EdgeInsets.only(left: left,right: right,top: top,bottom: bottom),
                disabledColor: Colors.grey,
                color: Colors.blueGrey,
                textColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: Text(_text,maxLines:1,style: TextStyle(fontSize: 18),)),)
          ],
        )
    );
  }
}