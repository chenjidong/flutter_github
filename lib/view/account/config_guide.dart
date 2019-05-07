import 'package:flutter/material.dart';

/**
 * 配置 appid secret 引导
 */
class ConfigGuideScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ConfigGuideState();
  }
}

class _ConfigGuideState extends State<ConfigGuideScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('如何获取'),
          centerTitle: true,
          leading: Builder(builder: (context) {
            return IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop(this);
                });
          }),
        ),
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            new Image.asset('assets/config/register0.jpg', scale: 2.0, fit: BoxFit.cover),
            new Image.asset('assets/config/register1.jpg', scale: 2.0, fit: BoxFit.cover)
          ],
        )));
  }
}
