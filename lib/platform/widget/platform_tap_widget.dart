import 'package:flutter/material.dart';

class PlatformTapWidget extends StatefulWidget {

  final Widget _child;
  final Function _onTap;

  PlatformTapWidget(
      this._child,
      this._onTap);

  @override
  State<StatefulWidget> createState() => PlatformTapState();

}

class PlatformTapState extends State<PlatformTapWidget> {
  @override
  Widget build(BuildContext context) {

    Widget w;

    w = new ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Material(
        borderRadius: BorderRadius.circular(4),
        elevation: 0.0,
        child: InkWell(
          child: widget._child,
          onTap: widget._onTap,
        ),
      ),
    );

    return w;
  }

}