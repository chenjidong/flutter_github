import 'dart:convert';

import 'package:flutter_github/common/api/api.dart';
import 'package:flutter_github/common/bean/Repository.dart';
import 'package:flutter_github/common/bean/User.dart';
import 'package:flutter_github/common/bean/data_result.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/config/ignore_config.dart';
import 'package:flutter_github/common/http/http_manager.dart';
import 'package:flutter_github/common/util/shared_preferences_util.dart';

class UserApi {
  /// github oauth apps 授权方式
  static login(userName, password) async {
    String type = userName + ":" + password;
    var bytes = utf8.encode(type);

    var base64Str = base64.encode(bytes);

    await SharedPreferencesUtil.save(Config.USER_BASIC_CODE, base64Str);

    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": GithubConfig.CLIENT_ID,
      "client_secret": GithubConfig.CLIENT_SECRET
    };

    httpManager.clearAuthorization();

    var res = await httpManager.post(
        Api.getAuthorization(), json.encode(requestParams));

    var userInfo;
    if (res != null) {
      userInfo = getUserInfo(null);
    }
    return DataResult(userInfo, userInfo != null);
  }

  ///获取用户信息 null 表示获取当前用户
  static getUserInfo(userName) async {
    var uri;
    if (userName == null) {
      uri = Api.getMyUserInfo();
    } else
      uri = Api.getUserInfo(userName);

    var res = await httpManager.get(uri, null);

    if (res != null) {
      String starred = "---";
      if (res["type"] != "Organization") {
        var countRes = await getUserStaredCountNet(res["login"]);
        if (countRes != null && countRes.data != null) {
          starred = countRes.data;
        }
      }
      User user = User.fromJson(res);
      user.starred = starred;

      if (userName == null) {
        SharedPreferencesUtil.save(
            Config.USER_INFO, json.encode(user.toJson()));
      } else {
        //其他用户 单独保存
      }
      return DataResult(user, true);
    } else {
      return DataResult(res.data, false);
    }
  }

  /**
   * 在header中提起stared count
   */
  static getUserStaredCountNet(userName) async {
    String url = Api.userStar(userName, null) + "&per_page=1";
    var res = await httpManager.get(url, null);
    if (res != null && res.headers != null) {
      try {
        List<String> link = res.headers['link'];
        if (link != null) {
          int indexStart = link[0].lastIndexOf("page=") + 5;
          int indexEnd = link[0].lastIndexOf(">");
          if (indexStart >= 0 && indexEnd >= 0) {
            String count = link[0].substring(indexStart, indexEnd);
            return new DataResult(count, true);
          }
        }
      } catch (e) {
        print(e);
      }
    }
    return new DataResult(null, false);
  }

  static getUserRepos(userName, sort, page) async {
    String url = Api.userRepos(userName, sort) + Api.getPageParams("&", page);

    var res = await httpManager.get(url, null);
    if (res != null && res.length > 0) {
      List<Repository> list = List();
      for (int i = 0; i < res.length; i++) {
        var data = res[i];
        Repository repository = Repository.fromJson(data);
        list.add(repository);
      }

      return DataResult(list, true);
    } else
      return DataResult(null, false);
  }
}
