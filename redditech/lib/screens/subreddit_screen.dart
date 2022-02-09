import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redditech/model/subreddit.dart';
import 'package:redditech/provider/user_provider.dart';
import 'package:redditech/utils/api_subreddit.dart';
import 'package:redditech/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:redditech/widgets/profile_avatar_widget.dart';
import 'package:redditech/model/filter_model.dart';
import 'package:redditech/widgets/post_container_widget.dart';
import 'package:redditech/screens/home_screen.dart';

class SubredditScreen extends StatefulWidget {
  const SubredditScreen({
    Key? key,
    required this.subName,
  }) : super(key: key);

  final String subName;

  @override
  _SubredditScreenState createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<UserProvider>().flux.clear();
    return Consumer(
        builder: (BuildContext context, UserProvider user, Widget? child) {
      return Scaffold(
        appBar: MyAppBar(
          color: Colors.white,
          title: widget.subName,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
          ),
        ),
        body: SubRedditBody(subName: widget.subName),
      );
    });
  }
}

class SubRedditBody extends StatefulWidget {
  const SubRedditBody({
    Key? key,
    required this.subName,
  }) : super(key: key);

  final String subName;
  static const double radius = 50.0;
  static const double bannerSize = 120.0;

  @override
  State<SubRedditBody> createState() => _SubRedditBodyState();
}

class _SubRedditBodyState extends State<SubRedditBody> {
  final double topMarge = SubRedditBody.bannerSize - SubRedditBody.radius;

  late Future<Map<String, dynamic>> _json;

  @override
  void initState() {
    _json = APISubreddit().getSubredditAbout(
        context.read<UserProvider>().tokens.accessToken, widget.subName);
    context.read<UserProvider>().updateFlux('hot', widget.subName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _json,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          Subreddit sub = Subreddit.allFromJson(snapshot.data!['data']);
          return Column(
            children: [
              buildTop(sub),
              buildContent(context, sub),
              Expanded(
                child: PostList(sub: sub),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Stack buildTop(Subreddit sub) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: SubRedditBody.bannerSize / 2),
          child: buildCoverImage(sub),
        ),
        Positioned(
          top: topMarge,
          child: ProfileAvatar(
            imageUrl: sub.imgIcon.isNotEmpty
                ? sub.imgIcon
                : "https://www.redditstatic.com/avatars/defaults/v2/avatar_default_1.png",
            radius: SubRedditBody.radius,
          ),
        ),
      ],
    );
  }

  Widget buildContent(BuildContext context, Subreddit sub) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          sub.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          "${sub.subscribers} members",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          sub.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16.0,
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<UserProvider>().subscribeSubreddit(
                sub.id, sub.subscribed != 1 ? 'sub' : 'unsub');

            setState(() {
              _json = APISubreddit().getSubredditAbout(
                  context.read<UserProvider>().tokens.accessToken,
                  widget.subName);
            });
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
          child: Text(
            sub.subscribed == 0 ? 'Subscribe' : 'Unsubscribe',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
            ),
          ),
        ),
        const Divider(thickness: 2),
      ],
    );
  }

  Widget buildCoverImage(Subreddit sub) {
    return Container(
      color: Colors.grey,
      child: sub.bannerImg.isNotEmpty && sub.bannerImg != ''
          ? CachedNetworkImage(
              imageUrl: sub.bannerImg,
              width: double.infinity,
              height: SubRedditBody.bannerSize,
              fit: BoxFit.cover,
            )
          : Container(
              width: double.infinity,
              height: 150.0,
              decoration: const BoxDecoration(
                color: Colors.brown,
              ),
            ),
    );
  }
}

class PostList extends StatefulWidget {
  const PostList({
    Key? key,
    required this.sub,
  }) : super(key: key);

  final Subreddit sub;

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final ScrollController _scrollController = ScrollController();
  int loading = 0;
  Filter pickedFilter = filterList[0];

  void fetchData() {
    setState(() {
      loading = -1;
    });
    context
        .read<UserProvider>()
        .updateFlux(pickedFilter.title, widget.sub.name);
    setState(() {
      loading = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          loading == 0) {
        fetchData();
      } else if (_scrollController.position.pixels <=
              _scrollController.position.minScrollExtent &&
          loading == 0) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context, UserProvider user, Widget? child) {
        if (user.flux.left.isNotEmpty) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.grey[400]),
                child: CustomScrollView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                      sliver: SliverToBoxAdapter(
                        child: buildSelectBar(user),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Post post = user.flux.left[index];
                            return PostContainer(post: post);
                          },
                          childCount: user.flux.left.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (loading < 0) ...[
                const LoadingCircle(bottom: 0),
              ] else if (loading > 0) ...[
                const LoadingCircle(top: 0),
              ]
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Column buildSelectBar(UserProvider user) {
    return Column(
      children: [
        Container(
          height: 130,
          color: Colors.white,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                filterList.length,
                (index) => Item(
                  filter: filterList[index],
                  isSelected: filterList[index] == pickedFilter,
                  onSelected: (bool value) {
                    if (value) {
                      pickedFilter = filterList[index];
                    }
                    user.flux.clear();
                    user.updateFlux(pickedFilter.title, widget.sub.name);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
