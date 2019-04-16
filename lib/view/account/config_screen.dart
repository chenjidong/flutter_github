import 'package:flutter/material.dart';
import 'package:flutter_github/common/util/toast_util.dart';

/// appid secret 配置界面
class ConfigScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ConfigScreenState();
  }
}

class _ConfigScreenState extends State<ConfigScreen> {
  TextEditingController _appidController, _secretController;
  FocusNode _appidFocus, _secretFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appidController = TextEditingController();
    _secretController = TextEditingController();
    _appidFocus = FocusNode();
    _secretFocus = FocusNode();
  }

  void _save() {
    ///
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
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
          const SizedBox(
            height: 80,
          ),
          Center(
            child: Text(
              '设置 appid 和 secret',
              style: TextStyle(fontSize: 32),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              child: TextField(
                focusNode: _appidFocus,
                controller: _appidController,
                obscureText: false,
                textInputAction: TextInputAction.next,
                onSubmitted: (input) {
                  _appidFocus.unfocus();
                  FocusScope.of(context).requestFocus(_appidFocus);
                },
                decoration: InputDecoration(labelText: 'appid'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              child: TextField(
                focusNode: _secretFocus,
                controller: _secretController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (input) {
                  _secretFocus.unfocus();
                  //保存appid
                  _save();
                },
                decoration: InputDecoration(labelText: 'secret'),
              ),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            onTap: () {
              ToastUtil.showToast('一会告诉你~');
            },
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    '如何填写？',
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ))
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child:
                          RaisedButton(onPressed: _save, child: Text('Save'))))
            ],
          ),
        ],
      )),
    );
  }
}
