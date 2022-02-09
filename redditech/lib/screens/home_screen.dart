import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:redditech/model/filter_model.dart';
import 'package:redditech/provider/user_provider.dart';
import 'package:redditech/model/subreddit.dart';
import 'package:redditech/widgets/post_container_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int loading = 0;
  Filter pickedFilter = filterList[0];

  void fetchData() {
    setState(() {
      loading = -1;
    });
    context.read<UserProvider>().updateFlux(pickedFilter.title, '');
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
                    user.updateFlux(pickedFilter.title, '');
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

class Item extends StatefulWidget {
  const Item({
    Key? key,
    required this.filter,
    required this.onSelected,
    required this.isSelected,
  }) : super(key: key);

  final Filter filter;
  final ValueChanged<bool> onSelected;
  final bool isSelected;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onSelected(true);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: widget.isSelected
                    ? Border.all(
                        width: 2.0,
                        color: Colors.orange.shade300,
                      )
                    : null,
              ),
              child: Icon(
                widget.filter.iconData,
                size: 32.0,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              widget.filter.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({
    Key? key,
    this.top,
    this.bottom,
  }) : super(key: key);

  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
