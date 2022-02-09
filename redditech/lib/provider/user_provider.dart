import 'package:flutter/material.dart';
import 'package:redditech/model/subreddit.dart';
import 'package:redditech/model/user.dart';
import 'package:redditech/utils/api_request.dart';
import 'package:redditech/model/token.dart';
import 'package:redditech/utils/api_user.dart';
import 'package:redditech/utils/api_subreddit.dart';
import 'package:redditech/utils/struct_utils.dart';
import 'package:redditech/store/store.dart';

class UserProvider with ChangeNotifier {
  User user = User.defaultUser();
  Pair flux = Pair([], "");
  List<Subreddit> searchSub = [];
  Subreddit subreddit = Subreddit();
  Tokens tokens = Tokens();
  APIUser userAPI = APIUser();
  APISubreddit subAPI = APISubreddit();
  List<String> recentSearch = [];

  void updateToken(String token) {
    APIRequest().login(token).then((value) {
      tokens.update(value);
      Storage().storeValue('refresh_token', value['refresh_token']);
      doAllShit();
    });
  }

  void doAllShit() {
    updateUser();
    updateFlux('hot', '');
    updatePrefs();
  }

  void refreshToken(String refresh) {
    APIRequest().refresh(refresh).then((value) {
      tokens.update(value);
      notifyListeners();
    });
  }

  void updateUser() {
    userAPI.getUser(tokens.accessToken).then((value) {
      user.update(value);
      updatePrefs();
    });
  }

  void updatePrefs() {
    userAPI.getPrefs(tokens.accessToken).then((value) {
      user.prefs.update(value);
      notifyListeners();
    });
  }

  void patchPrefs() {
    userAPI.patchPrefs(tokens.accessToken, user.prefs.toMap()).then((value) {
      user.prefs.update(value);
      notifyListeners();
    });
  }

  void updateFlux(String section, String subreddit) {
    if (subreddit.isEmpty) {
      subAPI.getUserFlux(tokens.accessToken, section, flux.right).then((res) {
        flux.right = res['data']['after'];
        for (var value in res['data']['children']) {
          flux.left.add(Post(value['data']));
        }
        notifyListeners();
      });
    } else {
      subAPI
          .getSubredditFlux(tokens.accessToken, section, subreddit, flux.right)
          .then((res) {
        flux.right = res['data']['after'];
        for (var value in res['data']['children']) {
          flux.left.add(Post(value['data']));
        }
        notifyListeners();
      });
    }
  }

  void getSubreddit(String name) {
    subAPI.getSubredditAbout(tokens.accessToken, name).then((value) {
      subreddit = Subreddit.allFromJson(value['data']);
      notifyListeners();
    });
  }

  void votePost(int vote, String id) {
    subAPI.voteSubreddits(tokens.accessToken, vote, id).then((value) {
      for (Post it in flux.left) {
        if (it.id == id) {
          if (vote == 0) {
            it.score += it.vote == 1 ? -1 : 1;
          } else if (vote == 1) {
            it.score += it.vote == 1
                ? -1
                : it.vote == 0
                    ? 1
                    : 2;
          } else {
            it.score += it.vote == 1
                ? -2
                : it.vote == 0
                    ? -1
                    : 1;
          }
          it.vote = vote;
        }
      }
      notifyListeners();
    });
  }

  void searchSubreddits(String query) {
    subAPI.searchSubreddits(tokens.accessToken, query).then((value) {
      for (Map<String, dynamic> val in value['subreddits']) {
        searchSub.add(Subreddit.fromjson(val));
      }
      notifyListeners();
    });
  }

  void subscribeSubreddit(String name, String sub) {
    subAPI.subToSubreddit(tokens.accessToken, name, sub).then((value) {
      subreddit.subscribed = sub == 'sub' ? 1 : 0;
      notifyListeners();
    });
  }
}
