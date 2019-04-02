import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///加载 html
class WebViewScreen extends StatefulWidget {
  String url = "";
  String title = "";

  WebViewScreen({this.url, @required this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WebViewState();
  }
}

class _WebViewState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: false,
        withLocalStorage: true,
        hidden: true,
        withJavascript: true,
      ),
    );
  }
}
