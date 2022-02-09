import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:redditech/widgets/profile_avatar_widget.dart';
import 'package:redditech/model/subreddit.dart';
import 'package:redditech/provider/user_provider.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

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
                _PostHeader(post: post),
                const SizedBox(height: 10.0),
                Text(
                  post.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                post.caption != ''
                    ? const SizedBox(height: 6.0)
                    : const SizedBox.shrink(),
                Text(post.caption),
                post.imageUrl != '' && post.imageUrl.isNotEmpty
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 6.0),
              ],
            ),
          ),
          post.imageUrl != '' && post.imageUrl.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl,
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostStats(post: post),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.subImage),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.subName,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    post.author,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
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

class _PostStats extends StatelessWidget {
  const _PostStats({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10.0),
                _PostButton(
                  icon: Icon(
                    Icons.arrow_circle_up_rounded,
                    color:
                        post.vote == 1 ? Colors.orange[600] : Colors.grey[600],
                    size: 30.0,
                  ),
                  onTap: () => context
                      .read<UserProvider>()
                      .votePost(post.vote == 1 ? 0 : 1, post.id),
                ),
                const SizedBox(width: 10.0),
                Text(
                  '${post.score}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(width: 6.0),
                _PostButton(
                  icon: Icon(
                    Icons.arrow_circle_down_rounded,
                    color:
                        post.vote == -1 ? Colors.grey[900] : Colors.grey[600],
                    size: 30.0,
                  ),
                  onTap: () => context
                      .read<UserProvider>()
                      .votePost(post.vote == -1 ? 0 : -1, post.id),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${post.comments}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                _PostButton(
                  icon: Icon(
                    Icons.comment,
                    color: Colors.grey[600],
                    size: 30.0,
                  ),
                  onTap: () => {},
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  const _PostButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 25.0,
          child: icon,
        ),
      ),
    );
  }
}
