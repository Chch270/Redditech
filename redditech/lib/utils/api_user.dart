import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:redditech/utils/api_request.dart';

class APIUser extends APIRequest {
  APIUser();

  Future<Map<String, dynamic>> getUser(String accessToken) async {
    try {
      final Response<dynamic> res = await dioRequest.get(
          '$requestAPI/api/v1/me',
          options: Options(
              method: 'GET',
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                'Authorization': 'bearer ' + accessToken,
                'User-Agent': userAgent
              }));
      res.data["icon_img"] =
          res.data["icon_img"].toString().split(".png")[0] + '.png';
      return (res.data);
    } catch (e) {
      throw Exception('Failed to load user ' + e.toString());
    }
  }

  Future<dynamic> getPrefs(String accessToken) async {
    try {
      final Response<dynamic> res = await dioRequest.get(
          '$requestAPI/api/v1/me/prefs',
          options: Options(
              method: 'GET',
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                'Authorization': 'bearer ' + accessToken,
                'User-Agent': userAgent
              }));
      return res.data;
    } catch (e) {
      throw Exception('Failed to get user prefs ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> patchPrefs(
      String accessToken, Map<String, dynamic> prefs) async {
    try {
      final Response<dynamic> res = await dioRequest.patch(
          '$requestAPI/api/v1/me/prefs',
          data: json.encode(prefs),
          options: Options(
              method: 'PATCH',
              contentType: Headers.jsonContentType,
              headers: {
                'Authorization': 'bearer ' + accessToken,
                'User-Agent': userAgent
              }));
      return res.data;
    } catch (e) {
      throw Exception('Failed to patch user prefs ' + e.toString());
    }
  }
}
