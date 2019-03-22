import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_my_tool/view/account/login_screen.dart';
import '../../util/toast_util.dart';

///个人中心
class MineScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MineScreenState();
  }
}

class _MineScreenState extends State<MineScreen> {
  SharedPreferences _sharedPreferences;

  void _setting() async {
    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();

    bool isSignin = _sharedPreferences.getBool("is_signin");
    if (isSignin ?? false) {
      ToastUtil.showToast('正在跳转设置界面');
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
    );
  }
}
