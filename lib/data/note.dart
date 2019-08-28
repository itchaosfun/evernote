
class NoteData{

  String note;
  String content;
  num time;
  int id;
  String noteId;
  bool isFavorite;
  NoteImages noteImages = NoteImages();

  NoteData();

  @override
  String toString() {
    return "id = $id, note = $note";
  }

  Map<String,Object> toJson(){
    Map data = new Map<String,Object>();

    data["id"] = id;
    data["note"] = note;
    data["noteId"] = "note${DateTime.now().millisecondsSinceEpoch}";
    data["time"] = time;
    data["content"] = content;
    data["isFavorite"] = isFavorite;
    data["imageList"] = imageListToString();

    return data;

  }

  NoteData.fromSql(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    noteId = json['noteId'];
    content = json['content'];
    isFavorite = json['isFavorite'] == "1";
    time = json['time'];
    String imageJson = json['imageList'];
    print("imageJson = $imageJson");

    var list = imageJson.split(",");
    if(list != null && list.isNotEmpty){
      noteImages.images = list;
    }

    print("json = ${json.toString()}");
  }

  String imageListToString() {
    if(noteImages.images.isEmpty){
      return "";
    }
    print("imageList size = ${noteImages.images.length}");

    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.writeAll(noteImages.images,",");
    return stringBuffer.toString();
  }
}

class NoteImages{
    List<String> images = [];
}
