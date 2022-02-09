import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redditech/model/subreddit.dart';
import 'package:redditech/provider/user_provider.dart';
import 'package:redditech/utils/api_subreddit.dart';
import 'package:redditech/widgets/sub_container.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'search_screen',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.italic,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    context.read<UserProvider>().flux.clear();
    context.read<UserProvider>().updateFlux('hot', '');
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty &&
        !context.read<UserProvider>().recentSearch.contains(query)) {
      context.read<UserProvider>().recentSearch.insert(0, query);
      if (context.read<UserProvider>().recentSearch.length > 10) {
        context.read<UserProvider>().recentSearch.removeLast();
      }
    }
    return SearchSubs(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList =
        query.isEmpty ? context.read<UserProvider>().recentSearch : [];
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.search),
        title: TextButton(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              suggestionList[index],
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 20,
              ),
            ),
          ),
          onPressed: () {
            query = suggestionList[index];
            context.read<UserProvider>().recentSearch.removeAt(index);
            context.read<UserProvider>().recentSearch.insert(0, query);
          },
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

class SearchSubs extends StatefulWidget {
  const SearchSubs({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  _SearchSubsState createState() => _SearchSubsState();
}

class _SearchSubsState extends State<SearchSubs> {
  @override
  Widget build(BuildContext context) {
    final Future<Map<String, dynamic>> _json =
        Future<Map<String, dynamic>>.delayed(
      const Duration(seconds: 1),
      () {
        return APISubreddit().searchSubreddits(
            context.read<UserProvider>().tokens.accessToken, widget.query);
      },
    );
    return FutureBuilder<Map<String, dynamic>>(
      future: _json,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          List<Subreddit> list = List.from(
              (snapshot.data!['subreddits'] as List<dynamic>).map<Subreddit>(
                  (dynamic e) =>
                      Subreddit.fromjson(e as Map<String, dynamic>)));
          return SubListWidget(list: list);
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
}

class SubListWidget extends StatelessWidget {
  const SubListWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Subreddit> list;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.grey[400]),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Subreddit sub = list[index];
                      return SubContainer(sub: sub);
                    },
                    childCount: list.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
