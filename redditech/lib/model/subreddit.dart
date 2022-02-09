import 'package:redditech/utils/struct_utils.dart';

class Post {
  String id = "";
  String idAuthor = "";
  String subName = "";
  String subImage =
      "https://www.redditstatic.com/avatars/defaults/v2/avatar_default_1.png";
  String title = "";
  String author = "";
  String imageUrl = "";
  String caption = "";
  int score = 0;
  int comments = 0;
  int vote = 0;

  Post(Map<String, dynamic> json) {
    update(json);
  }

  Post.txt(
    this.id,
    this.idAuthor,
    this.subName,
    this.subImage,
    this.title,
    this.author,
    this.imageUrl,
    this.caption,
    this.score,
    this.comments,
    this.vote,
  );

  update(Map<String, dynamic> json) {
    id = json['name'] ?? '';
    idAuthor = json['author_fullname'] ?? '';
    subName = json['subreddit_name_prefixed'] ?? '';
    title = json['title'] ?? '';
    author = json['author'] ?? '';
    imageUrl = getPathImg(json['url'] ?? '');
    caption = json['selftext'] ?? '';
    score = json['score'] ?? 0;
    comments = json['num_comments'] ?? 0;
    vote = json['likes'].toString() == 'null'
        ? 0
        : (1 + (-2 * (json['likes'].toString() == 'false' ? 1 : 0)));
  }
}

class Subreddit {
  String id = "";
  String name = "";
  String imgIcon = "";
  String description = "";
  String bannerImg = "";
  int subscribers = 0;
  int users = 0;
  int subscribed = 0;

  Subreddit();

  Subreddit.allFromJson(Map<String, dynamic> json) {
    updateAll(json);
  }

  Subreddit.fromjson(Map<String, dynamic> json) {
    update(json);
  }

  void update(Map<String, dynamic> json) {
    name = (json['name'] ?? "") as String;
    imgIcon = getPathImg(json['icon_img'] ?? "");
    description = (json['description'] ?? "") as String;
    subscribers = (json['subscriber_count'] ?? 0) as int;
    users = (json['active_user_count'] ?? 0) as int;
  }

  void updateAll(Map<String, dynamic> json) {
    id = (json['display_name_prefixed'] ?? "") as String;
    name = (json['title'] ?? "") as String;
    imgIcon = getPathImg(json['icon_img'] ?? "");
    description = (json['public_description'] ?? "") as String;
    bannerImg = getPathImg(json['banner_background_image'] ?? "");
    subscribers = (json['subscribers'] ?? 0) as int;
    users = (json['active_user_count'] ?? 0) as int;
    if (json['user_is_subscriber']) {
      subscribed = 1;
    } else {
      subscribed = 0;
    }
    // subscribed = (json['user_is_subscriber'] ?? 0) as int;
  }
}
