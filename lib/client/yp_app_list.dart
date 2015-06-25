import 'package:polymer/polymer.dart';
import 'package:youpipe/client/client_api.dart';


@CustomTag('yp-app-list')
class YPAppList extends PolymerElement {

  @observable ObservableList data;

  YPAppList.created() : super.created(){
  }

  ready(){
    data = toObservable([
      new Pipe(),
      new Pipe(),
      new Pipe(),
      new Pipe(),
      new Pipe(),
      new Pipe()
    ]);
  }
}


class Person extends Observable {
  // mandatory field
 // @observable int index;
  // mandatory field
  //@observable bool selected;
  //model
  Person();
}