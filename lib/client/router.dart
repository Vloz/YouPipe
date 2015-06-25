part of youpipe;


class Router{
  static String _baseUrl='';
  static String init(){
    _baseUrl =window.location.protocol+'//'+window.location.hostname+(window.location.pathname.startsWith('/dev/')?'/dev':'');
    window.onHashChange.listen((_){
      updateView();
    });
    updateView();
  }

  static void updateView(){
    if(!window.location.href.contains('#'))
      _home();
    else{
      String path = window.location.href.substring(window.location.href.indexOf('#')+1).toLowerCase();
      print(path);
      List<String> parts = path.split('/');
      switch(parts[0].trim()){
        case '':
          _home();
          break;
        case 'new':
          _newPipe();
          break;
        default:
      }
    }
  }

  static void _home(){
    Youpipe.app.bodyPages.selected = 'list';
  }

  static void _newPipe(){
    Youpipe.app.bodyPages.selected = 'pipe';
    Youpipe.app.pipePage.queryContext('new');
  }


}