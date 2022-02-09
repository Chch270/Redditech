import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redditech/model/user_pref.dart';
import 'package:redditech/provider/user_provider.dart';
import 'package:redditech/widgets/appbar_widget.dart';
import 'package:redditech/widgets/user_settings_widget.dart';

class UserSettingScreen extends StatefulWidget {
  const UserSettingScreen({Key? key}) : super(key: key);

  @override
  _UserSettingScreenState createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (BuildContext contexte, UserProvider user, Widget? child) {
      return Scaffold(
        appBar: MyAppBar(
          color: const Color(0xFFFF5710),
          title: 'Settings',
          icon: const Icon(Icons.check),
          function: () => {Navigator.pop(context), user.patchPrefs()},
        ),
        body: buildbody(context, user.user.prefs),
      );
    });
  }

  Widget buildbody(BuildContext context, UserPref prefs) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SettingList(
          title: '-18 Preferences',
          custumList: [
            UserSettingWidget(
              title: prefs.over18.item1,
              state: prefs.over18.item2,
              onSwitch: (value) {
                setState(() {
                  prefs.over18.item2 = value;
                });
              },
            ),
            UserSettingWidget(
              title: prefs.searchIncludeNSFW.item1,
              state: prefs.searchIncludeNSFW.item2,
              onSwitch: (value) {
                setState(() {
                  prefs.searchIncludeNSFW.item2 = value;
                });
              },
            ),
          ],
        ),
        SettingList(
          title: 'Public Preferences',
          custumList: [
            UserSettingWidget(
              title: prefs.enableFollower.item1,
              state: prefs.enableFollower.item2,
              onSwitch: (value) {
                setState(() {
                  prefs.enableFollower.item2 = value;
                });
              },
            ),
            UserSettingWidget(
              title: prefs.publicVotes.item1,
              state: prefs.publicVotes.item2,
              onSwitch: (value) {
                setState(() {
                  prefs.publicVotes.item2 = value;
                });
              },
            ),
          ],
        ),
        SettingList(
          title: 'Email Preferences',
          custumList: [
            UserSettingWidget(
              title: prefs.usernameMention.item1,
              state: prefs.usernameMention.item2,
              onSwitch: (value) {
                setState(() {
                  prefs.usernameMention.item2 = value;
                });
              },
            ),
            UserSettingWidget(
              title: prefs.emailPrivate.item1,
              state: prefs.emailPrivate.item2,
              onSwitch: (value) {
                setState(() {
                  prefs.emailPrivate.item2 = value;
                });
              },
            ),
            UserSettingWidget(
              title: prefs.emailMessage.item1,
              state: prefs.emailMessage.item2,
              onSwitch: (value) {
                setState(() {
                  prefs.emailMessage.item2 = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
