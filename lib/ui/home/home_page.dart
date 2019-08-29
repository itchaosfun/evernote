import 'dart:io';
import 'package:flutter/material.dart';
import '../note/detail.dart';
import '../note/savelist.dart';
import '../../common/note_manager.dart';
import '../../data/note.dart';
import '../note/add_note.dart';
import '../../platform/widget/popup_widget.dart';
import '../../platform/widget/pop_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter1/platform/widget/click_icon.dart';
import 'package:flutter/cupertino.dart';

import 'drawer_page.dart';

class NoteList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new NoteListWidget(),
    );
  }
}

class NoteListWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new NoteListWidgetState();
  }
}

class NoteListWidgetState extends State<NoteListWidget> {

  List<NoteData> noteList = [];

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  final biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");

    Future<List<NoteData>> noteFuture = NoteManager.getInstance().getNotes(100, 0);
    noteFuture.then((list) {
      if ((noteList.isEmpty && list.isNotEmpty) || noteList != list) {
        noteList = list;
        print("页面返回，开始刷新页面");
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (noteList.length <= 0) {
      print("notelist size = 0");
      Future<List<NoteData>> noteFuture = NoteManager.getInstance().getNotes(100, 0);
      noteFuture.then((list) {
        if(list.isNotEmpty ){
          noteList = list;
          print("开始刷新页面");
          setState(() {});
        }
      });
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.person,color: Colors.white),onPressed: (){
          scaffoldKey.currentState.openDrawer();
        },),
        centerTitle: true,
        title: Text(
            "My Notes"
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: showPopMenu)],
      ),
      body: buildNoteItem(),
    );
  }

  Widget buildNoteItem() {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index < noteList.length) {
          var item = noteList.elementAt(index);
          return buildRows(index, item);
        }
      },
      separatorBuilder: (context, index) {
        if (index < noteList.length) {
          return new Divider();
        }
      },

      itemCount: noteList.length,

    );
  }

  Widget buildRows(index, NoteData note) {
    var gestureDetector = GestureDetector(
      onTap: () {
        pushDetail(note);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Container(
              width: 60,
              height: 60,
              child: getImageWidget(note.noteImages.images),
            ),

            Padding(padding: EdgeInsets.only(left: 20),),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      note.note,
                      style: biggerFont,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Padding(padding: EdgeInsets.only(top: 5)),

                    Text(
                      note.content,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              flex: 1,
            ),

            Padding(padding: EdgeInsets.only(left: 20)),

            ClickIcon(
                Icon(
                  note.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: note.isFavorite ? Colors.red : Colors.blueGrey,
                ),
                Text(
                  getFormatTime(note.time),
                  style: TextStyle(
                      fontSize: 12
                  ),
                  textAlign: TextAlign.right,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ), () {
              setState(() {
                note.isFavorite = !note.isFavorite;
                NoteManager.getInstance().updateNote(note);
                setState(() {});
              });
            }
            ),
          ],
        ),
      ),
    );

    var dismiss = Dismissible(
        key: Key("key$note"),
        onDismissed: (direction) {
          noteList.remove(note);
          print("noteList length = ${noteList.length}");
          NoteManager.getInstance().remove(note);
          setState(() {});
        },
        background: Container(
          color: Colors.red,
        ),
        child: gestureDetector
    );

    return dismiss;
  }

  pushDetail(NoteData note) {
    print("push to detail page");
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Detail(note))
    );
  }

  String getFormatTime(time) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    var timeString = "${dateTime.year.toString()}"
        "-${dateTime.month.toString().padLeft(2, "0")}"
        "-${dateTime.day.toString().padLeft(2, "0")}";

    return timeString;
  }

  showPopMenu() {
    Navigator.of(context).push(PopRoute(child: PopWidget(child: Container(
      color: Colors.blueGrey,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("My Favor",
              style: TextStyle(color: Colors.amber, fontSize: 14),),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SaveList()),
              );
            },
          ),

          Divider(height: 1, color: Colors.brown,),

          ListTile(
            title: Text("New Note",
              style: TextStyle(color: Colors.amber, fontSize: 14),),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddNote())
              );
            },
          ),
        ],
      ),
    ),
      right: 0,
      top: 60,
      width: 110,
      height: 140,)));
  }

  Image getImageWidget(List<String> images) {
    if(images == null || images.isEmpty){
      return Image.asset("image/kaola.jpg",
        width: 60,
        fit: BoxFit.fill,);
    }else{
      return Image.file(File(images[0]),width: 60,height:60,fit: BoxFit.cover,);
    }
  }
}
