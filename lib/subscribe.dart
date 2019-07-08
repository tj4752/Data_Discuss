import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class subscribe extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: 'https://www.datadiscuss.com/subscribe/',
      withJavascript: true,
      withLocalStorage: true,
    );
  }
}