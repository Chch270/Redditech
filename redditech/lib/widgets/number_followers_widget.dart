import 'package:flutter/material.dart';

class NumberFollowers extends StatelessWidget {
  final int nbFollowers;
  final int karma;

  const NumberFollowers({
    Key? key,
    required this.nbFollowers,
    required this.karma,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildBox(context, nbFollowers, 'followers'),
        buildDivider(),
        buildBox(context, karma, 'karma')
      ],
    );
  }

  Widget buildBox(BuildContext context, int value, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const VerticalDivider(
      width: 100,
    );
  }
}
