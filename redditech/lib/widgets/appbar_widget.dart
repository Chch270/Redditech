import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.title,
    required this.color,
    this.icon,
    this.function,
    this.leading,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  final Color color;
  final String title;
  final Icon? icon;
  final VoidCallback? function;
  final Widget? leading;

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.color,
      centerTitle: true,
      title: buildTitle(context),
      automaticallyImplyLeading: false,
      leading: widget.leading,
      actions: [
        if (widget.icon != null && widget.function != null) ...[
          buildButton(context),
        ]
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      widget.title,
      style: const TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return IconButton(
      iconSize: 28,
      padding: const EdgeInsets.all(12),
      onPressed: widget.function!,
      icon: widget.icon!,
    );
  }
}
