import 'package:flutter/material.dart';
import 'package:flutter1/platform/widget/platform_tap_widget.dart';

class ClickIcon extends StatelessWidget{

  final Icon _icon;
  final Text _text;
  final Function _onTap;

  ClickIcon(this._icon,this._text,this._onTap);

  @override
  Widget build(BuildContext context) {
    return PlatformTapWidget(
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _icon,
              _text
            ],
          ),
          _onTap,
        );
  }

}