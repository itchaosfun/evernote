import 'package:flutter/material.dart';
import '../../common/user_manager.dart';
import 'dart:io';
import '../setting/setting.dart';
import '../user/user_center.dart';
import '../note/savelist.dart';
import '../other/about.dart';

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

          ListTile(
            leading: Icon(Icons.info,color: Colors.blueGrey,),
            title: Text("个人中心",style: TextStyle(color: Colors.blueGrey),),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UserCenter()));
            },
          ),
          Divider(height: 1,),

          ListTile(
            leading: Icon(Icons.favorite,color: Colors.blueGrey,),
            title: Text("我的收藏",style: TextStyle(color: Colors.blueGrey),),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SaveList()));
            },
          ),
          Divider(height: 1,),

          ListTile(
            leading: Icon(Icons.settings,color: Colors.blueGrey,),
            title: Text("设置",style: TextStyle(color: Colors.blueGrey),),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Setting()));
            },
          ),
          Divider(height: 1,),

          ListTile(
            leading: Icon(Icons.note,color: Colors.blueGrey,),
            title: Text("关于",style: TextStyle(color: Colors.blueGrey),),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => About()));
            },
          ),
          Divider(height: 1,),

        ],
      ),
    );
  }
}
