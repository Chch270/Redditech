import 'package:flutter/material.dart';
import 'package:redditech/model/subreddit.dart';
import 'package:redditech/screens/subreddit_screen.dart';
import 'package:redditech/widgets/profile_avatar_widget.dart';

class SubContainer extends StatelessWidget {
  const SubContainer({
    Key? key,
    required this.sub,
  }) : super(key: key);

  final Subreddit sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  child: SubPreview(sub: sub),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SubredditScreen(subName: sub.name)))
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubPreview extends StatelessWidget {
  const SubPreview({
    Key? key,
    required this.sub,
  }) : super(key: key);

  final Subreddit sub;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
            imageUrl: sub.imgIcon != ""
                ? sub.imgIcon
                : "https://www.redditstatic.com/avatars/defaults/v2/avatar_default_1.png"),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sub.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${sub.subscribers} members",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
