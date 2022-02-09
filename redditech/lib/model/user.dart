import 'package:redditech/model/user_pref.dart';

class User {
  String name;
  String id;
  String imagePath;
  String redditName;
  String description;
  int numberFollowers;
  int karma;
  UserPref prefs = UserPref();

  User({
    required this.name,
    required this.id,
    required this.imagePath,
    required this.redditName,
    required this.description,
    required this.numberFollowers,
    required this.karma,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = ((json['subreddit']['title'] != ''
            ? json['subreddit']['title']
            : json['name'])) as String,
        id = (json['id'] ?? '') as String,
        imagePath = (json['icon_img'] ?? '') as String,
        redditName =
            (json['subreddit']['display_name_prefixed'] ?? '') as String,
        description = (json['subreddit']['public_description'] ?? '') as String,
        numberFollowers = (json['subreddit']['subscribers'] ?? '') as int,
        karma = (json['total_karma'] ?? '') as int;

  User.defaultUser()
      : name = '',
        id = '',
        imagePath =
            'https://www.redditstatic.com/avatars/defaults/v2/avatar_default_1.png',
        redditName = '',
        description = '',
        numberFollowers = 0,
        karma = 0;

  void update(Map<String, dynamic> json) {
    name = ((json['subreddit']['title'] != ''
        ? json['subreddit']['title']
        : json['name'])) as String;
    id = (json['id'] ?? '') as String;
    imagePath = (json['icon_img'] ?? '') as String;
    redditName = (json['subreddit']['display_name_prefixed'] ?? '') as String;
    description = (json['subreddit']['public_description'] ?? '') as String;
    numberFollowers = (json['subreddit']['subscribers'] ?? '') as int;
    karma = (json['total_karma'] ?? '') as int;
  }
}
