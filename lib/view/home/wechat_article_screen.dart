import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../bean/wechat_bean.dart';
import '../../manager/api_manager.dart';
import '../../widget/async_snapshot_widget.dart';
import 'wechat_article_list_screen.dart';

///公总号 列表
class WechatArticleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WechatArticleState();
  }
}

class _WechatArticleState extends State<WechatArticleScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var _tabsName = List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      builder: _buildFuture,
      future: getWechat(),
    );
  }

  ///异步获取数据
  Widget _buildFuture(
      BuildContext context, AsyncSnapshot<List<Wechat>> snapshot) {
    return AsyncSnapshotWidget(
        snapshot: snapshot,
        successWidget: (snapshot) {
          if (snapshot.data != null) {
            _parseWechat(snapshot.data);

            if (_tabController == null) {
              _tabController = TabController(
                  length: snapshot.data.length, vsync: this, initialIndex: 0);
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('公众号'),
                backgroundColor: Colors.blue,
                centerTitle: true,
              ),
              body: Column(
                children: <Widget>[
                  TabBar(
                    tabs: _createTabs(),
                    indicatorColor: Colors.deepPurpleAccent,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black12,
                    controller: _tabController,
                    isScrollable: true,
                  ),
                  Expanded(
                      flex: 1,
                      child: TabBarView(
                        children: _createPages(snapshot.data),
                        controller: _tabController,
                      ))
                ],
              ),
            );
          }
        });
  }

  ///文章列表
  List<Widget> _createPages(List<Wechat> list) {
    List<Widget> widgets = List();
    for (Wechat wechat in list) {
      widgets.add(WechatArticleListScreen(cid: wechat.id));
    }
    return widgets;
  }

  ///顶部 tab
  List<Widget> _createTabs() {
    List<Widget> widgets = List();
    for (String item in _tabsName) {
      widgets.add(Tab(
        text: item,
      ));
    }
    return widgets;
  }

  ///获取公众号
  void _parseWechat(List<Wechat> list) {
    _tabsName.clear();
    for (Wechat wechat in list) {
      _tabsName.add(wechat.name);
    }
  }

  ///获取微信公总号
  Future<List<Wechat>> getWechat() async {
    Response response;
    await ApiManager().getWechat().then((res) {
      response = res;
    });
    return WechatBean.fromJson(response.data).data;
  }
}
