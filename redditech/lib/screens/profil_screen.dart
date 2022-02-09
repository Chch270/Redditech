import 'package:flutter/material.dart';
import 'package:redditech/provider/user_provider.dart';
import 'package:redditech/widgets/number_followers_widget.dart';
import 'package:redditech/widgets/profile_widget.dart';
import 'package:redditech/store/store.dart';

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (BuildContext ctx, UserProvider user, Widget? child) {
      return RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.black,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 20.0,
            ),
            ProfileWidget(
              imagePath: user.user.imagePath,
              onClicked: () => {},
            ),
            const SizedBox(height: 24),
            buildName(context, user),
            const SizedBox(height: 48),
            NumberFollowers(
              nbFollowers: user.user.numberFollowers,
              karma: user.user.karma,
            ),
            const SizedBox(height: 48),
            buildDescription(context, user),
            const SizedBox(height: 48),
            buildLoggoutButton(context, user),
          ],
        ),
        onRefresh: () => Future.delayed(const Duration(seconds: 1), () {
          user.updateUser();
        }),
      );
    });
  }

  Widget buildName(BuildContext context, UserProvider user) => Column(
        children: [
          Text(
            user.user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.user.redditName,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildDescription(BuildContext context, UserProvider user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.user.description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildLoggoutButton(BuildContext context, UserProvider user) {
    return Column(
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
          ),
          child: const Text(
            "Log Out",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            Storage().storeValue('refresh_token', '');
            Navigator.popAndPushNamed(context, '/loginScreen');
          },
        ),
      ],
    );
  }
}
