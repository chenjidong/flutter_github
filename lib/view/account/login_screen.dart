import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_github/common/util/toast_util.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _nameController, _pwdController;
  FocusNode _nameFocus, _pwdFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _pwdController = TextEditingController();
    _nameFocus = FocusNode();
    _pwdFocus = FocusNode();
  }

  ///请求登录
  Future _login() async {
    var name = _nameController.text;
    var pwd = _pwdController.text;
    if (name == '' || pwd == '') {
      ToastUtil.showToast('账户名/密码不能为空');

      return;
    }

    ToastUtil.showToast('登录成功');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('is_signin', true);
    Navigator.of(context).pop(this);
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
              'Login',
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
                focusNode: _nameFocus,
                controller: _nameController,
                obscureText: false,
                textInputAction: TextInputAction.next,
                onSubmitted: (input) {
                  _nameFocus.unfocus();
                  FocusScope.of(context).requestFocus(_pwdFocus);
                },
                decoration: InputDecoration(labelText: 'name'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              child: TextField(
                focusNode: _pwdFocus,
                controller: _pwdController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (input) {
                  _pwdFocus.unfocus();
                  //登录
                  _login();
                },
                decoration: InputDecoration(labelText: 'password'),
              ),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                onPressed: _login,
                child: Text('Login'),
                color: Colors.white,
              )
            ],
          )
        ],
      )),
    );
  }
}
