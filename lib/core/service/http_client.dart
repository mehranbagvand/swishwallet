import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart' as g;
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';
import '../errors/api_call_exception.dart';
import '../utils/ui/ui_util.dart';
import '../utils/utils.dart';
import 'check_connection.dart';

class HttpClient {
  final String host;
  final int? port;
  final String protocol;
  final String prefix;

  late dio.Dio _client;

  dio.Dio get httpClient => _client;

  @mustCallSuper
  HttpClient(
      {this.host = DEFAULT_HOST,
      int? port,
      this.protocol = DEFAULT_PROTOCOL,
      this.prefix = DEFAULT_APIS_PREFIX})
      : port = port ?? DEFAULT_PORT {
    _client = dio.Dio();
    _client.options.baseUrl = baseUrl;
  }

  String get baseUrl {
    String initialBaseUrl = "$protocol://$host";
    String portPostfix = port != null ? ":$port" : "";
    return "$initialBaseUrl$portPostfix/$prefix/";
  }

  Future<g.Response> post(String api, Map<String, dynamic> body,
      {Map<String, String>? headers, Map<String, dynamic>? query, bool? isNotRemove}) async {
    query?.removeNullEntries();
    if(isNotRemove!=true) {
      logger.d("remove Null Entries");
      body.removeNullEntries();
    }

    headers = _modifyHeaders(headers);
    var response = await _client
        .post("$api/", data: body, options: dio.Options(headers: headers), queryParameters: query)
        .timeout(const Duration(seconds: 40), onTimeout: _onTimeOut).
    onError((dio.DioError error, stackTrace)async{
      return dio.Response(requestOptions: error.requestOptions,
          data: error.response?.data, statusMessage: error.message,headers: error.response?.headers, statusCode:error.response?.statusCode);
    });
   var res=convert(response);
    _logRequest("${_client.options.baseUrl}$api""/", res,
        query: query, requestBody: body);
    _checkResponse(res);
    return res;
  }
  Future<g.Response> postFormData(String api, dynamic body,
      {Map<String, String>? headers, Map<String, dynamic>? query, bool? isNotRemove}) async {
    headers = _modifyHeaders(headers);
    var response = await _client
        .post("$api/", data: body, options: dio.Options(headers: headers), queryParameters: query)
        .timeout(const Duration(seconds: 40), onTimeout: _onTimeOut).
    onError((dio.DioError error, stackTrace)async{
      return dio.Response(requestOptions: error.requestOptions,
          data: error.response?.data, statusMessage: error.message,headers: error.response?.headers, statusCode:error.response?.statusCode);
    });
   var res= convert(response);
    _checkResponse(res);
    return res;
  }


  g.Response convert(dio.Response response){
    var a = g.Response(
        body: jsonEncode(response.data),
        bodyString: jsonEncode(response.data),
        statusCode:response.statusCode, request: Request(url: response.requestOptions.uri, headers: {}, method: response.requestOptions.method));
    return a;
  }

  dio.Response _onTimeOut() {
    logger.e("Timeout occurred");
    return dio.Response(requestOptions: dio.RequestOptions(path: ''));
  }

  Future<g.Response> get(String api,
      {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    query?.removeNullEntries();
    var response = await _client.get("$api/", options:dio.Options(headers: headers), queryParameters: query).
    onError((dio.DioError error, stackTrace)async{
      return dio.Response(requestOptions: error.requestOptions,
          data: error.response?.data, statusMessage: error.message,headers: error.response?.headers, statusCode:error.response?.statusCode);
    });
    var res=convert(response);
    _logRequest("${_client.options.baseUrl}$api/", res, query: query, requestHeader: headers);
    await _checkResponse(res);
    return res;
  }
  Future<g.Response> patch(String api, Map<String, dynamic> body,
      {Map<String, String>? headers, Map<String, dynamic>? query, bool? isNotRemove}) async {
    query?.removeNullEntries();
    if(isNotRemove!=true) {
      logger.d("remove Null Entries");
      body.removeNullEntries();
      logger.d(body);
    }
    headers = _modifyHeaders(headers);
    var response = await _client.patch("$api/",data: body, options:dio.Options(headers: headers) , queryParameters: query).
    onError((dio.DioError error, stackTrace)async{
      return dio.Response(requestOptions: error.requestOptions,
          data: error.response?.data, statusMessage: error.message,headers: error.response?.headers, statusCode:error.response?.statusCode);
    });
    var res=convert(response);
    _logRequest("${_client.options.baseUrl}$api""/", res,
        query: query, requestBody: body ,requestHeader: headers);
    await _checkResponse(res);
    return res;
  }

  Future<g.Response> patchFormData(String api, dynamic body,
      {Map<String, String>? headers, Map<String, dynamic>? query, bool? isNotRemove}) async {
    headers = _modifyHeaders(headers);
    var response = await _client.patch("$api/",data: body, options:dio.Options(headers: headers) , queryParameters: query).
    onError((dio.DioError error, stackTrace)async{
      return dio.Response(requestOptions: error.requestOptions,
          data: error.response?.data, statusMessage: error.message,headers: error.response?.headers, statusCode:error.response?.statusCode);
    });
    var res=convert(response);
    await _checkResponse(res);
    return res;
  }


  Future<g.Response> delete(String api,
      {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    query?.removeNullEntries();
    var response = await _client.delete("$api/", options:dio.Options(headers: headers) , queryParameters: query).
    onError((dio.DioError error, stackTrace)async{
      return dio.Response(requestOptions: error.requestOptions,
          data: error.response?.data, statusMessage: error.message,headers: error.response?.headers, statusCode:error.response?.statusCode);
    });
    var res=convert(response);
    _logRequest("${_client.options.baseUrl}$api/", res, query: query, requestHeader: headers);
    await _checkResponse(res);
    return res;
  }

  Future<g.Response> put(String api, Map<String, dynamic> body,
      {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    headers = _modifyHeaders(headers);
    query?.removeNullEntries();
    body.removeNullEntries();
    var response = await _client.put("$api/",data: body, options:dio.Options(headers: headers) , queryParameters: query).
    onError((dio.DioError error, stackTrace)async{
      return dio.Response(requestOptions: error.requestOptions,
          data: error.response?.data, statusMessage: error.message,headers: error.response?.headers, statusCode:error.response?.statusCode);
    });
    var res=convert(response);
    _logRequest("${_client.options.baseUrl}$api""/", res,
        query: query, requestBody: body, requestHeader: headers);
    await _checkResponse(res);
    return res;
  }

  Map<String, String> _modifyHeaders(Map<String, String>? headers) {
    headers = headers ?? <String, String>{};
    headers["Content-type"] = "application/json; charset=utf-8";
    // headers["Content-type"] = "";
    // headers["content-length"] = "0";
    return headers;
  }

  _logRequest(String url, g.Response response, {Map? query, Map? requestBody,Map?  requestHeader}) {
    var text = """
    Request method:${response.request?.method}
    Request url:$url
    Request query:$query
    Request body:$requestBody
    Request header:$requestHeader
    ---------------------
    Response code:${response.statusCode}
    Response body:${response.bodyString}
     """;
    int status = response.statusCode??0;
    if(status>199&&status<300) return Logger().i(text);
    if(status>499&&status<600) return Logger().w(text);
    if(status>299&&status<500) return Logger().e(text);
    logger.d(text);
  }
  _checkResponse(g.Response response) async{
    if (response.statusCode == null){
      if(await check()) {
        AppSnackBar.snackBarE5xx("Error!", "The server is down, please try again later!");
      } else {
        AppSnackBar.snackBarE4xx("Error!","No internet access!");
      }
    }
    for (var error in ApiCallException.customApiErrors) {
      if (error.statusCode == response.statusCode) {
        error.reaction;
       throw error;
      }
    }
  }
}
