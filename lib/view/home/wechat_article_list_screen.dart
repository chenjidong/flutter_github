import 'package:flutter/material.dart';

import '../../bean/wechat_article_bean.dart';
import '../../manager/api_manager.dart';
import '../../widget/item_wechat_article.dart';

class WechatArticleListScreen extends StatefulWidget {
  int cid = 0;

  WechatArticleListScreen({@required this.cid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WechatArticleListState();
  }
}

class _WechatArticleListState extends State<WechatArticleListScreen>
    with SingleTickerProviderStateMixin {
  int index = 1;
  List<Article> articles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articles = List();

    getList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemBuilder: (BuildContext context, int pos) {
        return WechatArticleItem(articles[pos]);
      },
      itemCount: articles.length,
    );
  }

  void getList() async {
    await ApiManager().getWechatArticle(widget.cid, index).then((response) {
      if (response != null) {
        var bean = WechatArticleBean.fromJson(response.data);
        setState(() {
          articles.addAll(bean.data.datas);
        });
      }
    });
  }

  @override
  // TODO: implement mounted
  bool get wantKeepAlive => true;
}
