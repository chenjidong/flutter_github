import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/bean/user.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/util/shared_preferences_util.dart';
import 'package:flutter_github/common/util/toast_util.dart';
import 'package:flutter_github/view/account/login_screen.dart';
import 'package:flutter_github/view/mine/history_screen.dart';
import 'package:flutter_github/view/mine/repository_screen.dart';
import 'package:flutter_github/view/mine/setting_screen.dart';

///个人中心
class MineScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MineScreenState();
  }
}

class _MineScreenState extends State<MineScreen> {
  bool _isSignIn = false;
  var _list = List();
  User _user;

  void _jumpScreen(Widget screen) async {
    _isSignIn = await SharedPreferencesUtil.getBool(Config.IS_SIGN_IN) ?? false;
    if (_isSignIn) {
      var result = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => screen));
      if (result != null && result) checkUserInfo();
    } else {
      ToastUtil.showToast('请登录后重试');
      var result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginScreen())) ??
          false;

      if (result) {
        setState(() {
          _isSignIn = true;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserInfo();
    _list.add("我的仓库");
    _list.add("关于我们");
    _list.add("意见反馈");
    _list.add("历史记录");
  }

  void checkUserInfo() async {
    var result =
        await SharedPreferencesUtil.getBool(Config.IS_SIGN_IN) ?? false;
    if(result) {
      String str = await SharedPreferencesUtil.get(Config.USER_INFO);
      _user = User.fromJson(jsonDecode(str));
    }
    setState(() {
      _isSignIn = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Mine'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                _jumpScreen(SettingScreen());
              })
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0) {
              if (_isSignIn) {
                return login();
              } else {
                return notLogin();
              }
            } else {
              return getListItem(index - 1, _list[index - 1]);
            }
          },
          separatorBuilder: (context, index) => Divider(
                height: .0,
              ),
          itemCount: _list.length + 1),
    );
  }

  Widget notLogin() {
    return Container(
      height: 200,
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("登录"),
            onPressed: () {
              _jumpScreen(LoginScreen());
            },
          )
        ],
      ),
    );
  }

  Widget login() {
    Widget avatar = Image.asset(
      "assets/logo.jpg",
      height: 80,
    );
    if (_user != null) {
      avatar = Image.network(
        _user.avatar_url,
        width: 80,
        height: 80,
      );
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Center(
            child: ClipOval(
              child: avatar,
            ),
          ),
        ),
        Center(
          child: Text(_user?.name??"--"),
        ),
        Center(
          child: Text(_user?.location??"--"),
        ),
        Container(
          height: 10,
        )
      ],
    );
  }

  Widget getListItem(int index, String value) {
    return GestureDetector(
      onTap: () {
        if (index == 3) {
          _jumpScreen(HistoryScreen());
        } else if (index == 0) {
          _jumpScreen(RepositoryScreen(0));
        } else
          ToastUtil.showToast(value);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      size: 14,
                    ),
                    Text(
                      value,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      value,
                      style: TextStyle(fontSize: 12),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
