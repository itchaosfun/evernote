import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesUtil{

  static SharePreferencesUtil sSharePreferencesUtil;

  static getInstance(){
    if(sSharePreferencesUtil == null){
      sSharePreferencesUtil = SharePreferencesUtil();
    }
  }
}