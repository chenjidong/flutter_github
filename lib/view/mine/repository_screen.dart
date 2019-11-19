import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/common/api/user_api.dart';
import 'package:flutter_github/common/bean/Repository.dart';
import 'package:flutter_github/common/bean/User.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/util/shared_preferences_util.dart';

///github 项目列表
class RepositoryScreen extends StatefulWidget {
  int type;

  RepositoryScreen(this.type);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RepositoryScreenState(type);
  }
}

class _RepositoryScreenState extends State<RepositoryScreen> {
  List<Repository> _list;
  int type;
  int _page = 1;
  User _user;

  _RepositoryScreenState(this.type);

  @override
  Widget build(BuildContext context) {
    String text = "";
    if (type == 0) {
      text = "我的仓库";
    }
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(text),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return listItem(index);
        },
        itemCount: _list.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _list = List();


    getUserInfo();
  }

  void getUserInfo() async {
    String str = await SharedPreferencesUtil.get(Config.USER_INFO);
    _user = User.fromJson(jsonDecode(str));
    if (_page == 1) {
      getData();
    }
  }

  void getData() async {
    UserApi.getUserRepos(_user.login, 'pushed', _page).then((res) {
      if (res != null && res.result) {
        setState(() {
          _list.addAll(res.data);
        });
      }
    });
  }

  listItem(int index) {
    Widget avatar = Image.asset(
      "assets/logo.jpg",
      height: 40,
    );
    var item = _list[index];
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: ClipOval(
                    child: avatar,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                     item.name??"",
                      style: TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.account_circle,
                            size: 14,
                          ),
                          Text(
                            _user.login??"",
                            style: TextStyle(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        ],
                      ),
                    )
                  ],
                )),
                Text(
                  item.language??"",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: Text(
                item.description??"",
                style: TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _bottomMenuItem(Icons.star, item.watchersCount.toString()),
                _bottomMenuItem(Icons.all_inclusive, item.forksCount.toString()),
                _bottomMenuItem(Icons.share, "..."),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _bottomMenuItem(IconData icon, String text) {
    return Expanded(
        flex: 2,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 14,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ));
  }
}
