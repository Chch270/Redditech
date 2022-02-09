import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserSettingWidget extends StatelessWidget {
  const UserSettingWidget({
    Key? key,
    required this.title,
    required this.state,
    required this.onSwitch,
  }) : super(key: key);

  final String title;
  final bool state;
  final Function(bool) onSwitch;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        trailing: CupertinoSwitch(
          value: state,
          onChanged: (bool value) => onSwitch(value),
        ),
        enabled: true,
        onTap: () => onSwitch(!state),
      ),
    );
  }
}

class SettingList extends StatelessWidget {
  const SettingList({
    Key? key,
    required this.title,
    this.custumList = const <UserSettingWidget>[],
  }) : super(key: key);

  final String title;
  final List<UserSettingWidget> custumList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, bottom: 6.0, top: 15.0),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return custumList[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 1);
          },
          itemCount: custumList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
        Divider(
          height: 1,
          thickness: 2,
        ),
      ],
    );
  }
}
