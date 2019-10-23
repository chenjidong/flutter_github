import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///历史记录
class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HistoryScreenState();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> _list;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("历史记录"),
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
    for (var i = 0; i < 10; i++) {
      _list.add(i.toString());
    }
  }

  listItem(int index) {
    Widget avatar = Image.asset(
      "assets/logo.jpg",
      height: 40,
    );
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
                      "仓库名称",
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
                            "用户名",
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
                  "java",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: Text(
                "描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述",
                style: TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _bottomMenuItem(Icons.star, "菜单"),
                _bottomMenuItem(Icons.all_inclusive, "菜单1"),
                _bottomMenuItem(Icons.share, "菜单2"),
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
