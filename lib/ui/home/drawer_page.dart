import 'package:flutter/material.dart';
import '../../common/user_manager.dart';
import 'dart:io';

class DrawerWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                backgroundImage: FileImage(File(UserManager.getInstance().header)),
            ),
            accountName: Text(UserManager.getInstance().userName),
            accountEmail: Text(UserManager.getInstance().phone)
          ),
        ],
      ),
    );
  }
}
