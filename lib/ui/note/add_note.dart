import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter1/platform/widget/tips_dialog.dart';
import '../../data/note.dart';
import 'package:flutter1/common/note_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AddNoteStatefulWidget();
  }
}

class AddNoteStatefulWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddNoteState();
  }
}

class AddNoteState extends State<AddNoteStatefulWidget>{
  String _noteContent = "";
  String _noteTitle = "";
  List<String> imageList = [];
  List<Widget> imageWidgetList = [];
  File imgPath;

  @override
  Widget build(BuildContext context) {

    var titleTextField = TextField(
      autofocus: false,
      maxLines: 1,
      maxLength: 20,
      decoration: InputDecoration(
          hintText: "请输入笔记标题",
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blueGrey, width: 1.0, style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          contentPadding: EdgeInsets.all(15)
      ),

      onChanged: (text) {
        _noteTitle = text;
        setState(() {
        });
      },
    );

    var contentTextField = TextField(
      maxLines: 10,
      maxLength: 800,
      autofocus: false,
      decoration: InputDecoration(
          hintText: "请输入笔记内容",
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blueGrey, width: 1.0, style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          )
      ),
      onChanged: (text) {
        _noteContent = text;
        setState(() {
        });
      },
    );

    var addImage = IconButton(
        padding: EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        icon: Icon(Icons.add),
        iconSize: 80,
        onPressed: (){
          this.selectImage();
        });

    if(imageWidgetList.isEmpty){
      imageWidgetList.add(addImage);
    }

    return new MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blueGrey
      ),
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("Add Note"),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.done),
                onPressed: submit)
          ],
        ),

        body: Container(
          child: ListView(
            padding: EdgeInsets.only(top: 15),
            children: <Widget>[
              titleTextField,
              contentTextField,
              loadImage()
            ],
          ),
        ),
      ),
    );
  }

  Widget loadImage(){
    print("刷新gridView: list length = ${imageWidgetList.length}");
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 7/9
      ),
      itemCount: imageWidgetList.length,
      itemBuilder: (BuildContext context, int index) {
        return imageWidgetList[index];
      },
    );
  }

  submit() async {
    print("title = $_noteTitle , content = $_noteContent");

    if (_noteTitle
        .trim()
        .isEmpty) {
      Fluttertoast.showToast(
          msg: "笔记标题不能为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );
      return;
    }

    if (_noteContent
        .trim()
        .isEmpty) {
      Fluttertoast.showToast(
          msg: "笔记内容不能为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );
      return;
    }

    NoteData noteData = new NoteData();
    noteData.note = _noteTitle;
    noteData.content = _noteContent;
    noteData.isFavorite = false;
    noteData.time = DateTime
        .now()
        .millisecondsSinceEpoch;

    noteData.noteImages.images = imageList;

    await NoteManager.getInstance().addNewNote(noteData);
    showDialog(
        context: context,
        builder: (BuildContext buildContext){
          return TipsDialogWidget("新增成功！\n正在为您跳转...", 3, (){
            Navigator.of(context).pop();
          });
        }
    );
  }

  void selectImage()async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image == null){
      return;
    }
    print(image.path);
    imageList.add(image.path);
    imageWidgetList.add(Image.file(image,width: 100,height: 100,fit: BoxFit.fill,));
    setState(() {});
  }
}
