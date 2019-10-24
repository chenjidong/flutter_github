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

  ///获取授权  post
  static getAuthorization() {
    return "${hostApi}authorizations";
  }

  ///我的用户信息 GET
  static getMyUserInfo() {
    return "${hostApi}user";
  }

  ///用户信息 get
  static getUserInfo(userName) {
    return "${hostApi}users/$userName";
  }

  ///用户的star get
  static userStar(userName, sort) {
    sort ??= 'updated';
    return "${hostApi}users/$userName/starred?sort=$sort";

  }
}
