import 'dart:convert';
import 'dart:io';

import 'package:derekshop_flutter_web/api/get_jwt_token_req.dart';
import 'package:derekshop_flutter_web/config.dart';
import 'package:derekshop_flutter_web/locator.dart';
import 'package:dio/dio.dart';

import 'dio_config.dart';
import 'get_jwt_token_res.dart';


class ApiClient {
  Dio dio = Dio();
  final String _p = TOKEN_P;

  ApiClient() {
    // Set default configs
    dio.options.baseUrl = API_URL;
    dio.options.contentType = Headers.jsonContentType;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    //Custom jsonDecodeCallback
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    // log
    dio.interceptors.add(LogInterceptor(responseBody: false)); //开启请求日志
  }

  Future<String> _getTokenString() async {
    final response = await dio.post("getJwtToken",
        data: GetJwtTokenReq(p: _p),
        options: Options(
          headers: {
            "Channel": "ccapp",
          },
        ));

    String token = GetJwtTokenRes.fromJson(response.data).token;
    return 'Bearer $token';
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: await _getTokenString()
          },
        ));
    return response.data;
  }

  Future<dynamic> post(String path, {data, Map<String, dynamic>? queryParameters}) async {
    final response = await dio.post(path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: await _getTokenString()
          },
        ));
    return response.data;
  }
}