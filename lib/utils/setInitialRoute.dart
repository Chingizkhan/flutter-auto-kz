import 'package:flutter_projects/components/navigation/NavigationConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialRoute {
  SharedPreferences? _prefs = null;

  init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
  
  get() {
    if (_prefs != null) {
      switch (_prefs!.getBool('isAuthed')) {
        case true: {
          return NavigationConfig.main;
        }
        case false: {
          return NavigationConfig.login;
        }
      }
    }
  }
}