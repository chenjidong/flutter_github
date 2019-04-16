import 'package:flutter/material.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/util/shared_preferences_util.dart';
import 'package:flutter_github/common/util/toast_util.dart';
import 'package:flutter_github/view/account/login_screen.dart';
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
  void _setting() async {
    bool isSignin = await SharedPreferencesUtil.get(Config.IS_SIGN_IN);
    if (isSignin ?? false) {
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
