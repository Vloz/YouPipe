import 'package:polymer/polymer.dart';
import 'package:youpipe/client/youpipe.dart';
import 'dart:html';
import 'package:comid/codemirror.dart' as comid;
import 'package:comid/addon/mode/dart.dart';
import 'package:comid/addon/edit/matchbrackets.dart';
import 'package:comid/addon/edit/closebrackets.dart';
import 'package:youpipe/client/client_api.dart';
import 'package:core_elements/core_selector.dart';
import 'dart:js';
import 'package:paper_elements/paper_item.dart';

@CustomTag('yp-editor')
class YPEditor extends PolymerElement {

  comid.CodeMirror editor;
  @published ObservableList<Source> sources;
  @observable bool showEditor = false;
  CoreSelector filetree;

  YPEditor.created() : super.created(){
  }

  ready(){
    filetree = $['file-tree'];

    print("parent="+this.parent.toString());
    DartMode.initialize();
    initializeBracketMatching();
    initializeBracketClosing();
    var ele = shadowRoot.querySelector('#code');
    editor = new comid.CodeMirror(ele , {
      'lineNumbers': true,
      'matchBrackets': true,
      'autoCloseBrackets': true,
      'mode': "application/dart"
    });
  }

  @observable String currentFileOpen = '';

  void changeDisplayedSource(Event e, var details, Node target){
    String newPath =  (filetree.selectedItem as PaperItem).attributes['label'];
    if(currentFileOpen!='' && sources.any((s)=>s.fullPath==currentFileOpen))
    {
      Source previous = sources.firstWhere((s)=>s.fullPath==currentFileOpen);
      previous.body = editor.getValue();
    }
    if(sources.any((s)=> s.fullPath == newPath))
    {
      editor.setValue(sources.firstWhere((s)=> s.fullPath == newPath).body);
      currentFileOpen = newPath;
    }
    else
      throw new Exception('Can\'t find source file to display:'+newPath);
    editor.refresh();
    editor.focus();

  }

}