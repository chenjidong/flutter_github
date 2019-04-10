import 'package:dio/dio.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/util/shared_preferences_util.dart';

/**
 * 授权 token 拦截器
 *
 */
class TokenInterceptor extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    // TODO: implement onRequest
    if (_token == null) {
      _token = await getToken();
    }
    options.headers['Authorization'] = _token;
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        _token = 'token ' + responseJson["token"];
        await SharedPreferencesUtil.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  getToken() async {
    return await SharedPreferencesUtil.get(Config.TOKEN_KEY);
  }

  cleanToken() {
    _token = null;
    SharedPreferencesUtil.remove(Config.TOKEN_KEY);
  }
}
