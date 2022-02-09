import 'package:flutter/material.dart';
import 'package:redditech/provider/user_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

class RedditWebView extends StatelessWidget {
  const RedditWebView(this.url, this.redirect, this.redirectPage, {Key? key})
      : super(key: key);

  final String url;
  final String redirect;
  final String redirectPage;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (_) => NavigationDecision.prevent,
      onPageFinished: (String urlEnd) {
        if (urlEnd.startsWith(redirect)) {
          context.read<UserProvider>().updateToken(
              Uri.dataFromString(urlEnd).queryParameters['code'].toString());
          Navigator.popAndPushNamed(context, redirectPage);
        }
      },
    );
  }
}
