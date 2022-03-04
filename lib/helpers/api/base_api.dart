import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class BaseApi {
  String route;
  //192.168.0.3 // use computer if if debugging with real device
  //10.0.2.2 // android emulator

  static const baseUrl =
      "https://retkipaikka-backend.herokuapp.com/api"; //"http://192.168.0.4:3000/api";
  final int timeoutSeconds;
  static const Map<String, String> defaultHeaders = {
    HttpHeaders.contentTypeHeader: "application/json"
  };
  String? token;
  BaseApi(this.route, {this.timeoutSeconds = 10});

  Future<Map<String, dynamic>?> setAuthParam(
      Map<String, dynamic>? queryParams) async {
    // Only set token param if token is not present in query already
    if (queryParams != null && queryParams["token"] != null) return queryParams;
    Map<String, dynamic>? newParams = queryParams;
    if (token != null) {
      newParams = queryParams ?? <String, dynamic>{};

      newParams["token"] = token;
    }
    return newParams;
  }

  Future<Uri> buildUri(String path, Map<String, dynamic>? queryParams) async {
    var apiUrl = Uri.parse(BaseApi.baseUrl + route + path);
    Map<String, dynamic>? newParams = await setAuthParam(queryParams);
    if (newParams != null) {
      apiUrl = apiUrl.replace(queryParameters: newParams);
    }

    return apiUrl;
  }

  ///
  ///final queryParams = {
  //  'name': 'Pekka',
  //  'age': '18',
  //};
  ///
  Future<http.Response> get(String path, Map<String, dynamic>? queryParams,
      {Map<String, String> headers = defaultHeaders}) async {
    Uri parsedUri = Uri.parse(baseUrl + route + path);
    Map<String, dynamic>? newParams = await setAuthParam(queryParams);
    if (newParams != null) {
      parsedUri = parsedUri.replace(queryParameters: newParams);
    }

    //print(newParams);

    print("GET: " + parsedUri.toString());
    return http.get(parsedUri, headers: headers);
  }

  Future<http.Response> post(String path, Map<String, dynamic>? body,
      {Map<String, String> headers = defaultHeaders,
      Map<String, dynamic>? queryParams}) async {
    Uri parsedUri = Uri.parse(baseUrl + route + path);
    Map<String, dynamic>? newParams = await setAuthParam(queryParams);
    if (newParams != null) {
      parsedUri = parsedUri.replace(queryParameters: newParams);
    }
    String stringifiedBody = jsonEncode(body);
    setAuthParam(null);
    print("POST: " + parsedUri.toString());
    return http.post(parsedUri, headers: headers, body: stringifiedBody);
  }

  Future<http.Response> patch(String path, Map<String, dynamic>? body,
      {Map<String, String> headers = defaultHeaders,
      Map<String, dynamic>? queryParams}) async {
    Uri parsedUri = Uri.parse(baseUrl + route + path);
    Map<String, dynamic>? newParams = await setAuthParam(queryParams);
    if (newParams != null) {
      parsedUri = parsedUri.replace(queryParameters: newParams);
    }
    String stringifiedBody = jsonEncode(body);
    setAuthParam(null);
    print("POST: " + parsedUri.toString());
    return http.patch(parsedUri, headers: headers, body: stringifiedBody);
  }

  Future<http.Response> put(String path, Map<String, dynamic>? body,
      {Map<String, String> headers = defaultHeaders,
      Map<String, dynamic>? queryParams}) async {
    Uri parsedUri = Uri.parse(baseUrl + route + path);
    Map<String, dynamic>? newParams = await setAuthParam(queryParams);
    if (newParams != null) {
      parsedUri = parsedUri.replace(queryParameters: newParams);
    }
    String stringifiedBody = jsonEncode(body);
    setAuthParam(null);
    print("POST: " + parsedUri.toString());
    return http.put(parsedUri, headers: headers, body: stringifiedBody);
  }

  Future<http.Response> delete(String path, Map<String, dynamic>? body,
      {Map<String, String> headers = defaultHeaders,
      Map<String, dynamic>? queryParams}) async {
    Uri parsedUri = Uri.parse(baseUrl + route + path);
    Map<String, dynamic>? newParams = await setAuthParam(queryParams);
    if (newParams != null) {
      parsedUri = parsedUri.replace(queryParameters: newParams);
    }
    String stringifiedBody = jsonEncode(body);

    print("DELETE: " + parsedUri.toString());
    return http.delete(parsedUri, headers: headers, body: stringifiedBody);
  }

  // Future<String?> getSavedToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(kTokenKey);
  // }

  void setToken(String? token) {
    this.token = token;
  }

  dynamic parseResponse(http.Response res) {
    if (res.statusCode == 200) {
      return jsonDecode(res.body.toString());
    } else if (res.statusCode == 204) {
      return true;
    } else {
      switch (res.statusCode) {
        case 422:
        case 400:
          throw ("Error: Data sent was not valid!");
        case 500:
          throw ("Error: Failed to process request");
        case 401:
          throw ("Error: Login credentials are not valid!");
        case 403:
          throw ("Error: Token was not valid or user has no admin rights yet");
        default:
          throw ("Error: Network error");
      }
    }
  }
}
