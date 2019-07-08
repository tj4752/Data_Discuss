import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class authors extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: 'https://www.datadiscuss.com/authors/',
      withJavascript: true,
      withLocalStorage: true,
    );
  }
}