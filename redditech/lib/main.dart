import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:redditech/provider/user_provider.dart';
import 'package:redditech/screens/home_page.dart';
import 'package:redditech/screens/profil_screen.dart';
import 'package:redditech/screens/login_screen.dart';
import 'package:redditech/screens/webview_screen.dart';
import 'package:redditech/screens/user_settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Redditech',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: '/loginScreen',
        routes: {
          '/home': (BuildContext context) => const HomePage(),
          '/loginScreen': (BuildContext context) => const LoginScreen(),
          '/webViewScreen': (BuildContext context) => const WebViewScreen(),
          '/profileScreen': (BuildContext context) => const ProfileScreen(),
          '/userSettings': (BuildContext context) => const UserSettingScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
