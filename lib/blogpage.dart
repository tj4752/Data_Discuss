import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class blogpage extends StatelessWidget {
  var content;

  blogpage({Key key, @required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: content['url'],
      withJavascript: true,
      withLocalStorage: true,
    );
  }
}
