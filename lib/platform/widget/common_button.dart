import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget{

  Function _onTap;
  String _text;
  CommonButton(this._text,this._onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: <Widget>[
            Expanded(child: FlatButton(
                onPressed: (){
                  _onTap(context);
                },
                padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
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