import 'package:flutter/material.dart';
import 'package:redditech/widgets/login_button.dart';
// import 'package:redditech/store/store.dart';
// import 'package:redditech/provider/user_provider.dart';
// import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool yes = false;
    // Storage().getValue('refresh_token', String).then((value) {
    //   if (value != '' && value != 'null') {
    //     context.read<UserProvider>().refreshToken(value.toString());
    //     yes = true;
    //   }
    // });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildBackGround(context),
          SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildTitle(context, 'Redditech'),
                  const SizedBox(
                    height: 200.0,
                  ),
                  LoginButton(
                      () => {
                            Navigator.of(context)
                                .pushReplacementNamed('/webViewScreen'),
                          },
                      'assets/reddit_logo.png',
                      'Login with Reddit'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildBackGround(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFF5710),
            Color(0xFFFF5735),
            Color(0xFFFF3040),
            Color(0xFFFF3025),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
    );
  }
}
