import 'package:flutter/material.dart';

import '../bean/home_article_bean.dart';
import '../view/web/web_view_screen.dart';

///首页文章列表 item
class HomeArticleItem extends StatefulWidget {
  Article article;

  HomeArticleItem(this.article);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeArticleState();
  }
}

class _HomeArticleState extends State<HomeArticleItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (wvp) => WebViewScreen(
                    url: widget.article.link, title: widget.article.title)));
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(2, 5, 2, 0),
        child: Container(
          padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.child_care,
                    color: Colors.blueAccent,
                    size: 18,
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.article.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ))
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    widget.article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
