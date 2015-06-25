import 'package:polymer/polymer.dart';
import 'package:youpipe/client/youpipe.dart';
import 'dart:html';
import 'package:youpipe/client/client_api.dart';
import 'package:youpipe/client/youpipe.dart';

@CustomTag('yp-app-pipe')
class YPAppPipe extends PolymerElement {
  @observable bool loadEditor = false;
  @observable bool sourcesDownloaded = false;

  @observable String pmode = 'pic';

  @observable int selectedTab = 0;

  ///Short_id used to query the pipe, could be header only
  @observable String queried_pipe_id ='';

  @observable ObservableList<Source> sources = new  ObservableList();

  ///Pipe info for this page
  @observable Pipe pipe_context;

  YPAppPipe.created() : super.created(){
  }

  void queryContext(String query){
    if(query=='new') {
      sources.add(Pipe_Page_Context.createDefaultSource());
      sourcesDownloaded=true;
      pipe_context = Pipe_Page_Context.createNewPipe();
      queried_pipe_id = 'new';
    }
    else{
      Youpipe.api.pipe.get(query).then((p){
        pipe_context = p;
        queried_pipe_id = p.shortId;
      }).catchError((e)=>print('error while downloading page context:'+e));
    }
  }

  void EditSourceCode_click(){
    if(!loadEditor)
      loadEditor = true;
    pmode = "dev";
  }

  void ShowPipePicture_click(){
    pmode = "pic";
  }

  void ShowPipeOutput_click(){
    pmode = "out";
  }
}

class Pipe_Page_Context{
  ///Return a context for a new Pipe
  static Pipe createNewPipe(){
    return new Pipe()
    ..active = true
    ..category = 0
    ..description =''
    ..initialCreated = new DateTime.now()
    ..lastPublicVersionShortId = ''
    ..pipeCommentsCount = 0
    ..public = true
    ..shortId ='new'
    ..sources = ['/new/main.dart']
    ..title = ''
    ..totalThumbsDown = 0
    ..totalThumbsDown = 0
    ..totalUses = 0
    ..versionCommentsCount = 0
    ..versionThumbsDown = 0
    ..versionThumbsUp = 0
    ..versionUses = 0
    ..versionCreated = new DateTime.now();

  }

  ///Generate a default main file for new pipe
  static Source createDefaultSource()=>
  new Source()..fullPath='/new/main.dart'
  ..body='''
void main(){
  print('hello output!');
}
  ''';
}