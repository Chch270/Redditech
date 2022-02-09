class Tuple<T1, T2> {
  T1 item1;
  T2 item2;

  Tuple(this.item1, this.item2);
}

class UserPref {
  final Tuple<String, bool> over18 = Tuple('over_18', false);
  final Tuple<String, bool> searchIncludeNSFW =
      Tuple('search_include_over_18', false);
  final Tuple<String, bool> enableFollower = Tuple('enable_followers', false);
  final Tuple<String, bool> emailPrivate =
      Tuple('email_private_message', false);
  final Tuple<String, bool> usernameMention =
      Tuple('email_username_mention', false);
  final Tuple<String, bool> emailMessage = Tuple('email_messages', false);
  final Tuple<String, bool> publicVotes = Tuple('public_votes', false);

  void update(Map<String, dynamic> json) {
    over18.item2 = (json[over18.item1] ?? Tuple('', false)) as bool;
    searchIncludeNSFW.item2 =
        (json[searchIncludeNSFW.item1] ?? Tuple('', false)) as bool;
    usernameMention.item2 =
        (json[usernameMention.item1] ?? Tuple('', false)) as bool;
    enableFollower.item2 =
        (json[enableFollower.item1] ?? Tuple('', false)) as bool;
    emailPrivate.item2 = (json[emailPrivate.item1] ?? Tuple('', false)) as bool;
    emailMessage.item2 = (json[emailMessage.item1] ?? Tuple('', false)) as bool;
    publicVotes.item2 = (json[publicVotes.item1] ?? Tuple('', false)) as bool;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map[over18.item1] = over18.item2;
    map[usernameMention.item1] = usernameMention.item2;
    map[enableFollower.item1] = enableFollower.item2;
    map[searchIncludeNSFW.item1] = searchIncludeNSFW.item2;
    map[emailMessage.item1] = emailMessage.item2;
    map[publicVotes.item1] = publicVotes.item2;
    return map;
  }
}
