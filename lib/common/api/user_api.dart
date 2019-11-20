import 'dart:convert';

import 'package:flutter_github/common/api/api.dart';
import 'package:flutter_github/bean/repository.dart';
import 'package:flutter_github/bean/user.dart';
import 'package:flutter_github/bean/data_result.dart';
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
      User user = User.fromJson(res);

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
