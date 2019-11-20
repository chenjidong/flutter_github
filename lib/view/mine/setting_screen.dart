import 'package:flutter/material.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/util/toast_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingState();
  }
}

class _SettingState extends State<SettingScreen> {
  /// 退出登录
  void _logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(Config.IS_SIGN_IN, false);
    sharedPreferences.setString(Config.USER_INFO, null);
    ToastUtil.showToast('退出成功！');
    Navigator.of(context).pop(true);
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
                Navigator.of(context).pop(false);
              });
        }),
      ),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                ToastUtil.showToast('已经是最新版本');
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    color: Colors.blue,
                    size: 18,
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          '版本号：',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      )),
                  Text(
                    '1.0.0',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue,
                    size: 12,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        _logout();
                      },
                      color: Colors.red,
                      child: Text(
                        '退出登录',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
