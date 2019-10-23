import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/util/shared_preferences_util.dart';
import 'package:flutter_github/common/util/toast_util.dart';
import 'package:flutter_github/view/account/login_screen.dart';
import 'package:flutter_github/view/mine/history_screen.dart';
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

  void _setting() async {
    _isSignIn = await SharedPreferencesUtil.get(Config.IS_SIGN_IN);
    if (_isSignIn ?? false) {
//      ToastUtil.showToast('正在跳转设置界面');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SettingScreen()));
    } else {
      ToastUtil.showToast('请登录后重试');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _list.add("关于我们");
    _list.add("意见反馈");
    _list.add("历史记录");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Mine'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: _setting)
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0) {
              if (_isSignIn ?? false) {
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
              setState(() {
                _isSignIn = true;
              });
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
          child: Text("Github"),
        ),
        Center(
          child: Text("this is description ..."),
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
        ToastUtil.showToast(value);
        if (index == 2) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HistoryScreen()));
        }
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
