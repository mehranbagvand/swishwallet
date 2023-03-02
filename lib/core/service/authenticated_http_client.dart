import 'dart:convert';
import 'package:get/get.dart';
import '../../auth/data/data_sources/auth_local_storage.dart';
import '../errors/api_call_exception.dart';
import '../utils/utils.dart';
import 'http_client.dart';

class CFAuthenticatedClient extends HttpClient {
  AuthLocalStorage authLocalStorage;

  CFAuthenticatedClient(this.authLocalStorage,
      {String host = DEFAULT_HOST, int? port, String protocol = DEFAULT_PROTOCOL,
        String prefix = DEFAULT_APIS_PREFIX})
      : super(host: host, port: port, protocol: protocol, prefix: prefix) {
        // var newTokens = authLocalStorage.getTokens();
        // logger.d("initial tokens are :${newTokens?.toJson()}");
        // httpClient.addAuthenticator(_requestModifier);
  }

  @override
  Future<Response> post(String api, Map<String, dynamic> body, {Map<String, String>? headers, Map<String, dynamic>? query, bool? isNotRemove}) async {
    headers = _addAccessToken(headers);
    Response response;
    try {
      response = await super.post(api, body, headers: headers, query: query, isNotRemove: isNotRemove);
      return response;
    } on UnauthorizedError {
      await _renewAccessToken();
      headers = _addAccessToken(headers);
      response = await super.post(api, body, headers: headers, query: query, isNotRemove: isNotRemove);
      return response;
    }
    // throw Exception("Didn't work with renewed access token");
  }

  @override
  Future<Response> postFormData(String api, dynamic body, {Map<String, String>? headers, Map<String, dynamic>? query, bool? isNotRemove}) async {
    headers = _addAccessToken(headers);
    Response response;
    try {
      response = await super.postFormData(api, body, headers: headers, query: query, isNotRemove: isNotRemove);
      return response;
    } on UnauthorizedError {
      await _renewAccessToken();
      headers = _addAccessToken(headers);
      response = await super.postFormData(api, body, headers: headers, query: query, isNotRemove: isNotRemove);
      return response;
    }
    // throw Exception("Didn't work with renewed access token");
  }

  @override
  Future<Response> get(String api, {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    headers = _addAccessToken(headers);
    //logger.d("Headers:${jsonEncode(headers)}");
    Response response;
    try {
      response = await super.get(api, headers: headers, query: query);
      return response;
    } on UnauthorizedError {
      await _renewAccessToken();
      headers = _addAccessToken(headers);
      response = await super.get(api, headers: headers, query: query);
      return response;
    }
    // throw Exception("Didn't work with renewed access token");
  }

  @override
  Future<Response> delete(String api, {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    headers = _addAccessToken(headers);
    Response response;
    try {
      response = await super.delete(api, headers: headers, query: query);
      return response;
    } on UnauthorizedError {
      await _renewAccessToken();
      headers = _addAccessToken(headers);
      response = await super.delete(api, headers: headers, query: query);
      return response;
    }
    // throw Exception("Didn't work with renewed access token");
  }

  @override
  Future<Response> put(String api, Map<String, dynamic> body, {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    headers = _addAccessToken(headers);
    Response response;
    try {
      response = await super.put(api, body, headers: headers, query: query);
      return response;
    } on UnauthorizedError {
      await _renewAccessToken();
      headers = _addAccessToken(headers);
      response = await super.put(api, body, headers: headers, query: query);
      return response;
    }
    // throw Exception("Didn't work with renewed access token");
  }

  @override
  Future<Response> patch(String api, Map<String, dynamic> body, {Map<String, String>? headers, Map<String, dynamic>? query, bool? isNotRemove}) async {
    headers = _addAccessToken(headers);
    Response response;
    try {
      response = await super.patch(api, body, headers: headers, query: query, isNotRemove: isNotRemove);
      return response;
    } on UnauthorizedError {
      await _renewAccessToken();
      headers = _addAccessToken(headers);
      response = await super.patch(api, body, headers: headers, query: query, isNotRemove: isNotRemove);
      return response;
    }
    // throw Exception("Didn't work with renewed access token");
  }

  @override
  Future<Response> patchFormData(String api, dynamic body, {Map<String, String>? headers, Map<String, dynamic>? query, bool? isNotRemove}) async {
    headers = _addAccessToken(headers);
    Response response;
    try {
      response = await super.patchFormData(api, body, headers: headers, query: query, isNotRemove: isNotRemove);
      return response;
    } on UnauthorizedError {
      await _renewAccessToken();
      headers = _addAccessToken(headers);
      response = await super.patchFormData(api, body, headers: headers, query: query, isNotRemove: isNotRemove);
      return response;
    }
    // throw Exception("Didn't work with renewed access token");
  }

  Map<String, String> _addAccessToken(Map<String, String>? headers){
    headers = headers ?? <String, String>{};
    String? token = (authLocalStorage.getTokens())?.accessToken;
    headers['Authorization'] = "Bearer ${token?? ""}";
    return headers;
  }

  _renewAccessToken() async {
    String refreshToken = (authLocalStorage.getTokens())!.refreshToken;
    var response = await super.post("account/refresh", <String, String>{"refresh": refreshToken,});
    String newAccessToken = jsonDecode(response.body)["access"];
    var newTokens = authLocalStorage.getTokens()!.copyWith(accessToken: newAccessToken);
    logger.d("New access token is :${newTokens.accessToken}");
    await authLocalStorage.saveTokens(newTokens);
    await 1.delay();
    return true;
  }
}
