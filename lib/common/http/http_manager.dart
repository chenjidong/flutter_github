import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_github/common/http/interceptors/header_interceptor.dart';
import 'package:flutter_github/common/http/interceptors/log_interceptor.dart';
import 'package:flutter_github/common/http/interceptors/token_interceptor.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = Dio();
  final TokenInterceptor _tokenInterceptor = TokenInterceptor();

  HttpManager() {
    _dio.interceptors.add(HeaderInterceptors());
    _dio.interceptors.add(_tokenInterceptor);
    _dio.interceptors.add(LogsInterceptors());
  }

  ///异步发起http网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置 默认 GET
  requestHttp(url, params, Map<String, dynamic> header, Options option) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 500);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = -1;

        ///网络超时或连接失败
      }
      return null;
    }
    return response.data;
  }

  get(url, params) async {
    return await requestHttp(url, params, null, null);
  }

  post(url, params) async {
    return await requestHttp(url, params, null, Options(method: "post"));
  }
}

final HttpManager httpManager = HttpManager();
