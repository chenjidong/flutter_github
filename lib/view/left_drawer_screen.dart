import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_github/bean/user.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/util/shared_preferences_util.dart';

class LeftDrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LeftDrawerScreenState();
  }
}

class _LeftDrawerScreenState extends State<LeftDrawerScreen> {
  User _user;
  bool _signin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    var signin =
        await SharedPreferencesUtil.getBool(Config.IS_SIGN_IN) ?? false;
    if (signin) {
      String str = await SharedPreferencesUtil.get(Config.USER_INFO);
      _user = User.fromJson(jsonDecode(str));
    }
    setState(() {
      _signin = signin;
    });
  }

  @override
  Widget build(BuildContext context) {
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
    // TODO: implement build
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipOval(
                        child: avatar,
                      ),
                    ),
                    Text(
                      _user?.login ?? "--",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add Account'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Setting'),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
