import 'note.dart';

class FavoriteData{

  FavoriteData._internal();

  factory() => _getInstance();

  static FavoriteData get instance => _getInstance();

  static FavoriteData _instance;

  static _getInstance(){
    if(_instance == null){
        _instance = new FavoriteData._internal();
    }
    return _instance;
  }

  final _favoriteData = new Set<NoteData>();

  Set<NoteData> get favoriteData => _favoriteData;

  set addFavoriteData(wordPair) {
    _favoriteData.add(wordPair);
  }
}