import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:youpipe/client/youpipe.dart';
import 'dart:html';
import "package:googleapis_auth/auth_browser.dart";
import 'package:googleapis/oauth2/v2.dart';
import "package:http/browser_client.dart" as http;
import 'dart:convert';
import 'package:youpipe/client/client_api.dart';
import 'package:polymer_expressions/filter.dart';
import 'package:core_elements/core_selector.dart';
import 'package:core_elements/core_pages.dart';
import 'yp_app_pipe.dart';


@CustomTag('yp-app')
class YPApp extends PolymerElement {

  static Oauth2Api oauth2_api;
  @observable User user;
  @observable bool isAuthenticated = false;
  CoreSelector menuSelector;
  CorePages bodyPages;
  YPAppPipe pipePage;

  final List<MenuItem> menuItems = const [
    const MenuItem(1, '/', 'home', isDefault: true),
    const MenuItem(2, '/popular','star'),
    const MenuItem(3, '/recent','schedule'),
    const MenuItem(5, '/new_pipe','add-box'),
    const MenuItem(6, '/my_channel','account-circle'),
    const MenuItem(7, '/history','history'),
    const MenuItem(8, '/favorites','favorite'),
    const MenuItem(9, '/settings','settings')
  ];



  ClientId clientid = new ClientId('34597979074-mb7ad26a3b72kl6mqnpicnfin86r4srr.apps.googleusercontent.com','null');
  var scopes = ["https://www.googleapis.com/auth/plus.me", "https://www.googleapis.com/auth/userinfo.email"];


  YPApp.created() : super.created(){
    menuSelector = $['main-menu'];
    bodyPages = $['body-pages'];
    pipePage = $['pipe-page'];
    Youpipe.app=this;
    Router.init();

    if(window.localStorage.containsKey('user'))
      user = new User.fromJson(JSON.decode(window.localStorage['user']));
    Youpipe.api = new YoupipeApi(new http.BrowserClient());
    createImplicitBrowserFlow(clientid, scopes).then(
            (BrowserOAuth2Flow flow) => this.shadowRoot.querySelector('#signinmenuitem').on['click'].listen(
                (_)=>authenticate(flow,true)
        )
    );
  }

  domReady() {

  }

  void authenticate(var flow, [bool forcePrompt = false]){
      flow.clientViaUserConsent(immediate:!forcePrompt && window.localStorage.containsKey('user')).then((AuthClient client) {
        oauth2_api = new Oauth2Api(client);
        oauth2_api.userinfo.get().then((m){
          var new_user = new User()
            ..nick = m.name
            ..picture = m.picture
            ..plusUrl = m.link;
          Youpipe.api = new YoupipeApi(client);
          Youpipe.api.user.sign(new_user).then((returned_user){
            print(returned_user.toJson().toString());
            user = returned_user;
            isAuthenticated=true;
            window.localStorage['user']=JSON.encode(user.toJson());
          });
        });
      });
  }

  void onSignoutClick(Event event, Object object, var target) {
    window.localStorage.remove('user');
    user = null;
  }

  final Transformer i18n = new Internationalization();
}


class MenuItem {
  final int nameID;
  final String path;
  final String icon;
  final bool isDefault;
  const MenuItem(this.nameID, this.path, this.icon, {this.isDefault: false});
}


