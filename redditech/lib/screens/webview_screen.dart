import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:redditech/widgets/reddit_webview.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RedditWebView(
          'https://www.reddit.com/api/v1/authorize.compact?client_id=XRDP9QgaPoBPFZeTn7TL-w&response_type=code&state=a&redirect_uri=http://localhost/my_redirect&duration=permanent&scope=identity edit history mysubreddits privatemessages read save submit subscribe vote account',
          'http://localhost/my_redirect',
          '/home',
        ),
      ),
    );
  }
}
