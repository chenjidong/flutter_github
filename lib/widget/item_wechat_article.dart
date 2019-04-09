import 'package:flutter/material.dart';
import 'package:flutter_my_tool/view/web/web_view_screen.dart';

import '../bean/wechat_article_bean.dart';

class WechatArticleItem extends StatefulWidget {
  Article article;

  WechatArticleItem(this.article);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WechatArticleState();
  }
}

class _WechatArticleState extends State<WechatArticleItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => WebViewScreen(
                      title: widget.article.title,
                      url: widget.article.link,
                    )));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  widget.article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Colors.grey,
                    size: 15,
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      widget.article.niceDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ))
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              color: Colors.grey,
              height: 0.5,
            )
          ],
        ),
      ),
    );
  }
}
