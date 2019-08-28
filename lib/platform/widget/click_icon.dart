import 'package:flutter/material.dart';
import 'package:flutter1/platform/widget/platform_tap_widget.dart';

class ClickIcon extends StatelessWidget{

  final Icon icon;
  final Text text;
  final Function onTap;

  ClickIcon(this.icon,this.text,this.onTap);

  @override
  Widget build(BuildContext context) {
    return PlatformTapWidget(
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              icon,
              text
            ],
          ),
          onTap,
        );
  }

}