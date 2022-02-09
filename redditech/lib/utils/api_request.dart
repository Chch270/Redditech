import 'package:dio/dio.dart';

class APIRequest {
  Dio dioRequest = Dio();
  final String basicAPI = "https://www.reddit.com/api/v1";
  final String localRedir = "http://localhost/my_redirect";
  final String grantType = "authorization_code";
  final String auth = "Basic WFJEUDlRZ2FQb0JQRlplVG43VEwtdzo=";
  final String requestAPI = 'https://oauth.reddit.com';
  final String userAgent = "redditech by Epicture";

  APIRequest() {
    dioRequest.options.contentType = Headers.formUrlEncodedContentType;
  }

  Future<Map<String, dynamic>> login(String token) async {
    String loginToken = token.substring(0, token.length - 2);
    try {
      final Response<dynamic> res = await dioRequest.post(
          '$basicAPI/access_token?grant_type=$grantType&code=$loginToken&redirect_uri=$localRedir',
          options: Options(
              method: 'POST',
              contentType: Headers.formUrlEncodedContentType,
              headers: {'Authorization': auth}));
      return (res.data);
    } catch (e) {
      return (<String, dynamic>{});
    }
  }

  Future<dynamic> logout(String token, String type) async {
    try {
      final Response res = await dioRequest.post('$basicAPI/revoke_token',
          data: {'token': token, 'token_type_hint': type});
      return (res.data);
    } catch (e) {
      return (<String, dynamic>{});
    }
  }

  Future<Map<String, dynamic>> refresh(String refresh) async {
    try {
      final Response<dynamic> res = await dioRequest.post(
          '$basicAPI/access_token?grant_type=refresh_token&refresh_token=$refresh',
          options: Options(
              method: 'POST',
              contentType: Headers.formUrlEncodedContentType,
              headers: {'Authorization': auth}));
      return (res.data);
    } catch (e) {
      return (<String, dynamic>{});
    }
  }
}
