
import 'package:flutter/widgets.dart';

class PopRoute extends PopupRoute{

  Widget child;

  PopRoute({this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
}