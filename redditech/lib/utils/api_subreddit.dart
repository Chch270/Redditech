import 'package:dio/dio.dart';
import 'package:redditech/utils/api_request.dart';

class APISubreddit extends APIRequest {
  APISubreddit();

  Future<Map<String, dynamic>> getUserFlux(
      String accessToken, String spec, String next) async {
    try {
      final Response<dynamic> res = await dioRequest.get('$requestAPI/$spec',
          queryParameters: {'limit': 10, 'after': next},
          options: Options(
              method: 'GET',
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                'Authorization': 'bearer ' + accessToken,
                'User-Agent': userAgent
              }));
      return res.data;
    } catch (e) {
      throw Exception('Failed to get user flux ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> getSubredditFlux(
      String accessToken, String spec, String name, String next) async {
    try {
      final Response<dynamic> res = await dioRequest.get(
          '$requestAPI/r/$name/$spec',
          queryParameters: {'limit': 10, 'after': next},
          options: Options(
              method: 'GET',
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                'Authorization': 'bearer ' + accessToken,
                'User-Agent': userAgent
              }));
      return res.data;
    } catch (e) {
      throw Exception('Failed to get subreddit flux ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> getSubredditAbout(
      String accessToken, String name) async {
    try {
      final Response<dynamic> res = await dioRequest.get(
          '$requestAPI/r/$name/about',
          options: Options(
              method: 'GET',
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                'Authorization': 'bearer ' + accessToken,
                'User-Agent': userAgent
              }));
      return res.data;
    } catch (e) {
      throw Exception('Failed to get subreddit about ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> searchSubreddits(
      String accessToken, String query) async {
    try {
      final Response<dynamic> res = await dioRequest.post(
          '$requestAPI/api/search_subreddits',
          queryParameters: {'query': query},
          options: Options(
              method: 'POST',
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                'Authorization': 'bearer ' + accessToken,
                'User-Agent': userAgent
              }));
      return res.data;
    } catch (e) {
      throw Exception('Failed to get user subreddit ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> voteSubreddits(
      String accessToken, int vote, String id) async {
    try {
      final Response<dynamic> res = await dioRequest.post(
          '$requestAPI/api/vote',
          queryParameters: {'dir': vote, 'id': id},
          options: Options(
              method: 'POST',
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                'Authorization': 'bearer ' + accessToken,
                'User-Agent': userAgent
              }));
      return res.data;
    } catch (e) {
      throw Exception('Failed to get user subreddit ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> subToSubreddit(
      String accessToken, String name, String action) async {
    try {
      final Response<dynamic> res = await dioRequest.post(
          '$requestAPI/api/subscribe',
          queryParameters: {'action': action, 'sr_name': name},
          options: Options(
              method: 'POST',
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                'Authorization': 'bearer ' + accessToken,
                'User-Agent': userAgent
              }));
      return res.data;
    } catch (e) {
      throw Exception('Failed to get user subreddit ' + e.toString());
    }
  }
}
