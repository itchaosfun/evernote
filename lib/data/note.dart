import '../common/user_manager.dart';

class NoteData{

  int id;
  String noteId;
  String ownerId;
  String note;
  String content;
  num time;
  bool isFavorite;
  NoteImages noteImages = NoteImages();

  NoteData();

  @override
  String toString() {
    return "id = $id, noteId = $noteId, note = $note";
  }

  Map<String,Object> toJson(){
    Map data = new Map<String,Object>();
    if(id != null){
      data["id"] = id;
    }
    data["noteId"] = "note${DateTime.now().millisecondsSinceEpoch}";
    data["ownerId"] = UserManager.getInstance().userId;
    data["note"] = note;
    data["time"] = time;
    data["content"] = content;
    data["isFavorite"] = isFavorite;
    data["imageList"] = imageListToString();

    print(data);

    return data;

  }

  NoteData.fromSql(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    noteId = json['noteId'];
    ownerId = json['ownerId'];
    content = json['content'];
    isFavorite = json['isFavorite'] == "1";
    time = json['time'];

    String imageJson = json['imageList'];

    var list = imageJson.split(",");
    if(list != null && list.isNotEmpty){
      noteImages.images = list;
    }
  }

  String imageListToString() {
    if(noteImages.images.isEmpty){
      return "";
    }
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.writeAll(noteImages.images,",");
    return stringBuffer.toString();
  }
}

class NoteImages{
    List<String> images = [];
}
