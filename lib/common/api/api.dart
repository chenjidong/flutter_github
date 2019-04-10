class Api {
  static const String hostApi = "https://api.github.com/";
  static const String hostWeb = "https://github.com/";

  static const String articleApi = "http://www.wanandroid.com/";

  /// 获取首页文章列表 get
  static getHomeArticle(page) {
    return "${articleApi}article/list/$page/json";
  }

  /// 获取首页Banner
  static getHomeBanner() {
    return "${articleApi}banner/json";
  }

  /// 获取微信文章列表
  static getWechatArticle(cid, page) {
    return "${articleApi}wxarticle/list/$cid/$page/json";
  }

  /// 获取推荐微信公众号
  static getWechat() {
    return "${articleApi}wxarticle/chapters/json";
  }
}
