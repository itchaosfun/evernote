import 'package:flutter/material.dart';
import '../data/favorite.dart';

// ignore: must_be_immutable
class SaveList extends StatelessWidget {
  // This widget is the root of your application.
  var _save = FavoriteData.instance.favoriteData;

  @override
  Widget build(BuildContext context) {
    var list = _save.map((pair) {
      return new ListTile(
        title: new Text(
          pair.note,
          style: new TextStyle(
              color: Colors.grey,
              fontSize: 18
          ),
        ),
      );
    }).toList();

    var divide = ListTile.divideTiles(context: context, tiles: list).toList();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
              "My Favorite Note"
          ),
        ),
        body: new ListView(
          children: divide,
        ),
      ),
    );
  }

}
