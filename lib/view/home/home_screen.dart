import 'package:flutter/material.dart';
import 'package:flutter_github/bean/home_article_bean.dart';
import 'package:flutter_github/bean/home_banner_bean.dart';
import 'package:flutter_github/common/api/api.dart';
import 'package:flutter_github/common/http/http_manager.dart';
import 'package:flutter_github/widget/item_home_article.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///首页
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  List<HomeBanner> banners; //广告
  List<Article> articles; //文章

  SwiperController _bannerController;
  ScrollController _scrollController;

  int _page = 0; //请求页码

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    banners = List();
    articles = List();

    getBanner();
    getList(false);

    _bannerController = SwiperController();
    _scrollController = ScrollController();

    _bannerController.autoplay = true;
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;

      if (maxScroll == pixels) {
        _page++;
        getList(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.builder(
      itemBuilder: (context, index) {
        return index == 0
            ? createBannerItem()
            : HomeArticleItem(articles[index - 1]);
      },
      itemCount: articles.length + 1,
      controller: _scrollController,
    );
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('推荐文章'),
        centerTitle: true, //设置标题是否局中
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Icon(Icons.dashboard),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () {})
        ],
      ),
      body: RefreshIndicator(child: listView, onRefresh: _pullToRefresh),
    );
  }

  Future<Null> _pullToRefresh() async {
    _page = 0;
    await getList(false);
    return null;
  }

  /// 获取首页推荐文章数据
  Future<Null> getList(bool loadMore) async {
    var data = await httpManager.get(Api.getHomeArticle(_page), null);
    var homeArticleBean = HomeArticleBean.fromJson(data);
    setState(() {
      if (loadMore) {
        articles.addAll(homeArticleBean.data.datas);
      } else {
        articles.clear();
        articles.addAll(homeArticleBean.data.datas);
      }
    });
  }

  //获取广告内容
  void getBanner() async {
    var data = await httpManager.get(Api.getHomeBanner(), null);
    var homeBannerBean = HomeBannerBean.fromJson(data);

    setState(() {
      banners.clear();
      banners.addAll(homeBannerBean.data);
    });
  }

  ///广告item
  Widget createBannerItem() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        child: banners.length != 0
            ? Swiper(
                itemCount: banners.length,
                autoplayDelay: 3500,
                controller: _bannerController,
                itemWidth: MediaQuery.of(context).size.width,
                itemHeight: 180,
                pagination: pagination(),
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    banners[index].imagePath,
                    fit: BoxFit.fill,
                  );
                },
                viewportFraction: 0.8,
                scale: 0.8,
              )
            : SizedBox(
                width: 0,
                height: 0,
              ));
  }

  ///指示器
  SwiperPagination pagination() => SwiperPagination(
      margin: EdgeInsets.all(0),
      builder: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
        return Container(
          color: Colors.black45,
          height: 40,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: <Widget>[
              Text(
                "${banners[config.activeIndex].title}",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: DotSwiperPaginationBuilder(
                            color: Colors.white70,
                            activeColor: Colors.green,
                            size: 6.0,
                            activeSize: 6.0)
                        .build(context, config),
                  ))
            ],
          ),
        );
      }));

  @override
  bool get wantKeepAlive => true;
}
