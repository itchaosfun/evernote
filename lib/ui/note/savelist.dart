import 'package:flutter/material.dart';
import '../../data/favorite.dart';

// ignore: must_be_immutable
class SaveList extends StatelessWidget {
  // This widget is the root of your application.
  var saveList = FavoriteData.instance.favoriteData;

  @override
  Widget build(BuildContext context) {
    var list = saveList.map((pair) {
      return new ListTile(
        title: new Text(
          pair.note,
          style: new TextStyle(
              color: Colors.grey,
              fontSize: 14
          ),
        ),
      );
    }).toList();

    var divide = ListTile.divideTiles(context: context, tiles: list).toList();

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blueGrey)
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              "我的收藏",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        body: new ListView(
          children: divide,
        ),
      ),
    );
  }

}
