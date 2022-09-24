import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/helpers/shared_preferences_helper.dart';

class BaseApi {
  String route;
  //192.168.0.3 // use computer if if debugging with real device
  //10.0.2.2 // android emulator

  static const String baseUrl = kBaseUrl;

  static const Map<String, String> defaultHeaders = {
    HttpHeaders.contentTypeHeader: "application/json"
  };

  BaseApi(this.route);

  Future<Map<String, dynamic>?> setAuthParam(
      Map<String, dynamic>? queryParams) async {
    // Only set token param if token is not present in query already
    if (queryParams != null && queryParams["access_token"] != null) {
      return queryParams;
    }
    Map<String, dynamic>? newParams = queryParams;
    String? token = await SharedPreferencesHelper.getSavedToken();
    if (token != null) {
      newParams = queryParams ?? <String, dynamic>{};

      newParams["access_token"] = token;
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

    if (kDebugMode) {
      print("GET: $parsedUri");
    }
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
    //setAuthParam(null);
    if (kDebugMode) {
      print("POST: $parsedUri");
    }
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
    //setAuthParam(null);
    if (kDebugMode) {
      print("PATCH: $parsedUri");
    }
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
    //setAuthParam(null);
    if (kDebugMode) {
      print("POST: $parsedUri");
    }
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

    if (kDebugMode) {
      print("DELETE: $parsedUri");
    }
    return http.delete(parsedUri, headers: headers, body: stringifiedBody);
  }

  // Future<String?> getSavedToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(kTokenKey);
  // }

  dynamic parseResponse(http.Response res) {
    if (res.statusCode == 200) {
      return jsonDecode(res.body.toString());
    } else if (res.statusCode == 204) {
      return true;
    } else {
      switch (res.statusCode) {
        case 422:
        case 400:
          throw ("Virhe: Lähetetty data ei ollut oikean muotoista!");
        case 500:
          throw ("Virhe: Kutsun prosessointi epäonnistui");
        case 401:
          throw ("Virhe: Väärä sähköposti tai salasana!");
        case 403:
          throw ("Virhe: Tunniste ei ole validi tai käyttäjällä ei ole vielä admin-oikeuksia!");
        default:
          throw ("Virhe: Verkkovirhe!");
      }
    }
  }
}
