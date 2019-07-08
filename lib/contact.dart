import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class contact extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: 'https://www.datadiscuss.com/contact/',
      withJavascript: true,
      withLocalStorage: true,
    );
  }
}