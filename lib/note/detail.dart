import 'package:flutter/material.dart';
import 'package:flutter1/data/note.dart';
import 'dart:io';
import 'package:flutter_swiper/flutter_swiper.dart';

class Detail extends StatelessWidget {
  // This widget is the root of your application.

  NoteData note;

  Detail(NoteData noteData){
    this.note = noteData;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> list = getImageList(note);

    Widget titleSection = Container(
      padding: EdgeInsets.only(left: 10,right: 32,top: 20,bottom: 5),
      child: Row(
        children: <Widget>[
           Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                        note.note,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                    ),
                  ),
                  Text(
                    _getFormatTime(note.time),
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  )
                ],
              )),
          getIcon(note)
        ],
      ),
    );

    Widget textSection = Container(
      padding: EdgeInsets.only(left: 32,right: 32,bottom: 20,top: 15),
      child: Text(
          note.content,
          textAlign: TextAlign.start,
          softWrap: true,
      ),
    );

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Note"),
        ),

        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              child: getImage(list),
              height: 240,
            ),
            titleSection,
            Divider(height: 1,color: Colors.blueGrey,),
            textSection,
          ],
        )
      ),
    );
  }

  Widget getIcon(NoteData noteData){
    if(noteData.isFavorite){
      return Icon(
        Icons.star,
        color: Colors.red,
      );
    }else{
      return Icon(
        Icons.star,
        color: Colors.grey,
      );
    }
  }

  String _getFormatTime(time) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    var timeString = "${dateTime.year.toString()}"
        "-${dateTime.month.toString().padLeft(2, "0")}"
        "-${dateTime.day.toString().padLeft(2, "0")}";

    return timeString;
  }

  Widget getImage(List<Widget> list) {
    return Swiper(
      itemCount: list.length < 4 ? list.length:4,
      itemHeight: 240,
      containerHeight: 240,
      itemBuilder: (BuildContext buildContext,int index){return list[index];},
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.black54,
              activeColor: Colors.white
          )
      ),
      controller: SwiperController(),
      scrollDirection: Axis.horizontal,
      autoplay: true,
      onTap: (index) => print('点击了第$index'),
    );
  }

  List<Widget> getImageList(NoteData note) {
    List<Widget> list = [];
    var images = note.noteImages.images;
    if(images == null || images.isEmpty){
      list.add(Image.asset(
        "image/kaola.jpg",
        height: 240,
        fit: BoxFit.cover));
      return list;
    }
    for(var image in images){
      list.add(Image.file(
        File(image),
        height: 240,
        fit: BoxFit.cover,
      ));
    }
    print("list size = ${list.length}");
    return list;
  }
}