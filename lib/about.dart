import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class about extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: 'https://www.datadiscuss.com/about/',
      withJavascript: true,
      withLocalStorage: true,
    );
  }
}