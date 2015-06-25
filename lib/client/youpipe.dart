library youpipe;

import 'yp_app.dart';
import 'client_api.dart';
import 'package:polymer_expressions/filter.dart';
import 'dart:html';
import 'dart:convert';
import 'yp_app_pipe.dart';
part 'router.dart';

class Youpipe{
  static YPApp app;
  static YoupipeApi api;
  static String locale = window.navigator.language.toLowerCase().substring(0,2);
}

class Internationalization extends Transformer<String, int>{
  String forward(int i){
    return Translations.get[i];
  }
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class Translations {
  static Map<int,String> _default = {
    0:"v1",
    1:"Home",
    2:"Popular",
    3:"Recent",
    4:"Sign in with Google",
    5:"New pipe",
    6:"My channel",
    7:"History",
    8:"Favorites",
    9:"Settings",
    10:"Signout",
    11:"Sign in"
  };

  static final List<String> _availableTranslations = ['fr'];

  static Map get get{
    if(!inited)
      _init();
    return _default;
  }

  static bool inited = false;

  static void _init() {
    print(Youpipe.locale);
    inited = true;
    if (Youpipe.locale != 'en') {
      if(!_loadFromStorage())
        _downloadTranslation();
    }
    print(_default.toString());
  }

    static bool _loadFromStorage(){
      if(!window.localStorage.containsKey('locales_'+Youpipe.locale))
        return false;
      else {
        Map<int,String> m = JSON.decode(window.localStorage['locales_'+Youpipe.locale]);
        if(m["0"] != _default[0])
          return false;
        else
          m.forEach((k,v)=>_default[int.parse(k)]=v);
      }
      return true;
    }

  static void _downloadTranslation(){
    if(_availableTranslations.contains(Youpipe.locale))
    HttpRequest.getString('/locales/'+Youpipe.locale+'.json').then((String r){
      window.localStorage['locales_'+Youpipe.locale] = r;
      _loadFromStorage();
    });
  }

}